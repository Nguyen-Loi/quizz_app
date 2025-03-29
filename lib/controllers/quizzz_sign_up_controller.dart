import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizz/enum/user_role.dart';
import 'package:quizz/model/user_model.dart';
import 'package:quizz/util/firestore_path.dart';

class QuizzSignUpController {
  Future<void> signUp(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel = UserModel(
        userId: userCredential.user!.uid,
        username: email.split('@')[0],
        password: password,
        email: email,
        role: UserRole.student,
      );
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .doc(FirestorePath.user(userCredential.user!.uid))
          .set(userModel.toMap())
          .then((_) {
        debugPrint("User signed up successfully: ${userModel.toMap()}");
      }).catchError((error) {
        throw Exception("Failed to add user: $error");
      });
    } catch (e) {
      throw Exception("Sign up failed: $e");
    }
  }
}
