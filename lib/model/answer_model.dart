// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Answer {
  final String answerId;
  final String content;
  final bool isCorrect;
  Answer({
    required this.answerId,
    required this.content,
    required this.isCorrect,
  });
  

  Answer copyWith({
    String? answerId,
    String? content,
    bool? isCorrect,
  }) {
    return Answer(
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

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answerId: map['answerId'] as String,
      content: map['content'] as String,
      isCorrect: map['isCorrect'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Answer(answerId: $answerId, content: $content, isCorrect: $isCorrect)';

  @override
  bool operator ==(covariant Answer other) {
    if (identical(this, other)) return true;
  
    return 
      other.answerId == answerId &&
      other.content == content &&
      other.isCorrect == isCorrect;
  }

  @override
  int get hashCode => answerId.hashCode ^ content.hashCode ^ isCorrect.hashCode;
}
