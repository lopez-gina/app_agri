import 'package:app_agri/models/polygon.dart';
import 'package:flutter/material.dart';
import '../common_widget/header.dart';
import '../common_widget/score_text.dart';
import '../globals.dart' as globals;

class Question2Screen extends StatefulWidget {
  const Question2Screen({super.key});

  @override
  State<Question2Screen> createState() => Question2ScreenState();
}

class Question2ScreenState extends State<Question2Screen>
    with AutomaticKeepAliveClientMixin {
  final Map<String, String?> droppedLabels = {
    'Clay': null,
    'Silt': null,
    'Sand': null,
    'Sandy clay': null,
    'Sandy clay loam': null,
    'Sandy loam': null,
    'Loamy sand': null,
    'Loam': null,
    'Clay loam': null,
    'Silty clay': null,
    'Silty clay loam': null,
    'Silt loam': null,
  };

  final Map<String, Polygon> textureRegions = {
    'Clay': Polygon([
      const Offset(410, 40),
      const Offset(245, 330),
      const Offset(300, 415),
      const Offset(480, 420),
      const Offset(550, 295),
    ], const Offset(355, 254)),
    'Silt': Polygon([
      const Offset(690, 605),
      const Offset(650, 680),
      const Offset(775, 680),
      const Offset(733, 605),
    ], const Offset(670, 645)),
    'Sand': Polygon([
      const Offset(72, 634),
      const Offset(42, 682),
      const Offset(126, 681),
    ], const Offset(55, 660)),
    'Sandy clay': Polygon([
      const Offset(240, 345),
      const Offset(175, 450),
      const Offset(300, 450),
    ], const Offset(200, 405)),
    'Sandy clay loam': Polygon([
      const Offset(171, 467),
      const Offset(130, 545),
      const Offset(305, 550),
      const Offset(330, 505),
      const Offset(308, 467),
    ], const Offset(160, 499)),
    'Sandy loam': Polygon([
      const Offset(113, 562),
      const Offset(100, 588),
      const Offset(260, 680),
      const Offset(404, 681),
      const Offset(425, 645),
      const Offset(356, 642),
      const Offset(311, 564),
    ], const Offset(165, 587)),
    'Loamy sand': Polygon([
      const Offset(93, 600),
      const Offset(29, 624),
      const Offset(146, 678),
      const Offset(236, 682),
    ], const Offset(84, 609)),
    'Loam': Polygon([
      const Offset(346, 514),
      const Offset(323, 558),
      const Offset(364, 629),
      const Offset(433, 630),
      const Offset(500, 514),
    ], const Offset(373, 558)),
    'Clay loam': Polygon([
      const Offset(310, 435),
      const Offset(346, 500),
      const Offset(520, 503),
      const Offset(480, 431),
    ], const Offset(348, 465)),
    'Silty clay': Polygon([
      const Offset(500, 420),
      const Offset(560, 305),
      const Offset(625, 420),
    ], const Offset(525, 360)),
    'Silty clay loam': Polygon([
      const Offset(500, 435),
      const Offset(535, 500),
      const Offset(670, 500),
      const Offset(633, 433),
    ], const Offset(520, 451)),
    'Silt loam': Polygon([
      const Offset(515, 515),
      const Offset(420, 680),
      const Offset(630, 680),
      const Offset(680, 595),
      const Offset(725, 595),
      const Offset(680, 515),
    ], const Offset(522, 602)),
  };

  final GlobalKey _imageKey = GlobalKey();
  Offset _getImagePosition() {
    final RenderBox renderBox =
        _imageKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

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

    globals.isSubmitted[1] = true;
    droppedLabels.forEach((key, value) {
      if (value == key) {
        globals.globalScore[1]++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(
              text:
                  '${globals.isSubmitted[1] ? 'CORRECTION - ' : ''}Question 2\nLabel the texture classes in the triangle${globals.isSubmitted[1] ? '\nCorrect answers: ${globals.globalScore[1]}/12' : ''}'),
          !globals.isSubmitted[1]
              ? Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: droppedLabels.keys.map((label) {
                    return _buildDraggable(label);
                  }).toList())
              : Align(
                  alignment: Alignment.center,
                  child: Text("Correct answer:",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.black,
                          )),
                ),

          // Image  below
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      key: _imageKey,
                      globals.isSubmitted[1]
                          ? 'assets/question2_correct.png'
                          : 'assets/question2.png',
                    ),
                    if (!globals.isSubmitted[1])
                      ...textureRegions.keys
                          .map((label) => _buildMarkLabel(label)),
                  ],
                ),
              ),
            ),
          ),
          globals.isSubmitted[1]
              ? ScoreText(
                  score: globals.globalScore
                      .reduce((value, element) => value + element))
              : Container(),
        ],
      ),
    );
  }

  Positioned _buildMarkLabel(String label) {
    return Positioned(
      left: textureRegions[label]!.centroid.dx - 5,
      top: textureRegions[label]!.centroid.dy,
      child: Text(
        droppedLabels[label] == null ? "?" : droppedLabels[label]!,
        style: const TextStyle(color: Colors.green, fontSize: 20),
      ),
    );
  }

  bool _isDragging = false;
  Offset _currentDragPosition = const Offset(0, 0);

  Widget _buildDraggable(String label) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        elevation: 4.0,
        child: _buildLabel(label),
      ),
      childWhenDragging: Container(),
      child: _buildLabel(label),
      onDragStarted: () => _isDragging = true,
      onDragUpdate: (dragDetails) {
        if (_isDragging) {
          _currentDragPosition = dragDetails.globalPosition;
        }
      },
      onDragEnd: (dragDetails) {
        _isDragging = false;

        Offset imageOffset = _getImagePosition();
        for (var element in textureRegions.keys) {
          if (textureRegions[element]!
              .contains(_currentDragPosition - imageOffset)) {
            droppedLabels
                .updateAll((key, value) => value == label ? null : value);
            droppedLabels[element] = label;
          }
        }
        setState(() {});
      },
    );
  }

  Widget _buildLabel(String label) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
