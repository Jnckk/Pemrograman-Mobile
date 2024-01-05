// ignore_for_file: file_names

import 'package:merdeka_quiz/Rengasdengklok/Rengas.dart';

class RengasController {
  final RengasModel _model = RengasModel();
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;

  Question getCurrentQuestion() {
    return _model.questions[_currentQuestionIndex];
  }

  bool isLastQuestion() {
    return _currentQuestionIndex == _model.questions.length - 1;
  }

  int getCurrentQuestionIndex() {
    return _currentQuestionIndex;
  }

  void nextQuestion() {
    if (!isLastQuestion()) {
      _currentQuestionIndex++;
    }
  }

  int get correctAnswers => _correctAnswers;
  void incrementCorrectAnswers() {
    _correctAnswers++;
  }

  final List<bool?> _answerResults = List.filled(5, null);

  List<bool?> get answerResults => _answerResults;

  void setAnswerResult(int index, bool isCorrect) {
    _answerResults[index] = isCorrect;
  }
}
