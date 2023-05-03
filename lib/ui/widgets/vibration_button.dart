import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../../utils/spacing.dart';
import '../../utils/themes/styles.dart';

class VibrationButton extends StatefulWidget {
  final int vibDuration = 30000;
  final int countDown = 29;

  const VibrationButton({super.key});

  @override
  VibrationButtonState createState() => VibrationButtonState();
}

class VibrationButtonState extends State<VibrationButton> {
  bool _isVibrating = false;
  CancelableOperation? _futureStopVibrating;

  Future<bool?> _fullTimeVibrated() async {
    await Future.delayed(
      Duration(seconds: widget.countDown),
    );
    return true;
  }

  void _vibrate() async {
    setState(() {
      _isVibrating = true;
    });
    _futureStopVibrating = CancelableOperation.fromFuture(_fullTimeVibrated(),
        onCancel: () => false);
    Vibration.vibrate(duration: widget.vibDuration, amplitude: 255);
    final vibratedMaxTime = await _futureStopVibrating?.value;
    if (vibratedMaxTime == true) {
      setState(() {
        _isVibrating = false;
      });
    }
  }

  void _vibrateStop() {
    _futureStopVibrating?.cancel();
    Vibration.cancel();
    setState(() {
      _isVibrating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isVibrating ? _vibrateStop : _vibrate,
      style: Styles.roundedButtonStyle.copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(
        _isVibrating
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
      )),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_isVibrating ? Icons.pause : Icons.vibration),
              horizontalSpacing(8),
              Text(_isVibrating ? 'Stop' : 'Start'),
            ],
          ),
        ),
      ),
    );
  }
}
