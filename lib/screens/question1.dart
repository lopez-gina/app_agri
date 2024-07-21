import 'package:app_agri/common_widget/score_text.dart';
import 'package:app_agri/models/dragable_label.dart';
import 'package:flutter/material.dart';
import '../common_widget/header.dart';
import '../globals.dart' as globals;

class Dragdrop extends StatefulWidget {
  const Dragdrop({super.key});

  @override
  State<Dragdrop> createState() => DragdropState();
}

class DragdropState extends State<Dragdrop> with AutomaticKeepAliveClientMixin {
  double _scale = 0.8;
  double _previousScale = 1.0;
  Map<String, bool> labelPositions = {
    "Cuticle": false,
    "Palisade mesophyll": false,
    "Epidermis": false,
    "Spongy mesophyll": false,
    "Vein": false,
    "Stomata": false,
    "Lower Epidermis": false,
  };
  Map<String, String?> droppedLabels = {
    "Cuticle": null,
    "Palisade mesophyll": null,
    "Epidermis": null,
    "Spongy mesophyll": null,
    "Vein": null,
    "Stomata": null,
    "Lower Epidermis": null,
  };

  void checkAllAnswers() {
    bool allFilled = true;
    droppedLabels.forEach((key, value) {
      if (value == null) {
        allFilled = false;
      }
    });
    if (!allFilled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Some answers are missing.\nPlease fill them in!'),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    globals.isSubmitted[0] = true;
    droppedLabels.forEach((key, value) {
      if (value == key) {
        labelPositions[key] = true;
        globals.globalScore[0]++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Header(
                text:
                    '${globals.isSubmitted[0] ? 'CORRECTION - ' : ''}Question 1\nLabel the parts of a leaf${globals.isSubmitted[0] ? '\nCorrect answers: ${globals.globalScore[0]}/${labelPositions.length}' : ''}'),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Draggable labels
                  !globals.isSubmitted[0]
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              alignment: WrapAlignment.start,
                              children: droppedLabels.keys.map((label) {
                                return Draggable<String>(
                                  data: label,
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: DraggableLabel(
                                      label: label,
                                      isDragging: true,
                                      key: ValueKey(label),
                                    ),
                                  ),
                                  childWhenDragging: Container(),
                                  child: DraggableLabel(
                                    label: label,
                                    key: ValueKey(label),
                                  ),
                                );
                              }).toList()),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Text("Correct answer:",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: Colors.black,
                                  )),
                        ),
                  GestureDetector(
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
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/leaf_v1.png',
                              ),
                              Positioned(
                                top: 40,
                                left: 640,
                                child: buildDragTarget(context, "Cuticle"),
                              ),
                              Positioned(
                                top: 90,
                                left: 640,
                                child: buildDragTarget(context, "Epidermis"),
                              ),
                              Positioned(
                                top: 170,
                                left: 640,
                                child: buildDragTarget(
                                    context, "Palisade mesophyll"),
                              ),
                              Positioned(
                                top: 275,
                                left: 20,
                                child: buildDragTarget(
                                    context, "Spongy mesophyll"),
                              ),
                              Positioned(
                                top: 255,
                                left: 640,
                                child: buildDragTarget(context, "Vein"),
                              ),
                              Positioned(
                                top: 360,
                                left: 20,
                                child: buildDragTarget(context, "Stomata"),
                              ),
                              Positioned(
                                top: 330,
                                left: 640,
                                child:
                                    buildDragTarget(context, "Lower Epidermis"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Score Display
            globals.isSubmitted[0]
                ? ScoreText(
                    score: globals.globalScore
                        .reduce((value, element) => value + element))
                : Container(),
          ],
        ),
      ),
    );
  }

  DragTarget<String> buildDragTarget(BuildContext context, String label) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        bool isLabelCorrect = droppedLabels[label] != null;

        return Container(
          width: 100,
          height: 40,
          decoration: (globals.isSubmitted[0])
              ? BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.black),
                )
              : isLabelCorrect
                  ? BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black),
                    )
                  : BoxDecoration(
                      color: Colors.green[50],
                      border: Border.all(color: Colors.black),
                    ),
          alignment: Alignment.center,
          child: Text(
            globals.isSubmitted[0] ? label : droppedLabels[label] ?? "",
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
      onWillAcceptWithDetails: (incoming) => true,
      onAcceptWithDetails: (incoming) {
        setState(() {
          droppedLabels
              .updateAll((key, value) => value == incoming.data ? null : value);
          droppedLabels[label] = incoming.data;
        });
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
