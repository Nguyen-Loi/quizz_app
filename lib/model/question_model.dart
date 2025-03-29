// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quizz/enum/question_type.dart';
import 'package:quizz/model/answer_model.dart';

class Question {
  final String questionId;
  final String content;
  final QuestionType type;
  final int points;
  Question({
    required this.questionId,
    required this.content,
    required this.type,
    required this.points,
  });
  final List<Answer> answers = [];

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  Question copyWith({
    String? questionId,
    String? content,
    QuestionType? type,
    int? points,
  }) {
    return Question(
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      type: type ?? this.type,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'content': content,
      'type': type.name,
      'points': points,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['questionId'] as String,
      content: map['content'] as String,
      type: QuestionType.fromMap(map['type'] as Map<String,dynamic>),
      points: map['points'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) => Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(questionId: $questionId, content: $content, type: $type, points: $points)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;
  
    return 
      other.questionId == questionId &&
      other.content == content &&
      other.type == type &&
      other.points == points;
  }

  @override
  int get hashCode {
    return questionId.hashCode ^
      content.hashCode ^
      type.hashCode ^
      points.hashCode;
  }
}
