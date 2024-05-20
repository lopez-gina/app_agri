import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class FormulaQuestion extends StatefulWidget {
  @override
  _FormulaQuestionState createState() => _FormulaQuestionState();
}

class _FormulaQuestionState extends State<FormulaQuestion> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();

  void _insertText(String text, TextEditingController controller) {
    final textSelection = controller.selection;
    final newText = controller.text.replaceRange(
      textSelection.start,
      textSelection.end,
      text,
    );
    controller.text = newText;
    controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + text.length,
      extentOffset: textSelection.start + text.length,
    );
  }

  void _checkAnswer() {
    String answer = _controller1.text +
        _controller2.text +
        _controller3.text +
        _controller4.text;
    if (answer == "6CO₂6H₂OC₆H₁₂O₆6O₂") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Correct!'),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        globals.globalScore++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Incorrect. Try again!'),
        duration: Duration(seconds: 1),
      ));
    }
  }

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
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).cardTheme.color,
            padding: EdgeInsets.all(16),
            child: Text(
              'Write the balanced equation for photosynthesis',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Padding(
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
                      Expanded(child: _buildTextField(_controller1)),
                      Text('+', style: TextStyle(fontSize: 24)),
                      Expanded(child: _buildTextField(_controller2)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('→', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: _buildTextField(_controller3)),
                      Text('+', style: TextStyle(fontSize: 24)),
                      Expanded(child: _buildTextField(_controller4)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildCustomKeyboard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkAnswer,
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      showCursor: true,
      onTap: () {
        setState(() {
          // Set  controller -> text insertion
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    final List<String> letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    final List<String> specialCharacters = [
      '6CO₂',
      '6H₂O',
      'C₆H₁₂O₆',
      '6O₂',
      '→',
      '+',
      'H₂O',
      'CO₂',
      'C₂H₅OH',
      'H₂',
      'O₂',
      'CH₄'
    ];

    return Expanded(
      child: GridView.count(
        crossAxisCount: 6,
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        children: [
          ...letters
              .map((letter) => _buildKeyboardButton(letter, _controller1))
              .toList(),
          ...specialCharacters
              .map((char) => _buildKeyboardButton(char, _controller1))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildKeyboardButton(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(4.0),
      width: 48.0,
      height: 48.0,
      child: ElevatedButton(
        onPressed: () {
          _insertText(label, controller);
        },
        child: Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
