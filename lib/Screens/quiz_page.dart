import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizz/model/question_model.dart';
import 'package:quizz/model/quiz_model.dart';
import 'package:quizz/model/user_score.dart';
import 'package:quizz/utils/app_widget.dart';
import 'package:quizz/utils/quiz_colors.dart';

class QuizPage extends StatefulWidget {
  static String tag = '/QuizCards';
  final QuizModel model;
  const QuizPage({super.key, required this.model});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizModel _quiz;
  late List<QuestionModel> _questionList;
  late PageController _pageController;
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _quiz = widget.model;
    _questionList = _quiz.questions;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion(bool isCorrect) {
    if (isCorrect) {
      _score += _questionList[_currentQuestionIndex].points;
    }

    if (_currentQuestionIndex < _questionList.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showScoreDialog();
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      UserScore userScore = UserScore(
          userId: FirebaseAuth.instance.currentUser!.uid,
          quizId: _quiz.quizId,
          totalPoints: _score,
          createdDate: DateTime.now());
      firestore.collection('user_scores').add(userScore.toMap()).then((value) {
        debugPrint("Score added successfully");
      }).catchError((error) {
        debugPrint("Failed to add score: $error");
      });
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text(
              'Your score is $_score/${_quiz.questions.fold<int>(0, (sum, q) => sum + q.points)}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                finish(context);
              },
              child: const Text('Finish'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quizappbackground,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Header with quiz title and close button
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      finish(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: quizcolorPrimary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _quiz.title,
                      style: const TextStyle(color: quizcolorPrimary),
                    ).paddingOnly(left: 16),
                  ),
                ],
              ),
            ),
            // PageView for questions
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _questionList.length,
                itemBuilder: (context, index) {
                  return quizzItemOfThePage(_questionList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quizzItemOfThePage(QuestionModel question) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration:
          boxDecoration(radius: 10, showShadow: true, bgColor: quizwhite),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Question content
          Text(
            question.content,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Answers as buttons
          ...question.answers.map((answer) {
            return ElevatedButton(
              onPressed: () {
                _nextQuestion(answer.isCorrect);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: quizcolorPrimary,
                foregroundColor: Colors.white,
              ),
              child: Text(answer.content),
            ).paddingSymmetric(vertical: 4);
          }),
        ],
      ),
    );
  }
}
