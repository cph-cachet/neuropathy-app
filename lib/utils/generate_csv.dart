import 'package:neuro_planner/repositories/result_repository/examination_score.dart';
import 'package:neuro_planner/survey/step_identifiers.dart';
import 'package:research_package/research_package.dart';

List<String> csvHeaders = [
  "timestamp",
  "sex",
  "age",
  "result",
  ...gradingTaskIdentifiers
];

class CsvData {
  final List<String> headers;
  final List<List<String>> rows;

  CsvData(this.headers, this.rows);

  CsvData.fromResults(List<RPTaskResult> results)
      : headers = csvHeaders,
        rows = [csvHeaders, ...results.map((e) => resultToCsvRow(e)).toList()];
}

List<String> resultToCsvRow(RPTaskResult result) {
  Map<String, String> rowMap =
      csvHeaders.asMap().map((e, v) => MapEntry(v, _getCellValue(v, result)));
  return rowMap.values.toList();
}

String _getCellValue(String header, RPTaskResult result) {
  String res = "";
  List<RPStepResult> stepResults =
      result.results.values.cast<RPStepResult>().toList();
  switch (header) {
    case "timestamp":
      res = result.startDate.toString();
      break;
    case "sex":
      res = "";
      break;
    case "age":
      res = "";
      break;
    case "result":
      res = calculateScore(result).toString();
      break;
    default:
      res = stepResults
          .firstWhere((element) => element.identifier == header)
          .results['answer'][0]['value']
          .toString();
      break;
  }
  return res;
}
