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
                    '${globals.isSubmitted[0] ? 'CORRECTION - ' : ''}Question 1\nLabel the parts of a leaf${globals.isSubmitted[0] ? '\nCorrect answers: ${globals.globalScore[0]}/${globals.correctNumbers[0]}' : ''}'),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Draggable labels
                  !globals.isSubmitted[0]
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              alignment: WrapAlignment.start,
                              children: labelPositions.keys
                                  .where((element) =>
                                      labelPositions[element] == false)
                                  .map((label) {
                                return _buildDraggable(label);
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
                    child: Transform.scale(
                      scale: _scale,
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/leaf_v1.png',
                          ),
                          Positioned(
                            top: 25,
                            left: 400,
                            child: _buildDragTarget(context, "Cuticle"),
                          ),
                          Positioned(
                            top: 60,
                            left: 400,
                            child: _buildDragTarget(context, "Epidermis"),
                          ),
                          Positioned(
                            top: 100,
                            left: 400,
                            child:
                                _buildDragTarget(context, "Palisade mesophyll"),
                          ),
                          Positioned(
                            top: 170,
                            left: 15,
                            child:
                                _buildDragTarget(context, "Spongy mesophyll"),
                          ),
                          Positioned(
                            top: 160,
                            left: 400,
                            child: _buildDragTarget(context, "Vein"),
                          ),
                          Positioned(
                            top: 225,
                            left: 15,
                            child: _buildDragTarget(context, "Stomata"),
                          ),
                          Positioned(
                            top: 210,
                            left: 400,
                            child: _buildDragTarget(context, "Lower Epidermis"),
                          ),
                        ],
                      ),
                    ),
                    //   ),
                    // ),
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

  Draggable<String> _buildDraggable(String label) {
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
  }

  DragTarget<String> _buildDragTarget(BuildContext context, String label) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        bool isLabelCorrect = droppedLabels[label] != null;
        return (globals.isSubmitted[0] || !isLabelCorrect)
            ? Container(
                width: 80,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                alignment: Alignment.center,
                child: Text(
                  globals.isSubmitted[0] ? label : "",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : _buildDraggable(isLabelCorrect ? droppedLabels[label] ?? "" : "");
      },
      onLeave: (incoming) {
        //  when a label is dragged out of the target.
        setState(() {
          if (droppedLabels[label] == incoming) {
            // The dragged item is the current label of this target, so clear it.
            droppedLabels[label] = null;
            labelPositions[incoming!] = false;
          }
        });
      },
      onWillAcceptWithDetails: (incoming) => true,
      onAcceptWithDetails: (incoming) {
        setState(() {
          // Handle the case where a label is already dropped in this target
          if (droppedLabels[label] != null) {
            // Remove the old label from the labelPositions map
            labelPositions[droppedLabels[label]!] = false;
          }

          // Assign the new label to the target
          droppedLabels[label] = incoming.data;
          labelPositions[incoming.data] = true;
        });
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
