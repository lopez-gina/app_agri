import 'package:app_agri/simple_diagram_editor/data/custom_link_data.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

class CorrectAnswer {
  static final List<LinkData> links2 = [
    LinkData(
      id: 'link1',
      sourceComponentId: 'N₂ in the atmosphere',
      targetComponentId: 'Nitrogen fixation by bacteria in roots',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link2',
      sourceComponentId: 'Nitrogen fixation by bacteria in roots',
      targetComponentId: 'NH₃',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link3',
      sourceComponentId: 'NH₃',
      targetComponentId: 'Nitrification by bacteria',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link4',
      sourceComponentId: 'Nitrification by bacteria',
      targetComponentId: 'NO₂⁻',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link5',
      targetComponentId: 'Nitrification by bacteria',
      sourceComponentId: 'NO₂⁻',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link15',
      sourceComponentId: 'Nitrification by bacteria',
      targetComponentId: 'NO₃⁻',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link6',
      targetComponentId: 'Denitrification by bacteria',
      sourceComponentId: 'NO₃⁻',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link7',
      sourceComponentId: 'Denitrification by bacteria',
      targetComponentId: 'N₂ in the atmosphere',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link8',
      targetComponentId: 'Assimilation in plants',
      sourceComponentId: 'NO₃⁻',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link9',
      sourceComponentId: 'Assimilation in plants',
      targetComponentId: 'Plants',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link10',
      targetComponentId: 'Absorption of N₂ in animals',
      sourceComponentId: 'Plants',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link11',
      sourceComponentId: 'Absorption of N₂ in animals',
      targetComponentId: 'Animals/Decomposer',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link12',
      targetComponentId: 'Ammonification',
      sourceComponentId: 'Animals/Decomposer',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link13',
      sourceComponentId: 'Ammonification',
      targetComponentId: 'NH₄⁺',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link14',
      targetComponentId: 'NO₂⁻',
      sourceComponentId: 'NH₄⁺',
      linkPoints: [],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
  ];

  static final List<LinkData> links = [
    LinkData(
      id: 'link1',
      sourceComponentId: 'O Organic matter',
      targetComponentId: 'A Surface',
      linkPoints: [
        const Offset(150 + 60, 50 + 72),
        const Offset(150 + 60, 150),
      ],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link2',
      sourceComponentId: 'A Surface',
      targetComponentId: 'B Subsoil',
      linkPoints: [
        const Offset(150 + 60, 150 + 72),
        const Offset(150 + 60, 250),
      ],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link3',
      sourceComponentId: 'B Subsoil',
      targetComponentId: 'C Substratum',
      linkPoints: [
        const Offset(150 + 60, 250 + 50),
        const Offset(150 + 60, 350),
      ],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
    LinkData(
      id: 'link4',
      sourceComponentId: 'C Substratum',
      targetComponentId: 'R Bedrock',
      linkPoints: [
        const Offset(150 + 60, 350 + 72),
        const Offset(150 + 60, 450),
      ],
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    ),
  ];
}
