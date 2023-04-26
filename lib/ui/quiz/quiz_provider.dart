import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_futurama/data/meta_data.dart';
import 'package:flutter_futurama/ui/quiz/quiz.dart';
import 'package:flutter_futurama/ui/quiz/user_quiz_answer.dart';

class QuizProvider extends ChangeNotifier {
  final HttpClient _httpClient = HttpClient();
  final List<UserGivenAnswer> _answers = <UserGivenAnswer>[];
  DataEvent quizesDataEvent = const Loading();
  int currentQuizIndex = 0;
  DataEvent quizEvent = const Initial();

  int get totalQuizesLength {
    final dataEvent = quizesDataEvent;
    return dataEvent is Data ? (dataEvent.data as Iterable<Quiz>).length : -1;
  }

  void nextQuiz() {
    if (_answers.isEmpty) return;
    final userGivenAns = _answers[currentQuizIndex];
    quizEvent = Data<UserGivenAnswer>(data: userGivenAns);
    currentQuizIndex = currentQuizIndex + 1;
    notifyListeners();
  }

  String get howManyAnsweredCorrectContent {
    final totalCorrectAns = _answers.where((element) => element.answer == element.quiz.correctAnswer).length;
    return 'You have answered $totalCorrectAns of $totalQuizesLength correctly';
  }

  bool get isAllAnswersAreCorrect => _answers.where((element) => element.answer == element.quiz.correctAnswer).length == totalQuizesLength;

  bool get isQuizComplete => totalQuizesLength == currentQuizIndex;

  bool get isUserSelectedOption => _answers[currentQuizIndex - 1].answer.isNotEmpty;

  QuizProvider() {
    requestQuizes();
  }

  Future<void> requestQuizes() async {
    quizesDataEvent =const Loading();
    notifyListeners();
    try {
      final quizRequest = await _httpClient.getUrl(Uri.parse('https://api.sampleapis.com/futurama/questions'));
      final response = await quizRequest.close();
      final responseBody = json.decode(await response.transform(utf8.decoder).join());

      Iterable<Quiz> parseQuizes(dynamic responseBody) => (responseBody as List<dynamic>).map((e) => Quiz.fromJson(e));

      final quizes = await compute(parseQuizes, responseBody);
      quizesDataEvent = Data(data: quizes);
      notifyListeners();

      /// populate initially all the answers as empty so that user can give the answer and we update them.
      _populateTheUserInitialAnswers(Iterable.generate(quizes.length, (int index) => quizes.elementAt(index)));

      nextQuiz();
    } catch (_) {
      quizesDataEvent = Error(exception: Exception('User device is not connected to internet'));
      notifyListeners();
    }
  }

  void _populateTheUserInitialAnswers(Iterable<Quiz> quizes) => _answers.addAll(quizes.map((e) => UserGivenAnswer.initial(quiz: e)));
}
