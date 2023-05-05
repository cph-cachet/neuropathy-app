import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_vibration_step.dart';

class RPUIVibrationBodyOnlyToggle extends StatelessWidget {
  final RPVibrationStep vibrationStep;
  final Widget toggleButton;

  const RPUIVibrationBodyOnlyToggle(
      {super.key, required this.vibrationStep, required this.toggleButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.35),
                child: vibrationStep.vibrationSection != null &&
                        vibrationStep.vibrationSection!.isNotEmpty
                    ? Image.asset(vibrationStep.vibrationSection!,
                        fit: BoxFit.cover)
                    : const Icon(Icons.error),
              ),
              Text(vibrationStep.title),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              vibrationStep.text ?? '',
              textAlign: TextAlign.center,
            ),
          ),
          toggleButton,
        ],
      ),
    );
  }
}
