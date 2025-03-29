import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizz/Screens/quiz_dashboard.dart';
import 'package:quizz/Screens/quiz_sign_up.dart';
import 'package:quizz/controllers/quizzz_sign_in_controller.dart';
import 'package:quizz/utils/app_widget.dart';
import 'package:quizz/utils/quiz_colors.dart';
import 'package:quizz/utils/quiz_constant.dart';
import 'package:quizz/utils/quiz_strings.dart';
import 'package:quizz/utils/quiz_widget.dart';

class QuizSignIn extends StatefulWidget {
  static String tag = '/QuizSignIn';

  const QuizSignIn({super.key});

  @override
  _QuizSignInState createState() => _QuizSignInState();
}

class _QuizSignInState extends State<QuizSignIn> {
  QuizzSignInController signInController = QuizzSignInController();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  void _signIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      toast("Email and password cannot be empty");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      await signInController.signIn(email, password);
      if (!context.mounted) return;

      Navigator.of(context).pop();

      const QuizDashboard().launch(context);
    } catch (e) {
      toast("Sign in failed. Please try again.");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(quizappbackground);

    return Scaffold(
      backgroundColor: quizappbackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: quizappbackground,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                text(quiztitlelogin,
                    fontSize: textSizeNormal, fontFamily: fontBold),
                text(quizinfologin,
                        textColor: quiztextColorSecondary,
                        isLongText: true,
                        isCentered: true)
                    .center(),
                Container(
                  margin: const EdgeInsets.all(24.0),
                  decoration: boxDecoration(
                      bgColor: quizwhite,
                      color: quizwhite,
                      showShadow: true,
                      radius: 10),
                  child: Column(
                    children: <Widget>[
                      quizEditTextStyle(quizhintyouremail,
                          isPassword: false, controller: _emailController),
                      quizDivider(),
                      quizEditTextStyle(quizhintyourpassword,
                          controller: _passwordController),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: <Widget>[
                    text(quizlbldonthaveanaccount),
                    text(quizlblcreateaccount,
                        textColor: quizcolorPrimary, fontFamily: fontSemibold),
                  ],
                ).onTap(() {
                  setState(() {
                    const QuizSignUp().launch(context);
                  });
                }),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.all(24.0),
                    child: quizButton(
                        textContent: quizlblcontinue,
                        onPressed: () => _signIn(context)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
