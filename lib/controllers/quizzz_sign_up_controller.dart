import 'package:firebase_auth/firebase_auth.dart';

class QuizzSignUpController {
  Future<void> signUp(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception("Sign up failed: $e");
    }
  }
}
