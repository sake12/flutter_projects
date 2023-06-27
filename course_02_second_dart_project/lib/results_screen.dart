import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_dart_project/questions/questions_data.dart';
import 'package:second_dart_project/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen(this.chosenAnswers, this.restartQuiz, {super.key});

  final List<String> chosenAnswers;
  final void Function() restartQuiz;
  final List<Map<String, Object>> summary = [];

  List<Map<String, Object>> getSummaryData() {
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final allQuestions = chosenAnswers.length;
    final correctQuestions = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Answered $correctQuestions of $allQuestions answers correctly!',
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: restartQuiz,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 221, 202, 202),
              ),
              icon: const Icon(Icons.anchor),
              label: const Text('Restart Quiz'),
            )
          ],
        ),
      ),
    );
  }
}
