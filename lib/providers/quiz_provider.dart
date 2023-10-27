import 'package:flutter/material.dart';
import 'package:stufast_mobile/services/quiz_service.dart';

import '../models/quiz_model.dart';

class QuizProvider with ChangeNotifier {
  List<QuizModel> _quizList = [];

  List<QuizModel> get quizList => _quizList;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<String> _selectedQuizId = [];
  List<String> _selectedAnswers = [];
  List<String> get selectedQuizId => _selectedQuizId;
  List<String> get selectedAnswers => _selectedAnswers;

  bool isAnswerSelected = false;
  bool? _quizPass;
  int? _quizScore;
  bool? get quizPass => _quizPass;
  int? get quizScore => _quizScore;

  void setAnswer(String answer) {
    if (!_selectedQuizId.contains(_quizList[_currentIndex].quizId)) {
      _selectedQuizId.add("${_quizList[_currentIndex].quizId}");
      _selectedAnswers.add(answer);
      isAnswerSelected = true;
    } else {
      final index =
          _selectedQuizId.indexOf("${_quizList[_currentIndex].quizId}");
      _selectedAnswers[index] = answer;
    }
    notifyListeners();
  }

  Future<void> getQuiz(String id) async {
    _selectedQuizId = [];
    _selectedAnswers = [];
    _currentIndex = 0;
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

  Future<void> submitQuiz(String id) async {
    try {
      final response =
          await QuizService().submitQuiz(id, selectedQuizId, selectedAnswers);

      final pass = response['pass'] as bool;
      final score = response['score'] as int;

      // Lakukan apa pun dengan hasilnya, seperti menampilkan pesan atau mengganti tampilan
      // Misalnya, Anda bisa memasukkan ini ke dalam variabel untuk ditampilkan di UI
      _quizPass = pass;
      _quizScore = score;

      notifyListeners();
    } catch (e) {
      // Tangani kesalahan jika ada
      print('Error submitting quiz: $e');
    }
  }

  // void dispose() {
  //   super.dispose();
  //   _quizList = [];

  // }
}
