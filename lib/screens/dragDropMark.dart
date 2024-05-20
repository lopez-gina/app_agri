import 'package:app_agri/models/polygon.dart';
import 'package:flutter/material.dart';

class TextureClassQuiz extends StatefulWidget {
  @override
  _TextureClassQuizState createState() => _TextureClassQuizState();
}

class _TextureClassQuizState extends State<TextureClassQuiz> {
  final Map<String, bool> labelsPlaced = {
    'Clay': false,
    'Silt': false,
    'Sand': false,
  };

  final Map<String, Polygon> textureRegions = {
    'Clay': Polygon([
      Offset(100, 10),
      Offset(150, 20),
      Offset(130, 50),
      Offset(80, 40),
    ]),
    'Silt': Polygon([
      Offset(200, 100),
      Offset(250, 120),
      Offset(230, 150),
      Offset(180, 140),
    ]),
    'Sand': Polygon([
      Offset(300, 200),
      Offset(350, 220),
      Offset(330, 250),
      Offset(280, 240),
    ]),
    // Add the actual vertices for the regions
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Label the Texture Classes'),
      ),
      body: Column(
        children: <Widget>[
          // Draggable labels at the top
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: labelsPlaced.keys.map((label) {
              return _buildDraggable(label);
            }).toList(),
          ),
          // Image and drop targets below the draggable labels
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/texture_class.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ...textureRegions.keys
                    .map((label) => _buildCustomDragTarget(label)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggable(String label) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        child: _buildLabel(label),
        elevation: 4.0,
      ),
      childWhenDragging: Container(),
      child: labelsPlaced[label] ?? false ? Container() : _buildLabel(label),
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
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCustomDragTarget(String label) {
    return Positioned.fill(
      child: DragTarget<String>(
        builder: (_, candidateData, __) {
          return Container(); // Invisible container covering the full image
        },
        onWillAccept: (data) => data == label,
        onAcceptWithDetails: (details) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset localOffset = renderBox.globalToLocal(details.offset);
          final Polygon region = textureRegions[label]!;
          if (region.contains(localOffset)) {
            setState(() {
              labelsPlaced[label] = true;
            });
          }
        },
      ),
    );
  }
}
