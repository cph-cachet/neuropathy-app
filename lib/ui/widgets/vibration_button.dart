import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/styles.dart';

/// A button that vibrates the device for a specified duration.
/// It can be stopped by pressing the button again or navigating away from the page.
///
/// Some devices have different limits on how long the vibration can be, so the duration can be specified in the constructor.
/// The default duration is 15 seconds, and it can be changed with the [countDown] parameter.
/// In the application the user can change the duration in the settings.
class VibrationButton extends StatefulWidget {
  final int vibDuration;
  final int countDown;

  const VibrationButton({super.key, this.countDown = 15})
      : vibDuration = countDown * 1000;

  @override
  VibrationButtonState createState() => VibrationButtonState();
}

class VibrationButtonState extends State<VibrationButton> {
  // Prevent changing state after widget is disposed
  // This would happen if future is not completed before navigating away from the page.
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // Cancel vibration on dispose
  @override
  void dispose() {
    Vibration.cancel();
    super.dispose();
  }

  bool _isVibrating = false;

  // Operation that changes the [_isVibrating] state after the vibration completes.
  // Since the device vibration can be cancelled before it completes, this operation should be cancelable
  // before the countdown reaches 0, because it would trigger when i.e. next vibration is going.
  CancelableOperation? _futureStopVibrating;

  Future<bool?> _fullTimeVibrated() async {
    await Future.delayed(
      Duration(seconds: widget.countDown),
    );
    return true;
  }

  /// Start the vibration and set the [_isVibrating] state to true.
  /// The vibration will last for the specified duration.
  /// After vibration completes, the [_isVibrating] state will be set to false.
  void _vibrate() async {
    setState(() {
      _isVibrating = true;
    });
    _futureStopVibrating = CancelableOperation.fromFuture(_fullTimeVibrated(),
        onCancel: () => false);
    Vibration.vibrate(duration: widget.vibDuration, amplitude: 255);
    // Wait for the vibration to complete and set the [_isVibrating] state to false only if the vibration was not cancelled.
    final vibratedMaxTime = await _futureStopVibrating?.value;
    if (vibratedMaxTime == true) {
      setState(() {
        _isVibrating = false;
      });
    }
  }

  /// Cancel the vibration and set the [_isVibrating] state to false.
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
              Text(_isVibrating
                  ? Languages.of(context)!.translate('common.stop')
                  : Languages.of(context)!.translate('common.start')),
            ],
          ),
        ),
      ),
    );
  }
}
