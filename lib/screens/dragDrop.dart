import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class LeafLabelQuiz extends StatefulWidget {
  @override
  _LeafLabelQuizState createState() => _LeafLabelQuizState();
}

class _LeafLabelQuizState extends State<LeafLabelQuiz> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Map<String, bool> labelPositions = {
    "Cuticle": false,
    "Epidermis": false,
    "Palisade mesophyll": false,
    "Spongy mesophyll": false,
    "Vein": false,
    "Stomata": false,
    "Lower Epidermis": false,
  };

  void checkAnswer(String label, bool isCorrect) {
    if (isCorrect) {
      setState(() {
        globals.globalScore++;
        labelPositions[label] = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Correct!'),
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Incorrect. Try again!'),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Label the Parts of a Leaf'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                // Draggable labels
                Column(
                  children: labelPositions.keys.map((label) {
                    return LongPressDraggable<String>(
                      data: label,
                      feedback: DraggableLabel(
                        label: label,
                        isDragging: true,
                        key: ValueKey(label),
                      ),
                      childWhenDragging: Container(),
                      child: labelPositions[label] ?? false
                          ? Container()
                          : DraggableLabel(
                              label: label,
                              key: ValueKey(label),
                            ),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: GestureDetector(
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
                              Image.asset('assets/leaf_wo_l.png'),
                              Positioned(
                                top: 50,
                                left: 100,
                                child: buildDragTarget(context, "Cuticle"),
                              ),
                              // Add more Positioned widgets for other parts
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Score Display
          Text('Score: ${globals.globalScore}'),
        ],
      ),
    );
  }

  DragTarget<String> buildDragTarget(BuildContext context, String label) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        bool isLabelCorrect = labelPositions[label] ?? false;
        return Container(
          width: 100,
          height: 40,
          decoration: isLabelCorrect
              ? BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.white),
                )
              : BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey),
                ),
          alignment: Alignment.center,
          child: Text(isLabelCorrect ? label : ''),
        );
      },
      onWillAccept: (incoming) => !labelPositions[label]!,
      onAccept: (incoming) {
        bool isCorrect = incoming == label;
        checkAnswer(incoming, isCorrect);
      },
    );
  }
}

class DraggableLabel extends StatelessWidget {
  final String label;
  final bool isDragging;

  const DraggableLabel({
    required Key key,
    required this.label,
    this.isDragging = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDragging ? Colors.lightGreenAccent : Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
