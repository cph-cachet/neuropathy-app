// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/ui/results/result_page.dart';
import 'package:neuropathy_grading_tool/ui/widgets/neuropathy_icons.dart';

import 'package:neuropathy_grading_tool/utils/date_formatter.dart';
import 'package:neuropathy_grading_tool/utils/generate_csv.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/examination_score.dart';
import 'package:to_csv/to_csv.dart' as export_csv;

import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';

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
    Widget slideTransition(animation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: child,
      );
    }

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
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => ResultPage(
                  patient: patient,
                  result: taskResults[index],
                ),
                transitionDuration: const Duration(milliseconds: 400),
                transitionsBuilder: (_, animation, __, child) =>
                    slideTransition(animation, child),
              ));
            },
          ),
        );
      },
    );
  }
}
