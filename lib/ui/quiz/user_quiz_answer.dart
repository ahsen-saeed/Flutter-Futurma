import 'package:flutter_futurama/ui/quiz/quiz.dart';

class UserGivenAnswer {
  final Quiz quiz;
  String answer;
  int groupValue;

  UserGivenAnswer._({required this.quiz, required this.answer, required this.groupValue});

  UserGivenAnswer.initial({required Quiz quiz}) : this._(quiz: quiz, answer: '', groupValue: -1);
}
