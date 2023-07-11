import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neuropathy_grading_tool/ui/examination/steps/rpui_instruction_step.dart';
import 'package:research_package/research_package.dart';

/// Class representing an instruction step in the examination.
///
/// It is represented by [RPUIInstructionStepWithChildren], displaying a column of title and children, where children are passed as a list of [Widget]s.
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
