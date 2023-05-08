import 'package:flutter/material.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SurveyResultPage extends StatelessWidget {
  SurveyResultPage({super.key, required this.result, required this.score});

  late final TaskResult result;
  late final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Survey Result'),
      // ),
      body: Material(
        textStyle: ThemeTextStyle.headline24sp,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              verticalSpacing(72),
              const Text(
                'Examination completed',
              ),
              Column(
                children: [
                  const Text('Your score'),
                  verticalSpacing(32),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 72),
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              centerY: 0.3,
                              radiusFactor: 0.8,
                              minimum: 0,
                              maximum: 50,
                              showLabels: false,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 10,
                                    color: Colors.green,
                                    startWidth: 50,
                                    endWidth: 50),
                                GaugeRange(
                                    startValue: 10,
                                    endValue: 20,
                                    color: Colors.yellow,
                                    startWidth: 50,
                                    endWidth: 50),
                                GaugeRange(
                                    startValue: 20,
                                    endValue: 50,
                                    color: Colors.red,
                                    startWidth: 50,
                                    endWidth: 50),
                              ],
                              pointers: <GaugePointer>[
                                MarkerPointer(
                                  value: score.toDouble(),
                                  //markerType: MarkerType.triangle,
                                  color: Colors.black,
                                  markerHeight: 20,
                                  markerWidth: 20,
                                  markerOffset: -0.15,
                                  enableAnimation: true,
                                  animationDuration: 1000,
                                  borderWidth: 0,
                                  borderColor: Colors.black,
                                  elevation: 0,
                                  offsetUnit: GaugeSizeUnit.factor,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    angle: 180,
                                    positionFactor: 0.8,
                                    horizontalAlignment: GaugeAlignment.center,
                                    verticalAlignment: GaugeAlignment.near,
                                    widget: Container(
                                        child: Text('Unlikely',
                                            style: TextStyle(fontSize: 16)))),
                                GaugeAnnotation(
                                    angle: 0,
                                    positionFactor: 0.8,
                                    horizontalAlignment: GaugeAlignment.center,
                                    verticalAlignment: GaugeAlignment.near,
                                    widget: Container(
                                        child: Text('Probable',
                                            style: TextStyle(fontSize: 16))))
                              ],
                              startAngle: 180,
                              endAngle: 0,
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Unlikely',
                        style: ThemeTextStyle.headline24sp,
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: (() {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  }),
                  child: Text('Back to home')),
            ],
          ),
        ),
      ),
    );
  }
}

enum TaskResult { unlikely, likely, probable }
