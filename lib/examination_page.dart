import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'linear_survey.dart';

class ExaminationPage extends StatelessWidget {
  const ExaminationPage({super.key});

  void resultCallback(RPTaskResult result) {
    log(toJsonString(result));
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: linearSurveyTask,
      onSubmit: resultCallback,
    );
  }
}
