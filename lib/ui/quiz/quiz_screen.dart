import 'package:flutter/material.dart';
import 'package:flutter_futurama/data/meta_data.dart';
import 'package:flutter_futurama/extension/premitive_extension.dart';
import 'package:flutter_futurama/helper/dailog_helper.dart';
import 'package:flutter_futurama/ui/quiz/quiz_provider.dart';
import 'package:flutter_futurama/ui/quiz/user_quiz_answer.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => QuizProvider(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Quiz')),
          body: Consumer<QuizProvider>(builder: (context, state, child) {
            final quizesDataEvent = state.quizesDataEvent;
            if (quizesDataEvent is Error) {
              const Center(child: Text('Error'));
            } else if (quizesDataEvent is Data) {
              return Consumer<QuizProvider>(builder: (context, state, child) {
                final quizEvent = state.quizEvent;
                final userGivenAns = (quizEvent as Data<UserGivenAnswer>).data;
                final quiz = userGivenAns.quiz;
                return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsetsDirectional.only(top: 15, start: 14, end: 14),
                      child: Text('Question ${state.currentQuizIndex}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 22, fontStyle: FontStyle.normal, fontWeight: FontWeight.w800))),
                  Padding(
                      padding: const EdgeInsetsDirectional.only(top: 15, start: 14, end: 14),
                      child: Text(quiz.question, style: Theme.of(context).textTheme.bodySmall)),
                  Expanded(
                      child: SingleChildScrollView(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                          child: StatefulBuilder(
                              builder: (_, stateSetter) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: quiz.possibleAnswers
                                      .map((e) => RadioListTile(
                                          visualDensity: VisualDensity.compact,
                                          dense: true,
                                          title:
                                              Text(e, style: const TextStyle(fontSize: 15, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400)),
                                          value: e.fastHash,
                                          groupValue: userGivenAns.answer.fastHash,
                                          onChanged: (dynamic value) {
                                            if (value == null) return;
                                            stateSetter.call(() => userGivenAns.answer = e);
                                          }))
                                      .toList())))),
                  Center(
                      child: Consumer<QuizProvider>(
                          builder: (context, state, child) => Text(Provider.of<QuizProvider>(context, listen: false).howManyAnsweredCorrectContent,
                              textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall))),
                  const SizedBox(height: 15),
                  Center(
                      child: MaterialButton(
                          onPressed: () {
                            final DialogHelper dialog = DialogHelper.instance()..injectContext(context);
                            if (!Provider.of<QuizProvider>(context, listen: false).isUserSelectedOption) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text('Please select option first'), duration: Duration(seconds: 1)));
                            } else if (Provider.of<QuizProvider>(context, listen: false).isQuizComplete &&
                                Provider.of<QuizProvider>(context, listen: false).isAllAnswersAreCorrect) {
                              dialog.showQuizDialog('Whomp whomp... you win...');
                            } else if (Provider.of<QuizProvider>(context, listen: false).isQuizComplete &&
                                !Provider.of<QuizProvider>(context, listen: false).isAllAnswersAreCorrect) {
                              dialog.showQuizDialog('Whomp whomp... you lose...');
                            } else {
                              Provider.of<QuizProvider>(context, listen: false).nextQuiz();
                            }
                          },
                          color: Colors.blue,
                          child: const Text('Next')))
                ]);
              });
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          })),
    );
  }
}
