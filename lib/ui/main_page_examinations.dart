// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:neuro_planner/ui/widgets/neuropathy_icons.dart';

import 'package:neuro_planner/utils/date_formatter.dart';
import 'package:neuro_planner/utils/generate_csv.dart';
import 'package:research_package/research_package.dart';

import '../languages.dart';
import '../repositories/result_repository/examination_score.dart';
import 'package:to_csv/to_csv.dart' as export_csv;

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
              NeuropathyIcons.carbon_result,
              size: 45,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.file_download_outlined,
                size: 35,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                CsvData csvData =
                    CsvData.fromResults([taskResults[index]], patient);
                export_csv.myCSV(csvData.headers, csvData.rows);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    patient: patient,
                    result: taskResults[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
