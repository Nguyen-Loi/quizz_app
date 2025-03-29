// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserScore {
  final String userId;
  final String quizId;
  final int totalPoints;
  final DateTime createdDate;
  UserScore({
    required this.userId,
    required this.quizId,
    required this.totalPoints,
    required this.createdDate,
  });

  UserScore copyWith({
    String? userId,
    String? quizId,
    int? totalPoints,
    DateTime? createdDate,
  }) {
    return UserScore(
      userId: userId ?? this.userId,
      quizId: quizId ?? this.quizId,
      totalPoints: totalPoints ?? this.totalPoints,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'quizId': quizId,
      'totalPoints': totalPoints,
      'createdDate': createdDate.millisecondsSinceEpoch,
    };
  }

  factory UserScore.fromMap(Map<String, dynamic> map) {
    return UserScore(
      userId: map['userId'] as String,
      quizId: map['quizId'] as String,
      totalPoints: map['totalPoints'] as int,
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserScore.fromJson(String source) => UserScore.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserScore(userId: $userId, quizId: $quizId, totalPoints: $totalPoints, createdDate: $createdDate)';
  }

  @override
  bool operator ==(covariant UserScore other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.quizId == quizId &&
      other.totalPoints == totalPoints &&
      other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      quizId.hashCode ^
      totalPoints.hashCode ^
      createdDate.hashCode;
  }
}
