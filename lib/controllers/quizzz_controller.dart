import 'dart:convert';

import 'package:quizz/model/quiz_model.dart';
import 'package:flutter/services.dart';

class QuizzController {
  Future<List<QuizModel>> loadQuizzes() async {
    final String jsonString =
        await rootBundle.loadString('images/data/quiz.json');

    final Map<String, dynamic> jsonData =
        json.decode(jsonString) as Map<String, dynamic>;
    return List<QuizModel>.from(
      (jsonData['quizzes'] as List)
          .map((quiz) => QuizModel.fromMap(quiz as Map<String, dynamic>)),
    );
  }

  Future<QuizModel> loadQuizById(String quizId) async {
    final List<QuizModel> quizzes = await loadQuizzes();
    return quizzes.firstWhere((quiz) => quiz.quizId == quizId);
  }
}
