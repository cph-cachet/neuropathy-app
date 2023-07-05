import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/examination_completed_page.dart';
import 'package:research_package/research_package.dart';
import 'examination_survey.dart';

class ExaminationPage extends StatelessWidget {
  final ResultRepository _resultRepository = GetIt.I.get();
  ExaminationPage({super.key});

  void resultCallback(RPTaskResult result) {
    _addResult(result);
  }

  _addResult(RPTaskResult result) async {
    await _resultRepository.insertResult(result);
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: examinationTask,
      onSubmit: (result) {
        resultCallback(result);
        Navigator.of(context).push(MaterialPageRoute<dynamic>(
            builder: (context) => const ExaminationCompletedPage()));
      },
    );
  }
}
