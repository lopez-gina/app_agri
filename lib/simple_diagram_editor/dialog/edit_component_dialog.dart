import 'package:app_agri/simple_diagram_editor/data/custom_component_data.dart';

import 'package:diagram_editor/diagram_editor.dart';

import 'package:flutter/material.dart';

void showEditComponentDialog(
    BuildContext context, ComponentData componentData) {
  MyComponentData customData = componentData.data;

  Color color = customData.color;
  Color borderColor = customData.borderColor;

  double borderWidthPick = customData.borderWidth;
  double maxBorderWidth = 40;
  double minBorderWidth = 0;
  double borderWidthDelta = 0.1;

  final textController = TextEditingController(text: customData.text);

  Alignment textAlignmentDropdown = customData.textAlignment;
  var alignmentValues = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];
  double textSizeDropdown = customData.textSize;
  var textSizeValues =
      List<double>.generate(20, (int index) => index * 2 + 10.0);

  showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 600),
              const Text('Edit component', style: TextStyle(fontSize: 20)),
              TextField(
                controller: textController,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Text',
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          scrollable: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('DISCARD'),
            ),
            TextButton(
              onPressed: () {
                customData.text = textController.text;
                componentData.updateComponent();
                Navigator.of(context).pop();
              },
              child: const Text('SAVE'),
            )
          ],
        );
      });
    },
  );
}
