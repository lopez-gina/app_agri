import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write the balanced equation for photosynthesis'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildTextField(_controller1)),
              Text('+', style: TextStyle(fontSize: 24)),
              Expanded(child: _buildTextField(_controller2)),
              Text('→', style: TextStyle(fontSize: 24)),
              Expanded(child: _buildTextField(_controller3)),
              Text('+', style: TextStyle(fontSize: 24)),
              Expanded(child: _buildTextField(_controller4)),
            ],
          ),
          SizedBox(height: 20),
          _buildCustomKeyboard(),
        ],
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
          // Set the current controller for text insertion
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.all(8.0),
      children: [
        _buildKeyboardButton('6CO₂', _controller1),
        _buildKeyboardButton('6H₂O', _controller2),
        _buildKeyboardButton('C₆H₁₂O₆', _controller3),
        _buildKeyboardButton('6O₂', _controller4),
        _buildKeyboardButton('→', _controller1),
        _buildKeyboardButton('+', _controller1),
        _buildKeyboardButton('H₂O', _controller1),
        _buildKeyboardButton('CO₂', _controller1),
        _buildKeyboardButton('C₂H₅OH', _controller1), // Distractor
        _buildKeyboardButton('H₂', _controller1), // Distractor
        _buildKeyboardButton('O₂', _controller1), // Distractor
        _buildKeyboardButton('CH₄', _controller1), // Distractor
      ],
    );
  }

  Widget _buildKeyboardButton(String label, TextEditingController controller) {
    return ElevatedButton(
      onPressed: () {
        _insertText(label, controller);
      },
      child: Text(label),
    );
  }
}
