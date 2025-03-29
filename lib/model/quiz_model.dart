// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:quizz/model/question_model.dart';

class QuizModel {
  final String quizId;
  final String title;
  final int timeLimit;
  final DateTime createdAt;
  final List<QuestionModel> questions;
  QuizModel({
    required this.quizId,
    required this.title,
    required this.timeLimit,
    required this.createdAt,
    required this.questions,
  });


  QuizModel copyWith({
    String? quizId,
    String? title,
    int? timeLimit,
    DateTime? createdAt,
    List<QuestionModel>? questions,
  }) {
    return QuizModel(
      quizId: quizId ?? this.quizId,
      title: title ?? this.title,
      timeLimit: timeLimit ?? this.timeLimit,
      createdAt: createdAt ?? this.createdAt,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quizId': quizId,
      'title': title,
      'timeLimit': timeLimit,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizId: map['quizId'] as String,
      title: map['title'] as String,
      timeLimit: map['timeLimit'] as int,
       createdAt: DateTime.parse(map['createdAt'] as String),
      questions: List<QuestionModel>.from(
        (map['questions'] as List).map<QuestionModel>(
        (x) => QuestionModel.fromMap(x as Map<String, dynamic>),
      ),
    ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizModel(quizId: $quizId, title: $title, timeLimit: $timeLimit, createdAt: $createdAt, questions: $questions)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.quizId == quizId &&
      other.title == title &&
      other.timeLimit == timeLimit &&
      other.createdAt == createdAt &&
      listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return quizId.hashCode ^
      title.hashCode ^
      timeLimit.hashCode ^
      createdAt.hashCode ^
      questions.hashCode;
  }
}
