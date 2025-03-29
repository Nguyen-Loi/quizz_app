import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizz/Screens/quiz_page.dart';
import 'package:quizz/model/quiz_model.dart';
import 'package:quizz/onBoardingScreens/utils/quizz_data.dart';
import 'package:quizz/utils/app_widget.dart';
import 'package:quizz/utils/quiz_colors.dart';
import 'package:quizz/utils/quiz_constant.dart';
import 'package:quizz/utils/quiz_strings.dart';
import 'package:quizz/utils/quiz_widget.dart';

class QuizDetails extends StatefulWidget {
  static String tag = '/QuizDetails';

  const QuizDetails({super.key});

  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  late List<QuizModel> mList;

  @override
  void initState() {
    super.initState();
    mList = QuizzData.instance.getQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(quizappbackground);
    return Scaffold(
      backgroundColor: quizappbackground,
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: mList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return quizList(mList[index], index);
          }),
    );
  }
}

class quizList extends StatelessWidget {
  late var width;
  late QuizModel model;

  quizList(this.model, int pos, {super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      decoration:
          boxDecoration(radius: 10, showShadow: true, bgColor: quizwhite),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text(
                model.title,
              ),
              text('Num of Questions : ${model.questions.length}',
                  textColor: quiztextColorSecondary, fontSize: textSizeSMedium),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          text('Time : ${model.timeLimit} seconds',
              textColor: quiztextColorSecondary),
          const SizedBox(
            height: 16,
          ),
          quizButton(
              textContent: quizlblbegin,
              onPressed: () {
                QuizPage(model: model).launch(context);
              })
        ],
      ),
    );
  }
}
