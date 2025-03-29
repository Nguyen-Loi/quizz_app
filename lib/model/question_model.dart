// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quizz/enum/question_type.dart';
import 'package:quizz/model/answer_model.dart';

class QuestionModel {
  final String questionId;
  final String content;
  final QuestionType type;
  final int points;
  QuestionModel({
    required this.questionId,
    required this.content,
    required this.type,
    required this.points,
  });
  final List<AnswerModel> answers = [];

  void addAnswer(AnswerModel answer) {
    answers.add(answer);
  }

  QuestionModel copyWith({
    String? questionId,
    String? content,
    QuestionType? type,
    int? points,
  }) {
    return QuestionModel(
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

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionId: map['questionId'] as String,
      content: map['content'] as String,
      type: QuestionType.valueOf(map['type'] as String),
      points: map['points'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(questionId: $questionId, content: $content, type: $type, points: $points)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.questionId == questionId &&
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
