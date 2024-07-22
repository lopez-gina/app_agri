import 'package:app_agri/screens/home.dart';
import 'package:app_agri/screens/question1.dart';
import 'package:app_agri/screens/question2.dart';
import 'package:app_agri/screens/question3.dart';
import 'package:app_agri/screens/question4.dart';
import 'package:app_agri/screens/question5.dart';
import 'package:app_agri/screens/question6.dart';
import 'package:app_agri/screens/summary.dart';
import 'package:flutter/material.dart';

import '../common_widget/custom_app_bar.dart';
import '../common_widget/footer.dart';
import '../globals.dart' as globals;

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final GlobalKey<DragdropState> _question1Key = GlobalKey<DragdropState>();
  final GlobalKey<Question2ScreenState> _question2Key =
      GlobalKey<Question2ScreenState>();
  final GlobalKey<Question3ScreenState> _question3Key =
      GlobalKey<Question3ScreenState>();
  final GlobalKey<Question4ScreenState> _question4Key =
      GlobalKey<Question4ScreenState>();
  final GlobalKey<Question5ScreenState> _question5Key =
      GlobalKey<Question5ScreenState>();
  final GlobalKey<Question6ScreenState> _question6Key =
      GlobalKey<Question6ScreenState>();

  final PageController _pageController = PageController();

  int _currentPage = 0;

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPage = page;
    });
  }

  void _submitAnswer() {
    switch (_currentPage) {
      case 0:
        _question1Key.currentState?.checkAllAnswers();
        break;
      case 1:
        _question2Key.currentState?.checkAllAnswers();
        break;
      case 2:
        _question3Key.currentState?.checkAnswer();
        break;
      case 3:
        _question4Key.currentState?.checkAnswer();
        break;
      case 4:
        _question5Key.currentState?.checkAnswer();
        break;

      default:
        _question6Key.currentState?.checkAllAnswers();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(context: context),
            bottomNavigationBar: Footer(
              onSubmit: () {
                // if (_currentPage > 0 &&
                //     !globals.isSubmitted[_currentPage - 1]) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //         backgroundColor: Colors.redAccent,
                //         content: Text('Please submit previous questions!')),
                //   );
                //   return;
                // }
                _submitAnswer();
                setState(() {});
              },
              onBack:
                  _currentPage > 0 ? () => _goToPage(_currentPage - 1) : () {},
              onNext: _currentPage < 5
                  ? () => _goToPage(_currentPage + 1)
                  : globals.isSubmitted[5]
                      ? () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SummaryScreen()))
                      : () {},
              visible: !globals.isSubmitted[_currentPage],
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                Dragdrop(
                  key: _question1Key,
                ),
                Question2Screen(key: _question2Key),
                Question3Screen(key: _question3Key),
                Question4Screen(
                  key: _question4Key,
                ),
                Question5Screen(
                  key: _question5Key,
                ),
                Question6Screen(
                  key: _question6Key,
                ),
              ],
              onPageChanged: (page) => setState(() => _currentPage = page),
            )));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
