import 'package:flutter/material.dart';
import '../common_widget/header.dart';
import '../common_widget/score_text.dart';
import '../simple_diagram_editor/widget/editor.dart';
import 'package:app_agri/globals.dart' as globals;

class Question5Screen extends StatefulWidget {
  const Question5Screen({super.key});

  @override
  State<Question5Screen> createState() => Question5ScreenState();
}

class Question5ScreenState extends State<Question5Screen>
    with AutomaticKeepAliveClientMixin {
  double _scale = 1.0;
  double _previousScale = 1.0;

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
                    '${globals.isSubmitted[4] ? 'CORRECTION - ' : ''}Question 5\nComplete the cycle of nitrogen${globals.isSubmitted[4] ? '\nCorrect answers: ${globals.globalScore[4]}/15' : ''}'),
            if (globals.isSubmitted[4])
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Correct answer:",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.black,
                        )),
              ),
            !globals.isSubmitted[4]
                ? Container(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    height: size.height * 0.75,
                    child: SimpleDemoEditor(
                      key: _editorKey,
                      onSubmit: checkAnswer,
                      selectMenu: 2,
                    ),
                  )
                : GestureDetector(
                    onScaleStart: (ScaleStartDetails details) {
                      _previousScale = _scale;
                    },
                    onScaleUpdate: (ScaleUpdateDetails details) {
                      setState(() {
                        _scale = _previousScale * details.scale;
                      });
                    },
                    onScaleEnd: (ScaleEndDetails details) {
                      _previousScale = 1.0;
                    },
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Transform.scale(
                              scale: _scale,
                              child: Image.asset(
                                "assets/question5_correct.png",
                                height: size.height * 0.55,
                              ),
                            )))),
            if (globals.isSubmitted[4]) const Spacer(),
            if (globals.isSubmitted[4])
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
