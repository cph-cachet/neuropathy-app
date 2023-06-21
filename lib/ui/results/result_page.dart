import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/examination_score.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/survey/free_text_part.dart';
import 'package:neuropathy_grading_tool/survey/step_identifiers.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/comments_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/other_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/pain_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/pin_prick_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/vibration_tile.dart';

import 'package:neuropathy_grading_tool/ui/widgets/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/utils/date_formatter.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:to_csv/to_csv.dart' as export_csv;

import '../../utils/generate_csv.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.result, required this.patient})
      : super(key: key);
  final RPTaskResult result;
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Languages.of(context)!.translate('results.title').toUpperCase(),
            style: ThemeTextStyle.extraLightIBM16sp.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.file_download_outlined),
          onPressed: () {
            CsvData csvData = CsvData.fromResults([result], patient);
            export_csv.myCSV(csvData.headers, csvData.rows);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
                title: DateFormatter(
                    dateTime: result.startDate!,
                    style: ThemeTextStyle.regularIBM20sp),
                subtitle: Text(
                  Languages.of(context)!.translate('results.date'),
                  style: ThemeTextStyle.extraLightIBM16sp,
                ),
                leading: Icon(
                  NeuropathyIcons.carbon_result,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )),
            ListTile(
                title: Text(
                  calculateScore(result).toString(),
                  style: ThemeTextStyle.regularIBM20sp,
                ),
                subtitle: Text(
                  Languages.of(context)!.translate('results.score'),
                  style: ThemeTextStyle.extraLightIBM16sp,
                ),
                leading: Icon(
                  NeuropathyIcons.maki_doctor,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )),
            PinPrickTile(result: result),
            VibrationTile(result: result),
            OtherFindingsTile(taskResult: result),
            if (result.results.keys
                .any((element) => painStepIdentifiers.contains(element)))
              PainTile(taskResult: result),
            if (result.results.keys
                    .any((element) => element == freeTextStep.identifier) &&
                result.results.entries
                        .where(
                            (element) => element.key == freeTextStep.identifier)
                        .map((e) => e.value as RPStepResult)
                        .first
                        .results['answer'] !=
                    null)
              CommentsExpansionTile(
                  text: result.results.entries
                      .where(
                          (element) => element.key == freeTextStep.identifier)
                      .map((e) => e.value as RPStepResult)
                      .first
                      .results['answer']),
          ],
        ),
      ),
    );
  }
}
