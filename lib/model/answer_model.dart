// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnswerModel {
  final String answerId;
  final String content;
  final bool isCorrect;
  AnswerModel({
    required this.answerId,
    required this.content,
    required this.isCorrect,
  });

  AnswerModel copyWith({
    String? answerId,
    String? content,
    bool? isCorrect,
  }) {
    return AnswerModel(
      answerId: answerId ?? this.answerId,
      content: content ?? this.content,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answerId': answerId,
      'content': content,
      'isCorrect': isCorrect,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      answerId: map['answerId'] as String,
      content: map['content'] as String,
      isCorrect: map['isCorrect'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Answer(answerId: $answerId, content: $content, isCorrect: $isCorrect)';

  @override
  bool operator ==(covariant AnswerModel other) {
    if (identical(this, other)) return true;

    return other.answerId == answerId &&
        other.content == content &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode => answerId.hashCode ^ content.hashCode ^ isCorrect.hashCode;
}
