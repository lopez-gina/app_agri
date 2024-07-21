import 'package:app_agri/simple_diagram_editor/dialog/pick_color_dialog.dart';
import 'package:app_agri/simple_diagram_editor/data/custom_link_data.dart';

import 'package:diagram_editor/diagram_editor.dart';

import 'package:flutter/material.dart';

void showEditLinkDialog(BuildContext context, LinkData linkData) {
  MyLinkData customData = linkData.data;

  Color color = linkData.linkStyle.color;
  LineType lineTypeDropdown = linkData.linkStyle.lineType;
  double lineWidthPick = linkData.linkStyle.lineWidth;
  double maxLineWidth = 10;
  double minLineWidth = 0.1;
  double widthDelta = 0.1;

  ArrowType arrowTypeDropdown = linkData.linkStyle.arrowType;
  double arrowSizePick = linkData.linkStyle.arrowSize;
  ArrowType backArrowTypeDropdown = linkData.linkStyle.backArrowType;
  double backArrowSizePick = linkData.linkStyle.backArrowSize;
  double maxArrowSize = 15;
  double minArrowSize = 1;
  double arrowSizeDelta = 0.1;

  bool isLineEditShown = false;
  bool isFrontArrowEditShown = false;
  bool isBackArrowEditShown = false;
  bool isColorEditShown = false;
  bool isLabelsEditShown = false;

  final startLabelController =
      TextEditingController(text: customData.startLabel);
  final endLabelController = TextEditingController(text: customData.endLabel);

  showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 600),
                const Text('Label link', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 8),
                ShowItem(
                    text: 'Link labels',
                    isShown: isLabelsEditShown,
                    onTap: () =>
                        setState(() => isLabelsEditShown = !isLabelsEditShown)),
                Visibility(
                  visible: isLabelsEditShown,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: startLabelController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: 'Start label',
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(left: 13),
                        ),
                      ),
                      TextField(
                        controller: endLabelController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: 'End label',
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(left: 13),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  customData.startLabel = startLabelController.text;
                  customData.endLabel = endLabelController.text;
                  linkData.updateLink();
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              )
            ],
          );
        },
      );
    },
  );
}

class ShowItem extends StatelessWidget {
  final String text;
  final bool isShown;
  final Function onTap;

  const ShowItem({
    super.key,
    required this.text,
    required this.isShown,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Text(text),
          Icon(isShown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
