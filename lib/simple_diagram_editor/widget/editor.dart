import 'package:app_agri/simple_diagram_editor/data/custom_link_data.dart';
import 'package:app_agri/simple_diagram_editor/policy/my_policy_set.dart';
import 'package:app_agri/simple_diagram_editor/widget/correct_answer.dart';
import 'package:app_agri/simple_diagram_editor/widget/option_icon.dart';
import 'package:app_agri/simple_diagram_editor/widget/menu.dart';
import 'package:diagram_editor/diagram_editor.dart';
import '../../globals.dart' as globals;
import 'package:flutter/material.dart';

class SimpleDemoEditor extends StatefulWidget {
  const SimpleDemoEditor({super.key, this.onSubmit, required this.selectMenu});
  final VoidCallback? onSubmit;
  final int selectMenu;

  @override
  SimpleDemoEditorState createState() => SimpleDemoEditorState();
}

class SimpleDemoEditorState extends State<SimpleDemoEditor> {
  late DiagramEditorContext diagramEditorContext;

  MyPolicySet myPolicySet = MyPolicySet();

  bool isMenuVisible = true;
  bool isOptionsVisible = true;

  @override
  void initState() {
    diagramEditorContext = DiagramEditorContext(
      policySet: myPolicySet,
    );

    super.initState();
  }

  void checkAnswer() {
    List<ComponentData> userComponents = getUserComponents();
    List<LinkData> userLinks = getUserLinks();
    List<LinkData> linkList = [];

    // Map to track links for each component
    Map<String, List<String>> componentLinks = {};

    for (var element in userLinks) {
      String isSource = '', isTarget = '';
      for (var component in userComponents) {
        if (component.id == element.sourceComponentId) {
          isSource = component.data.text;
        }
        if (component.id == element.targetComponentId) {
          isTarget = component.data.text;
        }
      }

      // Add to componentLinks map
      componentLinks.putIfAbsent(isSource, () => []);
      componentLinks[isSource]!.add(isTarget);

      linkList.add(LinkData(
          id: element.id,
          sourceComponentId: isSource,
          targetComponentId: isTarget,
          linkPoints: element.linkPoints,
          data: MyLinkData.copy(element.data)));
    }
    final correctAnswerLinks =
        widget.selectMenu == 1 ? CorrectAnswer.links : CorrectAnswer.links2;

    if (linkList.length < correctAnswerLinks.length) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content:
            Text('You have an incorrect number of links.\nPlease try again!'),
        duration: Duration(seconds: 2),
      ));
    } else {
      for (var element1 in linkList) {
        for (var element2 in correctAnswerLinks) {
          if (element1.sourceComponentId == element2.sourceComponentId &&
              element1.targetComponentId == element2.targetComponentId) {
            if (componentLinks[element1.sourceComponentId]!.length == 1 ||
                element1.sourceComponentId == 'NO₃⁻' ||
                element1.sourceComponentId == 'Nitrification by bacteria') {
              globals.globalScore[widget.selectMenu + 2] += 1;
            }
          }
        }
      }
      globals.isSubmitted[widget.selectMenu + 2] = true;
    }
  }

  List<ComponentData> getUserComponents() {
    return diagramEditorContext.canvasModel.getAllComponents().values.toList();
  }

  List<LinkData> getUserLinks() {
    return diagramEditorContext.canvasModel.getAllLinks().values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: !kIsWeb,
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(color: Colors.grey),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DiagramEditor(
                    diagramEditorContext: diagramEditorContext,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      OptionIcon(
                        color: Colors.grey.withOpacity(0.7),
                        iconData:
                            isOptionsVisible ? Icons.menu_open : Icons.menu,
                        shape: BoxShape.rectangle,
                        onPressed: () {
                          setState(() {
                            isOptionsVisible = !isOptionsVisible;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Visibility(
                        visible: isOptionsVisible,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            OptionIcon(
                              tooltip: 'reset view',
                              color: Colors.grey.withOpacity(0.7),
                              iconData: Icons.replay,
                              onPressed: () => myPolicySet.resetView(),
                            ),
                            const SizedBox(width: 8),
                            OptionIcon(
                              tooltip: 'delete all',
                              color: Colors.grey.withOpacity(0.7),
                              iconData: Icons.delete_forever,
                              onPressed: () => myPolicySet.removeAll(),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: myPolicySet.isMultipleSelectionOn,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OptionIcon(
                                        tooltip: 'select all',
                                        color: Colors.grey.withOpacity(0.7),
                                        iconData: Icons.all_inclusive,
                                        onPressed: () =>
                                            myPolicySet.selectAll(),
                                      ),
                                      const SizedBox(height: 8),
                                      OptionIcon(
                                        tooltip: 'duplicate selected',
                                        color: Colors.grey.withOpacity(0.7),
                                        iconData: Icons.copy,
                                        onPressed: () =>
                                            myPolicySet.duplicateSelected(),
                                      ),
                                      const SizedBox(height: 8),
                                      OptionIcon(
                                        tooltip: 'remove selected',
                                        color: Colors.grey.withOpacity(0.7),
                                        iconData: Icons.delete,
                                        onPressed: () =>
                                            myPolicySet.removeSelected(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                OptionIcon(
                                  tooltip: myPolicySet.isMultipleSelectionOn
                                      ? 'cancel multiselection'
                                      : 'enable multiselection',
                                  color: Colors.grey.withOpacity(0.7),
                                  iconData: myPolicySet.isMultipleSelectionOn
                                      ? Icons.group_work
                                      : Icons.group_work_outlined,
                                  onPressed: () {
                                    setState(() {
                                      if (myPolicySet.isMultipleSelectionOn) {
                                        myPolicySet.turnOffMultipleSelection();
                                      } else {
                                        myPolicySet.turnOnMultipleSelection();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: Row(
                  children: [
                    Visibility(
                      visible: isMenuVisible,
                      child: Container(
                        color: Colors.grey.withOpacity(0.9),
                        width: 120,
                        height: 320, //gl 320
                        child: DraggableMenu(
                          myPolicySet: myPolicySet,
                          selectMenu: widget.selectMenu,
                        ),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMenuVisible = !isMenuVisible;
                          });
                        },
                        child: Container(
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child:
                                Text(isMenuVisible ? 'hide menu' : 'show menu'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
