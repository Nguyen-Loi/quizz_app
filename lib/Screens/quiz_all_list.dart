import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizz/Screens/quiz_details.dart';
import 'package:quizz/model/quiz_model.dart';
import 'package:quizz/onBoardingScreens/utils/quizz_data.dart';
import 'package:quizz/utils/app_widget.dart';
import 'package:quizz/utils/quiz_colors.dart';
import 'package:quizz/utils/quiz_constant.dart';
import 'package:quizz/utils/quiz_strings.dart';

class QuizAllList extends StatefulWidget {
  static String tag = '/QuizAllList';

  const QuizAllList({super.key});

  @override
  _QuizAllListState createState() => _QuizAllListState();
}

class _QuizAllListState extends State<QuizAllList> {
  late List<QuizModel> _quizList;
  int selectedPos = 1;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    _quizList = QuizzData.instance.getQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    final quizAll = StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,

      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      scrollDirection: Axis.vertical,
      itemCount: _quizList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        changeStatusColor(quizappbackground);
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    color: quizwhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      text(
                        _quizList[index].title,
                        fontSize: textSizeMedium,
                        maxLine: 2,
                        fontFamily: fontMedium,
                      ).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                      text(
                        _quizList[index].questions.length.toString(),
                        textColor: quiztextColorSecondary,
                      ).paddingOnly(left: 16, right: 16, bottom: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).onTap(() {
          const QuizDetails().launch(context);
        });
      },
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.67, mainAxisSpacing: 16, crossAxisSpacing: 16),
    );

    Widget quizCompleted = StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      scrollDirection: Axis.vertical,
      itemCount: _quizList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        changeStatusColor(quizappbackground);
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    color: quizwhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      text(
                        _quizList[index].title,
                        fontSize: textSizeMedium,
                        maxLine: 2,
                        fontFamily: fontMedium,
                      ).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                      text(
                        _quizList[index].questions.length.toString(),
                        textColor: quiztextColorSecondary,
                      ).paddingOnly(left: 16, right: 16, bottom: 16),
                      LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: textSecondaryColor.withOpacity(0.2),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(quizgreen),
                      ).paddingOnly(left: 16, right: 16, bottom: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).onTap(() {
          const QuizDetails().launch(context);
        });
      },
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.60, mainAxisSpacing: 16, crossAxisSpacing: 16),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: quizappbackground,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                decoration: boxDecoration(
                  radius: spacingmiddle,
                  bgColor: quizwhite,
                  showShadow: false,
                ),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPos = 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(spacingmiddle),
                              bottomLeft: Radius.circular(spacingmiddle),
                            ),
                            color: selectedPos == 1
                                ? quizwhite
                                : Colors.transparent,
                            border: Border.all(
                              color: selectedPos == 1
                                  ? quizwhite
                                  : Colors.transparent,
                            ),
                          ),
                          child: text(
                            quizlblAll,
                            fontSize: textSizeMedium,
                            isCentered: true,
                            fontFamily: fontMedium,
                            textColor: selectedPos == 1
                                ? quiztextColorPrimary
                                : quiztextColorSecondary,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: quizlightgray,
                    ).center(),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPos = 2;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(spacingmiddle),
                              bottomRight: Radius.circular(spacingmiddle),
                            ),
                            color: selectedPos == 2
                                ? quizwhite
                                : Colors.transparent,
                            border: Border.all(
                              color: selectedPos == 2
                                  ? quizwhite
                                  : Colors.transparent,
                            ),
                          ),
                          child: text(
                            quizlblCompleted,
                            fontSize: textSizeMedium,
                            isCentered: true,
                            fontFamily: fontMedium,
                            textColor: selectedPos == 2
                                ? quiztextColorPrimary
                                : quiztextColorSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.only(right: 8, left: 8),
                  child: selectedPos == 1 ? quizAll : quizCompleted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
