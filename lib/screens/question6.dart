import 'dart:math';
import 'package:app_agri/common_widget/header.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class Question6Screen extends StatefulWidget {
  const Question6Screen({super.key});

  @override
  State<Question6Screen> createState() => Question6ScreenState();
}

class Question6ScreenState extends State<Question6Screen>
    with AutomaticKeepAliveClientMixin {
  final Map<String, String> correctAnswers = {
    'A': 'loss',
    'B': 'evapotranspiration',
    'C': 'optimal',
    'D': 'sunny',
    'E': 'cool',
    'F': 'maize',
    'G': 'millet',
    'H': 'growth stage',
  };

  final Map<String, List<String>> options = {
    'A': ['loss', 'increase', 'supply', 'respiration'],
    'B': ['evapotranspiration', 'evaporation', 'transpiration', 'infiltration'],
    'C': ['optimal', 'restricted', 'minimum', 'average'],
    'D': ['sunny', 'cloudy', 'cold', 'cool'],
    'E': ['cool', 'sunny', 'warm', 'cloudless'],
    'F': ['maize', 'millet', 'sorghum', 'wheat'],
    'G': ['millet', 'maize', 'sugarcane', 'wheat'],
    'H': ['growth stage', 'farmer care', 'location', 'microclimate'],
  };

  Map<String, String?> userAnswers = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //Shuffle options and answers
    final random = Random();
    options.forEach((key, list) {
      list.shuffle(random);
    });

    userAnswers = Map.fromEntries(
      correctAnswers.keys.map((key) => MapEntry(key, null)),
    );
  }

  void checkAllAnswers() {
    for (var entry in userAnswers.entries) {
      if (entry.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Please select all options before submitting')),
        );
        return;
      } else {
        if (correctAnswers[entry.key] == entry.value) {
          globals.globalScore[5]++;
        }
      }
    }
    globals.isSubmitted[5] = true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(
              text:
                  '${globals.isSubmitted[5] ? 'CORRECTION - ' : ''}Question 6\nComplete the paragraph with the correct answers${globals.isSubmitted[5] ? '\nCorrect answers: ${globals.globalScore[5]}/${globals.correctNumbers[5]}' : ''}'),
          if (globals.isSubmitted[5])
            Text("Correct answer:",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.black,
                    )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RawScrollbar(
                controller: _scrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbColor: Colors.black38,
                thumbVisibility: true,
                radius: const Radius.circular(10),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          height: 2, color: Colors.black, fontSize: 16.0),
                      children: [
                        const TextSpan(
                            text:
                                'The crop water need (ET crop) is defined as amount of water needed to meet the water '),
                        _buildCustomDropdown('A'),
                        const TextSpan(text: ' through '),
                        _buildCustomDropdown('B'),
                        const TextSpan(
                            text:
                                '. In other words, it is the amount of water needed by the various crops to grow well.\n'),
                        const TextSpan(
                            text:
                                'The crop water need always refers to a crop grown under '),
                        _buildCustomDropdown('C'),
                        const TextSpan(
                            text:
                                'conditions, i.e. a uniform crop, actively growing, completely shading the ground, free of diseases, and favourable soil conditions (including fertility and water). The crop thus reaches its full production potential under the given environment.\n'),
                        const TextSpan(
                            text: 'The crop water need mainly depends on:\n'),
                        const TextSpan(text: '· the climate: in a '),
                        _buildCustomDropdown('D'),
                        const TextSpan(
                            text:
                                ' sunny climate crops need more water per day than in a '),
                        _buildCustomDropdown('E'),
                        const TextSpan(text: 'climate.\n'),
                        const TextSpan(text: '· the crop type: crops like '),
                        _buildCustomDropdown('F'),
                        const TextSpan(
                            text: ' need more water per day than crops like '),
                        _buildCustomDropdown('G'),
                        const TextSpan(text: '\n.the '),
                        _buildCustomDropdown('H'),
                        const TextSpan(
                            text:
                                ' of the crop; fully grown crops need more water than crops that have just been planted.'),
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

  WidgetSpan _buildCustomDropdown(String key) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: DropdownButton<String>(
        value: globals.isSubmitted[5] ? correctAnswers[key] : userAnswers[key],
        alignment: Alignment.center,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        hint: const Text('Choose...'),
        onChanged: !globals.isSubmitted[5]
            ? (String? newValue) {
                setState(() {
                  userAnswers[key] = newValue!;
                });
              }
            : null,
        items: options[key]!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
