import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/repositories/result_repository/examination_score.dart';
import 'package:neuro_planner/repositories/result_repository/result_repository.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SurveyResultPage extends StatefulWidget {
  const SurveyResultPage({super.key});

  @override
  State<SurveyResultPage> createState() => _SurveyResultPageState();
}

class _SurveyResultPageState extends State<SurveyResultPage> {
  // Result is fetched from database instead of being passed from examination_page
  // because database changes some fields in the result (and calculateScore
  // accomodates for this). Alternative is to have two calculateScore functions)
  final ResultRepository _resultRepository = GetIt.I.get();
  List<RPTaskResult> _results = [];
  bool _hasLoaded = false;
  @override
  void initState() {
    _loadResults();
    super.initState();
  }

  _loadResults() async {
    final results = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getResults());
    setState(() => _results = results);
    setState(() => _hasLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    double minScore = 0;
    double maxScore = 44;
    int testScore = 0;
    if (_hasLoaded) testScore = calculateScore(_results[_results.length - 1]);

    return Scaffold(
      body: Material(
        textStyle: ThemeTextStyle.headline24sp,
        child: Center(
          child: !_hasLoaded
              ? const Text('Calculating result')
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      verticalSpacing(72),
                      Text(
                        Languages.of(context)!.translate('result-screen.title'),
                      ),
                      Column(
                        children: [
                          Text(Languages.of(context)!
                              .translate('result-screen.text-1')),
                          // A RadialGauge half-circle takes the space of a full circle, so we clip the bottom 30%
                          ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 0.7,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SfRadialGauge(
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                        axisLineStyle:
                                            const AxisLineStyle(thickness: 30),
                                        minimum: minScore,
                                        maximum: maxScore,
                                        startAngle: 180,
                                        endAngle: 0,
                                        showTicks: false,
                                        showLabels: false,
                                        radiusFactor: 0.75,
                                        pointers: <GaugePointer>[
                                          RangePointer(
                                            value: testScore.toDouble(),
                                            width: 30,
                                            color: Colors.blue,
                                            enableAnimation: true,
                                          ),
                                          MarkerPointer(
                                            value: testScore.toDouble(),
                                            color: Colors.black,
                                            markerHeight: 20,
                                            markerWidth: 20,
                                            markerOffset: -0.20,
                                            enableAnimation: true,
                                            borderColor: Colors.black,
                                            offsetUnit: GaugeSizeUnit.factor,
                                          )
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              angle: 180,
                                              positionFactor: 1,
                                              verticalAlignment:
                                                  GaugeAlignment.near,
                                              widget: Text(
                                                  '${minScore.toInt()}',
                                                  style: const TextStyle(
                                                      fontSize: 16))),
                                          GaugeAnnotation(
                                              angle: 0,
                                              positionFactor: 1,
                                              verticalAlignment:
                                                  GaugeAlignment.near,
                                              widget: Text(
                                                  '${maxScore.toInt()}',
                                                  style: const TextStyle(
                                                      fontSize: 16)))
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    '${testScore.toInt()}',
                                    style: ThemeTextStyle.header1
                                        .copyWith(fontSize: 60),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            Languages.of(context)!
                                .translate('result-screen.text-2'),
                            textAlign: TextAlign.center,
                          ),
                          verticalSpacing(24),
                          Text(
                            Languages.of(context)!
                                .translate('result-screen.text-3'),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed: (() {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          }),
                          child: Text(Languages.of(context)!
                              .translate('result-screen.button-main'))),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

enum TaskResult { unlikely, likely, probable }
