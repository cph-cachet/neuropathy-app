// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuro_planner/repositories/settings_repository/settings_repository.dart';
import 'package:neuro_planner/utils/date_formatter.dart';
import 'package:neuro_planner/utils/generate_csv.dart';
import 'package:research_package/research_package.dart';

import '../languages.dart';
import '../repositories/result_repository/examination_score.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

import '../repositories/settings_repository/patient.dart';

class MainPageBodyWithExaminations extends StatelessWidget {
  final List<RPTaskResult> taskResults;
  final Languages languages;
  final Patient patient;
  const MainPageBodyWithExaminations({
    Key? key,
    required this.taskResults,
    required this.languages,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskResults.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            isThreeLine: false,
            title: DateFormatter(dateTime: taskResults[index].startDate!),
            subtitle: Text(calculateScore(taskResults[index]).toString()),
            leading: Icon(
              Icons.thermostat,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.download,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                CsvData csvData =
                    CsvData.fromResults([taskResults[index]], patient);
                exportCSV.myCSV(csvData.headers, csvData.rows);
              },
            ),
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
