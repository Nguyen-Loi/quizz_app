import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quizz/model/quiz_model.dart';

class QuizzData {
  QuizzData._internal();
  static final QuizzData _instance = QuizzData._internal();
  
  static QuizzData get instance => _instance;

  List<QuizModel> _quizzes = [];
  
  List<QuizModel> getQuizzes() {
    return _quizzes;
  }

  Future<void> init() async {
    final String jsonString =
        await rootBundle.loadString('images/data/quiz.json');

    final Map<String, dynamic> jsonData =
        json.decode(jsonString) as Map<String, dynamic>;
    _quizzes = List<QuizModel>.from(
      (jsonData['quizzes'] as List)
          .map((quiz) => QuizModel.fromMap(quiz as Map<String, dynamic>)),
    );
  }
}