// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quizz/enum/user_role.dart';

class User {
  final String userId;
  final String username;
  final String password;
  final String email;
  final UserRole role;
  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.email,
    required this.role,
  });

  
  User copyWith({
    String? userId,
    String? username,
    String? password,
    String? email,
    UserRole? role,
  }) {
    return User(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'password': password,
      'email': email,
      'role': role.name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      role: UserRoleExtension.fromString(map['role'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, username: $username, password: $password, email: $email, role: $role)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.username == username &&
      other.password == password &&
      other.email == email &&
      other.role == role;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      username.hashCode ^
      password.hashCode ^
      email.hashCode ^
      role.hashCode;
  }
}
