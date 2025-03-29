import 'dart:convert';

import 'package:quizz/model/question_model.dart';

class QuizModel {
  final String quizId;
  final String title;
  final int timeLimit;
  final DateTime createdAt;
  final List<QuestionModel> questions = [];
  
  QuizModel({
    required this.quizId,
    required this.title,
    required this.timeLimit,
    required this.createdAt,
  });


  QuizModel copyWith({
    String? quizId,
    String? title,
    int? timeLimit,
    DateTime? createdAt,
  }) {
    return QuizModel(
      quizId: quizId ?? this.quizId,
      title: title ?? this.title,
      timeLimit: timeLimit ?? this.timeLimit,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quizId': quizId,
      'title': title,
      'timeLimit': timeLimit,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizId: map['quizId'] as String,
      title: map['title'] as String,
      timeLimit: map['timeLimit'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Quiz(quizId: $quizId, title: $title, timeLimit: $timeLimit, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.quizId == quizId &&
      other.title == title &&
      other.timeLimit == timeLimit &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return quizId.hashCode ^
      title.hashCode ^
      timeLimit.hashCode ^
      createdAt.hashCode;
  }
}
