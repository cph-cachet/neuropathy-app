import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/examination_score.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/utils/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ExaminationCompletedPage extends StatefulWidget {
  const ExaminationCompletedPage({super.key});

  @override
  State<ExaminationCompletedPage> createState() =>
      _ExaminationCompletedPageState();
}

class _ExaminationCompletedPageState extends State<ExaminationCompletedPage> {
  // Result is fetched from database instead of being passed from examination_page
  // because database changes some fields in the result (and calculateScore
  // accomodates for this). Alternative is to have two calculateScore functions)
  final ResultRepository _resultRepository = GetIt.I.get();
  late RPTaskResult _result;
  bool _hasLoaded = false;
  @override
  void initState() {
    _loadResult();
    super.initState();
  }

  _loadResult() async {
    final result = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getLatest());
    setState(() => _result = result);
    setState(() => _hasLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    double minScore = 0;
    double maxScore = 44;
    int testScore = 0;
    if (_hasLoaded) testScore = calculateScore(_result);

    return Scaffold(
      body: Material(
        textStyle: ThemeTextStyle.headline24sp,
        child: Center(
          child: !_hasLoaded
              ? Text(Languages.of(context)!.translate('common.calculating'))
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