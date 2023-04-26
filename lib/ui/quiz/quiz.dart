class Quiz {
  final int id;
  final String question;
  final List<String> possibleAnswers;
  final dynamic correctAnswer;

  Quiz({required this.id, required this.question, required this.possibleAnswers, required this.correctAnswer});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final int id = json.containsKey('id') ? json['id'] as int? ?? -1 : -1;
    final String question = json.containsKey('question') ? json['question'] as String? ?? '' : '';
    final List<String> possibleAnswers =
        json.containsKey('possibleAnswers') ? (json['possibleAnswers'] as List<dynamic>).map((e) => e as String? ?? '').toList() : <String>[];
    final dynamic correctAnswer = json.containsKey('correctAnswer') ? json['correctAnswer'] : '';

    return Quiz(id: id, question: question, possibleAnswers: possibleAnswers, correctAnswer: correctAnswer);
  }

  @override
  String toString() {
    return 'Quiz{id: $id, question: $question, possibleAnswers: $possibleAnswers, correctAnswer: $correctAnswer}';
  }
}
