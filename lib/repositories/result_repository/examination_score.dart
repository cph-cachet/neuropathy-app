import 'package:json_annotation/json_annotation.dart';
import 'package:research_package/research_package.dart';

import '../../survey/step_identifiers.dart';

part 'examination_score.g.dart';

@JsonSerializable()
class ExaminationScore {
  final int taskHashCode;
  final int score;

  ExaminationScore(this.taskHashCode, this.score);

  factory ExaminationScore.fromJson(Map<String, dynamic> json) =>
      _$ExaminationScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ExaminationScoreToJson(this);
}

int calculateScore(RPTaskResult result) {
  result.results.removeWhere(
      (key, value) => !gradingTaskIdentifiers.contains(value.identifier));
  List<RPStepResult> stepResults =
      result.results.values.cast<RPStepResult>().toList();
  return stepResults.fold(
      0,
      (previousValue, element) =>
          previousValue +
          (element.results['answer'].fold(0, (p, e2) => p + e2['value'])
              as int));
}
