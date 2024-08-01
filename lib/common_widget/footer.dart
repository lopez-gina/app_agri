import 'package:app_agri/common_widget/score_text.dart';
import 'package:flutter/widgets.dart';

import 'custom_button.dart';
import 'package:app_agri/globals.dart' as globals;

// ignore: must_be_immutable
class Footer extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final VoidCallback onNext;
  bool visible;

  Footer(
      {super.key,
      required this.onSubmit,
      required this.onBack,
      required this.onNext,
      this.visible = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Score Display
          if (!visible) ...[
            ScoreText(
                score: globals.globalScore
                    .reduce((value, element) => value + element)),
            const SizedBox(height: 10),
          ],
          Row(
            mainAxisAlignment:
                visible ? MainAxisAlignment.center : MainAxisAlignment.end,
            children: [
              if (visible)
                CustomButton(
                  text: 'Back',
                  onPressed: onBack,
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(20)),
                ),
              const SizedBox(width: 10),
              CustomButton(
                text: 'Next',
                onPressed: onNext,
                borderRadius: visible
                    ? BorderRadius.zero
                    : const BorderRadius.horizontal(right: Radius.circular(20)),
              ),
              const SizedBox(width: 10),
              if (visible)
                CustomButton(
                  text: 'Submit',
                  onPressed: onSubmit,
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(20)),
                ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
