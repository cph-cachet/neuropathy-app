// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/ui/results/detailed_result_page.dart';
import 'package:neuropathy_grading_tool/ui/widgets/download_examination_icon.dart';
import 'package:neuropathy_grading_tool/utils/neuropathy_icons.dart';

import 'package:neuropathy_grading_tool/utils/date_formatter.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/calculate_score.dart';

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
            trailing: DownloadExaminationIcon(
              results: [taskResults[index]],
              patient: patient,
              iconSize: 30,
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => DetailedResultPage(
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
