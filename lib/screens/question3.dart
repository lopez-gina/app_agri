import 'package:app_agri/common_widget/header.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class Question3Screen extends StatefulWidget {
  const Question3Screen({super.key});

  @override
  State<Question3Screen> createState() => Question3ScreenState();
}

class Question3ScreenState extends State<Question3Screen>
    with AutomaticKeepAliveClientMixin {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final List<String> formulas = [
    'CH₄',
    'NH₄',
    'Chlorophyll',
    'C₂H₅OH',
    'O₂',
    'C₆H₁₂O₆',
    'Temperature',
    'Light',
    'N₂',
    'H₂O',
    'CO₂',
    'H₂',
    //  '→',
    //  '+',
  ];
  final List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  TextEditingController _currentController = TextEditingController();
  bool _isKeyboardVisible = false;
  List<String>? _currentList;

  @override
  void initState() {
    super.initState();
    _controllers
        .addAll(List.generate(10, (index) => TextEditingController(text: "")));
    _focusNodes.addAll(List.generate(10, (index) => FocusNode()));
    //Listen all focus nodes
    for (var focusNode in _focusNodes) {
      focusNode.addListener(() {
        int index = _focusNodes.indexOf(focusNode);
        _currentController = _controllers[index];
        setState(() {
          _isKeyboardVisible = focusNode.hasFocus;
          _currentList = ((index % 2 != 0 || index == 4)) ? formulas : numbers;
        });
      });
    }
  }

  void checkAnswer() {
    if (_controllers[1].text == _controllers[3].text) {
      if (_controllers[1].text == 'CO₂' || _controllers[1].text == 'H₂O') {
        _controllers[0].text == '6' ? globals.globalScore[2]++ : 0;
        globals.globalScore[2]++;
      }
    } else {
      if (_controllers[1].text == 'CO₂' || _controllers[1].text == 'H₂O') {
        _controllers[0].text == '6' ? globals.globalScore[2]++ : 0;
        globals.globalScore[2]++;
      }
      if (_controllers[3].text == 'CO₂' || _controllers[3].text == 'H₂O') {
        _controllers[2].text == '6' ? globals.globalScore[2]++ : 0;
        globals.globalScore[2]++;
      }
    }
    if (_controllers[4].text == _controllers[5].text) {
      if (_controllers[4].text == 'Light' ||
          _controllers[4].text == 'Chlorophyll') {
        globals.globalScore[2]++;
      }
    } else {
      if (_controllers[4].text == 'Light' ||
          _controllers[4].text == 'Chlorophyll') {
        globals.globalScore[2]++;
      }
      if (_controllers[5].text == 'Light' ||
          _controllers[5].text == 'Chlorophyll') {
        globals.globalScore[2]++;
      }
    }
    if (_controllers[7].text == _controllers[9].text) {
      if (_controllers[7].text == "C₆H₁₂O₆") {
        globals.globalScore[2]++;
        if ((_controllers[6].text.isEmpty || _controllers[6].text == '1')) {
          globals.globalScore[2]++;
        } else if ((_controllers[8].text.isEmpty ||
            _controllers[8].text == '1')) globals.globalScore[2]++;
      } else if (_controllers[7].text == "O₂") {
        globals.globalScore[2]++;
        if (_controllers[6].text == '6') {
          globals.globalScore[2]++;
        } else if (_controllers[8].text == '6') globals.globalScore[2]++;
      }
    } else {
      if (_controllers[7].text == "C₆H₁₂O₆") {
        globals.globalScore[2]++;
        if ((_controllers[6].text.isEmpty || _controllers[6].text == '1')) {
          globals.globalScore[2]++;
        }
      } else if (_controllers[7].text == "O₂") {
        globals.globalScore[2]++;
        if (_controllers[6].text == '6') {
          globals.globalScore[2]++;
        }
      }
      if (_controllers[9].text == "C₆H₁₂O₆") {
        globals.globalScore[2]++;
        if ((_controllers[8].text.isEmpty || _controllers[8].text == '1')) {
          globals.globalScore[2]++;
        }
      } else if (_controllers[9].text == "O₂") {
        globals.globalScore[2]++;
        if (_controllers[8].text == '6') {
          globals.globalScore[2]++;
        }
      }
    }
    globals.isSubmitted[2] = true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Header(
              text:
                  '${globals.isSubmitted[2] ? 'CORRECTION - ' : ''}Question 3\nWrite the symbol equation of the photosynthesis${globals.isSubmitted[2] ? '\nCorrect answers: ${globals.globalScore[2]}/${globals.correctNumbers[2]}' : ''}'),
          const SizedBox(height: 30),
          if (globals.isSubmitted[2]) ...[
            Align(
              alignment: Alignment.center,
              child: Text("Correct answer:",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.black,
                      )),
            ),
            SizedBox(height: size.height * 0.1),
          ],
          globals.isSubmitted[2]
              ? Image.asset('assets/question3_correct.png', width: size.width)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTextField(0, size.width * 0.1,
                                isNumber: true),
                            SizedBox(width: size.width * 0.02),
                            _buildTextField(1, size.width * 0.2),
                            const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 50,
                            ),
                            _buildTextField(2, size.width * 0.1,
                                isNumber: true),
                            SizedBox(width: size.width * 0.02),
                            _buildTextField(3, size.width * 0.2),
                          ],
                        ),
                        const SizedBox(height: 30),
                        _buildTextField(4, size.width * 0.3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.35,
                              color: Colors.black,
                              height: 3,
                            ),
                            const Text(
                              '>',
                              style: TextStyle(fontSize: 26),
                            )
                          ],
                        ),
                        _buildTextField(5, size.width * 0.3),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTextField(6, size.width * 0.1,
                                isNumber: true),
                            SizedBox(width: size.width * 0.02),
                            _buildTextField(7, size.width * 0.2),
                            const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 50,
                            ),
                            _buildTextField(8, size.width * 0.1,
                                isNumber: true),
                            SizedBox(width: size.width * 0.02),
                            _buildTextField(9, size.width * 0.2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          if (_isKeyboardVisible && !globals.isSubmitted[2]) ...[
            SizedBox(height: size.height * 0.02),
            _buildCustomKeyboard()
          ]
        ],
      ),
    );
  }

  Widget _buildTextField(int index, double width, {bool isNumber = false}) {
    return SizedBox(
      width: width,
      child: TextField(
        textAlign: TextAlign.center,
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        readOnly: true,
        showCursor: true,
        keyboardType: TextInputType.number,
        onTap: () {},
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _onKeyTap(String value) {
    //Set blank current textfield
    _currentController.clear();
    final text = _currentController.text;
    final textSelection = _currentController.selection;
    final newText =
        text.replaceRange(textSelection.start, textSelection.end, value);
    _currentController.value = TextEditingValue(
      text: newText,
      selection:
          TextSelection.collapsed(offset: textSelection.start + value.length),
    );
  }

  Widget _buildCustomKeyboard() {
    return Material(
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _currentList?.length,
          itemBuilder: (context, index) {
            return TextButton(
                style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                      StadiumBorder(),
                    ),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.greenAccent.shade100)),
                onPressed: () => _onKeyTap(_currentList![index]),
                child: Text(_currentList![index]));
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _currentController.dispose();
    for (var focusNode in _focusNodes) {
      focusNode.removeListener(() {});
      focusNode.dispose();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
