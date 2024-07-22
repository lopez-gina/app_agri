import 'package:app_agri/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:app_agri/globals.dart' as globals;

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.greenAccent.shade100, Colors.green.shade800],
        ),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < globals.isSubmitted.length; i++)
                    Text(
                      "Question ${i + 1}: ${globals.globalScore[i]}/${globals.correctNumbers[i]}",
                      style: const TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.start,
                    ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Total Score: ${globals.globalScore.reduce((value, element) => value + element)}/${globals.correctNumbers.reduce((value, element) => value + element)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  )
                ]),
          ),
          const SizedBox(height: 60.0),
          ElevatedButton(
              onPressed: () {
                globals.globalScore.fillRange(0, 6, 0);
                globals.isSubmitted.fillRange(0, 6, false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ))
        ],
      )),
    ));
  }
}
