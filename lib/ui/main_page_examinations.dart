// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:neuro_planner/utils/date_formatter.dart';
import 'package:research_package/research_package.dart';

import '../languages.dart';
import '../repositories/result_repository/examination_score.dart';

class MainPageBodyWithExaminations extends StatelessWidget {
  final List<RPTaskResult> taskResults;
  final Languages languages;
  MainPageBodyWithExaminations({
    Key? key,
    required this.taskResults,
    required this.languages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskResults.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: DateFormatter(dateTime: taskResults[index].startDate!),
            subtitle: Text(calculateScore(taskResults[index]).toString()),
            trailing: const Icon(Icons.download),
            leading: const Icon(Icons.thermostat),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RPUITaskResult(
              //       taskResult: taskResults[index],
              //     ),
              //   ),
              // );
            },
          ),
        );
      },
    );
  }
}
