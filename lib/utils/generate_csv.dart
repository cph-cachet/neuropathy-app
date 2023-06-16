import 'package:neuro_planner/repositories/result_repository/examination_score.dart';
import 'package:neuro_planner/survey/free_text_part.dart';
import 'package:neuro_planner/survey/step_identifiers.dart';
import 'package:research_package/research_package.dart';
import '../repositories/settings_repository/patient.dart';

List<String> csvHeaders = [
  "timestamp",
  "sex",
  "age",
  "result",
  ...gradingTaskIdentifiers,
  freeTextStep.identifier,
  ...painStepIdentifiers
];

class CsvData {
  final List<String> headers;
  final List<List<String>> rows;
  CsvData(this.headers, this.rows);

  CsvData.fromResults(List<RPTaskResult> results, Patient? patient)
      : headers = csvHeaders,
        rows = [
          csvHeaders,
          ...results.map((e) => resultToCsvRow(e, patient)).toList()
        ];
}

List<String> resultToCsvRow(RPTaskResult result, Patient? patient) {
  Map<String, String> rowMap = csvHeaders
      .asMap()
      .map((e, v) => MapEntry(v, _getCellValue(v, result, patient)));
  return rowMap.values.toList();
}

String _getCellValue(String header, RPTaskResult result, Patient? patient) {
  String res = "";
  List<RPStepResult> stepResults =
      result.results.values.cast<RPStepResult>().toList();
  switch (header) {
    case "timestamp":
      res = result.startDate?.toIso8601String() ?? "";
      break;
    case "sex":
      res = patient?.sex != null
          ? Sex.values
              .where((element) => element.value == patient!.sex)
              .first
              .exportText
          : "";
      break;
    case "age":
      res = patient?.dateOfBirth?.toIso8601String() ?? "";
      break;
    case "result":
      res = calculateScore(result).toString();
      break;
    default:
      {
        res = _getAnswerFromFormat(header, stepResults);
        break;
      }
  }
  return res;
}

String _getAnswerFromFormat(String header, List<RPStepResult> stepResults) {
  String res = "";
  if (stepResults.any((element) => element.identifier == header)) {
    RPStepResult stepResult =
        stepResults.firstWhere((element) => element.identifier == header);

    switch (stepResult.answerFormat.runtimeType) {
      case RPSliderAnswerFormat:
        {
          res = stepResult.results['answer'].toString();
          break;
        }
      case RPChoiceAnswerFormat:
        {
          res = stepResult.results['answer']
              .fold(0, (p, e2) => p + e2['value'])
              .toString();
          break;
        }
      case RPTextAnswerFormat:
        {
          var val = stepResult.results['answer'];
          res = val != null ? val[0]['value'].toString() : "";
          break;
        }

      default:
        {
          break;
        }
    }
  }
  return res;
}
