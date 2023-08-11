import 'package:research_package/research_package.dart';
import 'package:neuropathy_grading_tool/examination/step_identifiers.dart';

/// Calculates the score of a given [RPTaskResult] based on the answers to the questionnaire.
///
/// Only takes into account the [RPStepResult]s with identifiers in [gradingTaskIdentifiers].
/// The list of results is filtered to only contain graded results, then folded.
/// As each of the graded results has only one answer, a single fold is enough.
/// However, if there were any results with multiple answers, the calculation still supports it.
int calculateScore(RPTaskResult result) {
  List<RPStepResult> stepResults = result.results.values
      .where((element) => gradingTaskIdentifiers.contains(element.identifier))
      // map as RPStepResult, as the json deserialization returns them as RPResult
      .map((e) => e as RPStepResult)
      .toList();
  return stepResults.fold(
      0,
      (previousValue, element) =>
          previousValue +
          (element.results['answer'].fold(0, (p, e2) => p + e2['value'])
              as int));
}
