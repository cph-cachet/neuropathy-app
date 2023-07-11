import 'package:neuropathy_grading_tool/utils/calculate_score.dart';
import 'package:neuropathy_grading_tool/examination/sections/free_text_part.dart';
import 'package:neuropathy_grading_tool/examination/step_identifiers.dart';
import 'package:research_package/research_package.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';

/// Headers for the generated CSV file.
List<String> csvHeaders = [
  "timestamp",
  "sex",
  "date of birth",
  "result",
  ...gradingTaskIdentifiers,
  freeTextStep.identifier,
  ...painStepIdentifiers
];

class CsvData {
  final List<String> headers;
  final List<List<String>> rows;
  CsvData(this.headers, this.rows);

  /// Method to generate a CSV file from a list of [RPTaskResult]s.
  /// Each result is mapped to a row in the CSV file.
  CsvData.fromResults(List<RPTaskResult> results, Patient? patient)
      : headers = csvHeaders,
        rows = [
          csvHeaders, // headers were not attached from headers, a package bug.
          ...results.map((e) => resultToCsvRow(e, patient)).toList()
        ];
}

/// Method to generate a CSV row from a [RPTaskResult].
/// Each result is mapped to the corresponding header using [_getCellValue].
List<String> resultToCsvRow(RPTaskResult result, Patient? patient) {
  Map<String, String> rowMap = csvHeaders
      .asMap()
      .map((e, v) => MapEntry(v, _getCellValue(v, result, patient)));
  return rowMap.values.toList();
}

/// Method to get the value of a cell in the CSV file.
///
/// Depending on the header, the value is calculated differently.
/// sex and date of birth are fetched from the [Patient] object or empty.
/// result is calculated using [calculateScore].
/// timestamp is fetched from the [RPTaskResult] object, using ```startDate``` of the examination.
/// All other values are fetched from the [RPTaskResult] object, depending on the ```RPAnswerFormat```
/// using [_getAnswerFromFormat].
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
    case "date of birth":
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

/// Method to get the answer from a [RPStepResult] based on the header and answer format of matching value.
///
/// The answer is calculated differently depending on the answer format.
/// For [RPSliderAnswerFormat] the answer is fetched from ```answer``` and parsed to String.
/// For [RPChoiceAnswerFormat] the answer is fetched from ```answer``` and summed, then parsed to String.
/// For [RPTextAnswerFormat] the answer is fetched from ```answer```. It is already a String and doesn't require parsing.
/// For all other answer formats, the answer is left empty, as they are not supported.
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
          res = val ?? "";
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
