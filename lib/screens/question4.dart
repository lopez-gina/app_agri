
import 'package:app_agri/common_widget/header.dart';
import 'package:app_agri/common_widget/score_text.dart';
import 'package:app_agri/simple_diagram_editor/widget/editor.dart';
import 'package:flutter/material.dart';
import 'package:app_agri/globals.dart' as globals;

class Question4Screen extends StatefulWidget {
  const Question4Screen({super.key});

  @override
  State<Question4Screen> createState() => Question4ScreenState();
}

class Question4ScreenState extends State<Question4Screen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<SimpleDemoEditorState> _editorKey =
      GlobalKey<SimpleDemoEditorState>();
  void checkAnswer() {
    _editorKey.currentState?.checkAnswer();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(
                text:
                    '${globals.isSubmitted[3] ? 'CORRECTION - ' : ''}Question 4\nComplete the layers of the soil${globals.isSubmitted[3] ? '\nCorrect answers: ${globals.globalScore[3]}/4' : ''}'),
            if (globals.isSubmitted[3])
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Correct answer:",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.black,
                        )),
              ),
            !globals.isSubmitted[3]
                ? Container(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    height: size.height * 0.75,
                    child: SimpleDemoEditor(
                      key: _editorKey,
                      onSubmit: checkAnswer,
                      selectMenu: 1,
                    ),
                  )
                : Image.asset("assets/question4_correct.png"),
            if (globals.isSubmitted[3]) const Spacer(),
            if (globals.isSubmitted[3])
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ScoreText(
                    score: globals.globalScore
                        .reduce((value, element) => value + element)),
              ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
