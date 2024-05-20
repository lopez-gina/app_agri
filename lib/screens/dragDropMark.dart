import 'package:app_agri/models/polygon.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class Dragdropmark extends StatefulWidget {
  @override
  _DragdropmarkState createState() => _DragdropmarkState();
}

class _DragdropmarkState extends State<Dragdropmark> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  final Map<String, bool> labelsPlaced = {
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
    'Sandy clay': Polygon([
      Offset(50, 50),
      Offset(70, 60),
      Offset(60, 80),
      Offset(40, 70),
    ]),
    'Sandy clay loam': Polygon([
      Offset(150, 50),
      Offset(170, 60),
      Offset(160, 80),
      Offset(140, 70),
    ]),
    'Sandy loam': Polygon([
      Offset(250, 50),
      Offset(270, 60),
      Offset(260, 80),
      Offset(240, 70),
    ]),
    'Loamy sand': Polygon([
      Offset(350, 50),
      Offset(370, 60),
      Offset(360, 80),
      Offset(340, 70),
    ]),
    'Loam': Polygon([
      Offset(450, 50),
      Offset(470, 60),
      Offset(460, 80),
      Offset(440, 70),
    ]),
    'Clay loam': Polygon([
      Offset(550, 50),
      Offset(570, 60),
      Offset(560, 80),
      Offset(540, 70),
    ]),
    'Silty clay': Polygon([
      Offset(650, 50),
      Offset(670, 60),
      Offset(660, 80),
      Offset(640, 70),
    ]),
    'Silty clay loam': Polygon([
      Offset(750, 50),
      Offset(770, 60),
      Offset(760, 80),
      Offset(740, 70),
    ]),
    'Silt loam': Polygon([
      Offset(850, 50),
      Offset(870, 60),
      Offset(860, 80),
      Offset(840, 70),
    ]),
  };

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
              'Label the Texture Classes',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          // Draggable labels at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: labelsPlaced.keys.map((label) {
                  return _buildDraggable(label);
                }).toList(),
              ),
            ),
          ),
          // Image  below
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
                        Image.asset(
                          'assets/texture_class.png',
                          fit: BoxFit.cover,
                        ),
                        ...textureRegions.keys
                            .map((label) => _buildCustomDragTarget(label)),
                      ],
                    ),
                  ),
                ),
              ),
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
              globals.globalScore++;
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
        },
      ),
    );
  }
}
