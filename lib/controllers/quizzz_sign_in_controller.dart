import 'package:firebase_auth/firebase_auth.dart';

class QuizzSignInController {
  Future<void> signIn (String email, String password)async{
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception("Sign in failed: $e");
    }
  }
}