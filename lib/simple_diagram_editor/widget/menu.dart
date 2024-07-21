import 'package:app_agri/simple_diagram_editor/data/custom_component_data.dart';
import 'package:app_agri/simple_diagram_editor/policy/my_policy_set.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

class DraggableMenu extends StatelessWidget {
  final MyPolicySet myPolicySet;
  final int selectMenu;

  const DraggableMenu({
    super.key,
    required this.myPolicySet,
    required this.selectMenu,
  });

  @override
  Widget build(BuildContext context) {
    var components = selectMenu == 1 ? myPolicySet.bodies : myPolicySet.bodies2;
    return RawScrollbar(
      thumbColor: Colors.black38,
      thumbVisibility: true,
      thickness: 6,
      radius: const Radius.circular(10),
      child: ListView(
        children: <Widget>[
          ...components.map(
            (component) {
              var componentData = getComponentData(component);
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth < componentData.size.width
                          ? componentData.size.width *
                              (constraints.maxWidth / componentData.size.width)
                          : componentData.size.width,
                      height: constraints.maxWidth < componentData.size.width
                          ? componentData.size.height *
                              (constraints.maxWidth / componentData.size.width)
                          : componentData.size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: AspectRatio(
                          aspectRatio: componentData.size.aspectRatio,
                          child: Tooltip(
                            message: componentData.type,
                            child: DraggableComponent(
                              myPolicySet: myPolicySet,
                              componentData: componentData,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ComponentData getComponentData(Map<String, String> component) {
    String type = component.values.toString();
    type = type.substring(1, type.length - 1);
    String name = component.keys.toString();
    name = name.substring(1, name.length - 1);
    switch (type) {
      case 'rect':
        return ComponentData(
          size: const Size(120, 72),
          minSize: const Size(80, 64),
          data: MyComponentData(
            text: name,
            color: Colors.white,
            borderColor: Colors.black,
            borderWidth: 2.0,
          ),
          type: type,
        );
      case 'bean':
        return ComponentData(
          size: const Size(120, 72),
          minSize: const Size(80, 64),
          data: MyComponentData(
            text: name,
            color: Colors.white,
            borderColor: Colors.black,
            borderWidth: 2.0,
          ),
          type: type,
        );
      default:
        return ComponentData(
          size: const Size(120, 72),
          minSize: const Size(80, 64),
          data: MyComponentData(
            text: '',
            color: Colors.white,
            borderColor: Colors.black,
            borderWidth: 2.0,
          ),
          type: type,
        );
    }
  }
}

class DraggableComponent extends StatelessWidget {
  final MyPolicySet myPolicySet;
  final ComponentData componentData;

  const DraggableComponent({
    super.key,
    required this.myPolicySet,
    required this.componentData,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<ComponentData>(
      affinity: Axis.horizontal,
      ignoringFeedbackSemantics: true,
      data: componentData,
      childWhenDragging: myPolicySet.showComponentBody(componentData),
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: componentData.size.width,
          height: componentData.size.height,
          child: myPolicySet.showComponentBody(componentData),
        ),
      ),
      child: myPolicySet.showComponentBody(componentData),
    );
  }
}
