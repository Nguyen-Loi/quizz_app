import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizz/Screens/quiz_card.dart';
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
      body: Column(
        children: <Widget>[
          const quizTopBar(quizlblbiologybasics),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  text(quizlblbiologyampscientificmethod,
                      isLongText: true,
                      fontFamily: fontBold,
                      isCentered: true,
                      fontSize: textSizeXLarge),
                  text(quiztext4to8lesson, textColor: quiztextColorSecondary),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return quizList(mList[index], index);
                      }),
                ],
              ),
            ),
          )
        ],
      ),
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
          Row(
            children: <Widget>[
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text(model.title,
                      textColor: quiztextColorSecondary,
                      fontSize: textSizeSMedium),
                  text(
                    'Num of Questions : ${model.questions.length}',
                    fontFamily: fontMedium,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          text('Time : ${model.timeLimit} seconds', textColor: quiztextColorSecondary),
          const SizedBox(
            height: 16,
          ),
          quizButton(
              textContent: quizlblbegin,
              onPressed: () {
                const QuizCards().launch(context);
              })
        ],
      ),
    );
  }
}
