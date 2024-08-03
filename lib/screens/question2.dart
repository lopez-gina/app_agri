import 'dart:async';

import 'package:app_agri/common_widget/sliver_persistent_header.dart';
import 'package:app_agri/models/polygon.dart';
import 'package:flutter/material.dart';
import '../common_widget/header.dart';
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

  final Map<String, bool> labelPositions = {
    'Clay': false,
    'Silt': false,
    'Sand': false,
    'Sandy clay': false,
    'Sandy clay loam': false,
    'Sandy loam': false,
    'Loamy sand': false,
    'Loam': false,
    'Clay loam': false,
    'Silty clay': false,
    'Silty clay loam': false,
    'Silt loam': false,
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
    ], const Offset(55, 645)),
    'Sandy clay': Polygon([
      const Offset(240, 345),
      const Offset(175, 450),
      const Offset(300, 450),
    ], const Offset(200, 390)),
    'Sandy clay loam': Polygon([
      const Offset(171, 467),
      const Offset(130, 545),
      const Offset(305, 550),
      const Offset(330, 505),
      const Offset(308, 467),
    ], const Offset(160, 485)),
    'Sandy loam': Polygon([
      const Offset(113, 562),
      const Offset(100, 588),
      const Offset(260, 680),
      const Offset(404, 681),
      const Offset(425, 645),
      const Offset(356, 642),
      const Offset(311, 564),
    ], const Offset(165, 575)),
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
    ], const Offset(348, 440)),
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
    ], const Offset(520, 440)),
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

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      _reCalculatePositionLabel();
      _getImagePosition();
    });
  }

  Offset? imageOffset;

  void _reCalculatePositionLabel() {
    final RenderBox renderBox =
        _imageKey.currentContext!.findRenderObject() as RenderBox;
    textureRegions.forEach((key, value) => value.scaleOffset(renderBox.size));
    setState(() {});
  }

  void _getImagePosition() {
    final RenderBox renderBox =
        _imageKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    imageOffset = position;
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Header(
                text:
                    '${globals.isSubmitted[1] ? 'CORRECTION - ' : ''}Question 2\nLabel the texture classes in the triangle${globals.isSubmitted[1] ? '\nCorrect answers: ${globals.globalScore[1]}/${globals.correctNumbers[1]}' : ''}'),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 6)),
          !globals.isSubmitted[1]
              ? CustomSliverPersistentHeader(
                  child: Row(
                      children: labelPositions.keys
                          .where((label) => labelPositions[label] == false)
                          .map((label) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildDraggable(label),
                  );
                }).toList()))
              : SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Correct answer:",
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Colors.black,
                                )),
                  ),
                ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          // Image  below
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  key: _imageKey,
                  globals.isSubmitted[1]
                      ? 'assets/question2_correct.png'
                      : 'assets/question2.png',
                ),
                if (!globals.isSubmitted[1])
                  ...textureRegions.keys.map((label) => _buildMarkLabel(label)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildMarkLabel(String label) {
    return Positioned(
      left: textureRegions[label]!.centroid.dx,
      top: textureRegions[label]!.centroid.dy,
      child: droppedLabels[label] == null
          ? const Text(
              "?",
              style: TextStyle(color: Colors.green, fontSize: 12),
            )
          : _buildDraggable(droppedLabels[label]!, value: label),
    );
  }

  bool _isDragging = false;
  Offset _currentDragPosition = const Offset(0, 0);

  Widget _buildDraggable(String label, {String? value}) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        elevation: 4.0,
        child: _buildLabel(label),
      ),
      childWhenDragging: Opacity(
        opacity: 0.75,
        child: _buildLabel(label),
      ),
      child: labelPositions[label] == false
          ? _buildLabel(label)
          : SizedBox(
              width: (label == 'Silty clay loam' || label == 'Sandy clay loam')
                  ? 80
                  : 48,
              child: Text(
                label,
                style: const TextStyle(color: Colors.green, fontSize: 12),
              )),
      onDragStarted: () => _isDragging = true,
      onDragUpdate: (dragDetails) {
        if (_isDragging) {
          _currentDragPosition = dragDetails.globalPosition;
        }
      },
      onDragEnd: (dragDetails) {
        _isDragging = false;

        bool found = false;
        String? replacedLabel;
        for (var element in textureRegions.keys) {
          if (textureRegions[element]!
              .contains(_currentDragPosition - imageOffset!)) {
            setState(() {
              replacedLabel = droppedLabels[element];
              droppedLabels
                  .updateAll((key, value) => value == label ? null : value);
              droppedLabels[element] = label;
              labelPositions[label] = true;
              if (replacedLabel != null) {
                labelPositions[replacedLabel!] = false;
              }
            });
            found = true;
            break;
          }
        }
        // If not found in any region, the label is returned to the menu
        if (!found) {
          setState(() {
            droppedLabels
                .updateAll((key, value) => value == label ? null : value);
            labelPositions[label] = false;
          });
        }
      },
    );
  }

  Widget _buildLabel(String label) {
    return Container(
      padding: const EdgeInsets.all(7.0),
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
