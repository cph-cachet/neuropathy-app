import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_planner/ui/rpui_instruction_step.dart';
import 'package:research_package/research_package.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPInstructionStepWithChildren extends RPInstructionStep {
  late final List<Widget> instructionContent;

  RPInstructionStepWithChildren({
    required this.instructionContent,
    required super.identifier,
    super.title = '',
    super.text = '',
  });

  @override
  get stepWidget => RPUIInstructionStepWithChildren(step: this);
}
