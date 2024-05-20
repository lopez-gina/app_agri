import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class Dragdrop extends StatefulWidget {
  @override
  _DragdropState createState() => _DragdropState();
}

class _DragdropState extends State<Dragdrop> {
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
        title: Text(
          'Agri-APP',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Theme.of(context).cardTheme.color,
            padding: EdgeInsets.all(16),
            child: Text(
              'Label the Parts of a Leaf',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Draggable labels
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: labelPositions.keys.map((label) {
                      return LongPressDraggable<String>(
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
                        child: labelPositions[label] ?? false
                            ? Container()
                            : DraggableLabel(
                                label: label,
                                key: ValueKey(label),
                              ),
                      );
                    }).toList(),
                  ),
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
                ),
              ],
            ),
          ),
          // Score Display
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Score: ${globals.globalScore}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
