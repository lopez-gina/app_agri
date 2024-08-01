import 'dart:async';
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
  double _scale = 0.9;
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

  Map<String, Offset> positionLabels = {
    "Cuticle": const Offset(40, 630),
    "Epidermis": const Offset(90, 630),
    "Palisade mesophyll": const Offset(150, 630),
    "Spongy mesophyll": const Offset(275, 30),
    "Vein": const Offset(255, 630),
    "Stomata": const Offset(360, 30),
    "Lower Epidermis": const Offset(330, 630),
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
        globals.globalScore[0]++;
      }
    });
  }

  final GlobalKey _imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      _reCalculatePositionLabel();
    });
  }

  void _reCalculatePositionLabel() {
    final RenderBox? renderBox =
        _imageKey.currentContext?.findRenderObject() as RenderBox?;
    Size imageSize = renderBox!.size;
    Size imageOriginal = const Size(780, 431);
    setState(() {
      positionLabels.updateAll((key, value) => value = Offset(
          value.dx * imageSize.height / imageOriginal.height,
          value.dy * imageSize.width / imageOriginal.width));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Header(
                  text:
                      '${globals.isSubmitted[0] ? 'CORRECTION - ' : ''}Question 1\nLabel the parts of a leaf${globals.isSubmitted[0] ? '\nCorrect answers: ${globals.globalScore[0]}/${globals.correctNumbers[0]}' : ''}'),
            ),
            const SizedBox(height: 20),
            !globals.isSubmitted[0]
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.start,
                        children: labelPositions.keys
                            .where(
                                (element) => labelPositions[element] == false)
                            .map((label) {
                          return _buildDraggable(label);
                        }).toList()),
                  )
                : Text("Correct answer:",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.black,
                        )),
            const SizedBox(
              height: 30,
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
                      key: _imageKey,
                    ),
                    ...positionLabels.keys.map((e) => Positioned(
                        top: positionLabels[e]!.dx,
                        left: positionLabels[e]!.dy,
                        child: _buildDragTarget(context, e))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Container(
      width: 70,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black, fontSize: 8),
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
        child: labelPositions[label] == false
            ? DraggableLabel(
                label: label,
                key: ValueKey(label),
              )
            : _buildLabel(label));
  }

  DragTarget<String> _buildDragTarget(BuildContext context, String label) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        bool isLabelCorrect = droppedLabels[label] != null;
        return (globals.isSubmitted[0] || !isLabelCorrect)
            ? _buildLabel(globals.isSubmitted[0] ? label : "")
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
