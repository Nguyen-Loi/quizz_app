import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizz/Screens/quiz_dashboard.dart';
import 'package:quizz/controllers/quizzz_sign_up_controller.dart';
import 'package:quizz/utils/app_widget.dart';
import 'package:quizz/utils/quiz_colors.dart';
import 'package:quizz/utils/quiz_constant.dart';
import 'package:quizz/utils/quiz_strings.dart';
import 'package:quizz/utils/quiz_widget.dart';

class QuizSignUp extends StatefulWidget {
  static String tag = '/QuizSignUp';

  const QuizSignUp({super.key});

  @override
  _QuizSignUpState createState() => _QuizSignUpState();
}

class _QuizSignUpState extends State<QuizSignUp> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late QuizzSignUpController _controller;

  void _signUp(BuildContext context) async {
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
      await _controller.signUp(email, password);
      if (!context.mounted) return;

      Navigator.of(context).pop();

      const QuizDashboard().launch(context);
    } catch (e) {
      toast(e.toString());
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _controller = QuizzSignUpController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(quizappbackground);

    return Scaffold(
      appBar: AppBar(
        title: text(quizlblcreateaccount,
            fontSize: textSizeLargeMedium, fontFamily: fontMedium),
        leading: const Icon(
          Icons.arrow_back,
          color: quizcolorPrimary,
          size: 30,
        ).onTap(() {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        backgroundColor: quizappbackground,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: quizappbackground,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                text(quizinfosignup,
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
                    children: [
                      quizEditTextStyle(quizhintyouremail,
                          isPassword: false, controller: _emailController),
                      quizDivider(),
                      quizEditTextStyle(quizhintyourpassword,
                          controller: _passwordController),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    text(quizlblalreadyhaveanaccount),
                    text(quizlblsignin,
                        textColor: quizcolorPrimary, textAllCaps: true),
                  ],
                ).onTap(() {
                  Navigator.of(context).pop();
                }),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(24.0),
                  child: quizButton(
                    textContent: quizlblcontinue,
                    onPressed: () => _signUp(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
