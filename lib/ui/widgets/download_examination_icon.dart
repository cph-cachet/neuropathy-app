// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:to_csv/to_csv.dart' as export_csv;

import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/utils/generate_csv.dart';

class DownloadExaminationIcon extends StatelessWidget {
  final List<RPTaskResult> results;
  final Patient patient;
  final double? iconSize;
  const DownloadExaminationIcon({
    Key? key,
    required this.results,
    required this.patient,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.file_download_outlined,
        size: iconSize,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () {
        CsvData csvData = CsvData.fromResults(results, patient);
        export_csv.myCSV(csvData.headers, csvData.rows);
      },
    );
  }
}
