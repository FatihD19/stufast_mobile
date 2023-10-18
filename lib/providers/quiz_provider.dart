import 'package:flutter/material.dart';
import 'package:stufast_mobile/services/quiz_service.dart';

import '../models/quiz_model.dart';

class QuizProvider with ChangeNotifier {
  List<QuizModel> _quizList = [];
  int _currentIndex = 0;

  List<QuizModel> get quizList => _quizList;
  int get currentIndex => _currentIndex;

  List<String> _selectedQuizId = [];
  List<String> _selectedAnswers = [];
  List<String> get selectedQuizId => _selectedQuizId;
  List<String> get selectedAnswers => _selectedAnswers;

  // Fungsi untuk mengatur daftar kuis
  // set quizList(List<QuizModel> quizList) {
  //   _quizList = quizList;
  //   notifyListeners();
  // }

  void setAnswer(String answer) {
    if (!_selectedQuizId.contains(_quizList[_currentIndex].quizId)) {
      _selectedQuizId.add("${_quizList[_currentIndex].quizId}");
      _selectedAnswers.add(answer);
    } else {
      final index =
          _selectedQuizId.indexOf("${_quizList[_currentIndex].quizId}");
      _selectedAnswers[index] = answer;
    }
  }

  Future<void> getQuiz(String id) async {
    try {
      List<QuizModel> quizList = await QuizService().getQuiz(id);
      _quizList = quizList;
    } catch (e) {
      print(e);
    }
  }

  // Fungsi untuk mengambil kuis berikutnya
  void nextQuestion() {
    if (_currentIndex < _quizList.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  // Fungsi untuk mengambil kuis sebelumnya
  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  // Fungsi untuk memeriksa apakah kuis saat ini adalah yang terakhir
  bool isLastQuestion() {
    return _currentIndex == _quizList.length - 1;
  }

  // void dispose() {
  //   super.dispose();
  //   _quizList = [];
  //   _currentIndex = 0;
  // }
}
