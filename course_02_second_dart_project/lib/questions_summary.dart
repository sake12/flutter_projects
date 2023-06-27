import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData
              .map((data) => Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            data['user_answer'] == data['correct_answer']
                                ? const Color.fromARGB(255, 40, 177, 102)
                                : const Color.fromARGB(255, 143, 41, 38),
                        child: Text(
                          ((data['question_index'] as int) + 1).toString(),
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['question'] as String,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 219, 188, 188)),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 5),
                            Text(data['user_answer'].toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 187, 141, 120)),
                                textAlign: TextAlign.left),
                            Text(
                              data['correct_answer'].toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 99, 151, 98)),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
