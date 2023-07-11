import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/calculate_score.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/settings_repository.dart';
import 'package:neuropathy_grading_tool/ui/results/detailed_result_page.dart';
import 'package:neuropathy_grading_tool/ui/widgets/download_examination_icon.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
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
  final SettingsRepository _settingsRepository = GetIt.I.get();
  late RPTaskResult _result;
  late Patient _patient;
  bool _hasLoaded = false;
  @override
  void initState() {
    _load();
    super.initState();
  }

  Future<bool> _loadPatient() async {
    final patient = await _settingsRepository.getPatientInformation();
    setState(() => _patient = patient);
    return Future(() => true);
  }

  Future<bool> _loadResult() async {
    final result = await _resultRepository.getLatest();
    setState(() => _result = result);
    return Future(() => true);
  }

  _load() {
    Future.wait([
      _loadPatient(),
      _loadResult(),
      Future.delayed(const Duration(seconds: 1))
    ]).then((_) {
      setState(() => _hasLoaded = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget slideTransition(animation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: child,
      );
    }

    double minScore = 0;
    double maxScore = 44;
    int testScore = 0;
    if (_hasLoaded) testScore = calculateScore(_result);

    return Scaffold(
      body: Material(
        textStyle: AppTextStyle.headline24sp,
        child: Center(
          child: !_hasLoaded
              ? Text(Languages.of(context)!.translate('common.calculating'))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      verticalSpacing(72),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Languages.of(context)!
                                .translate('result-screen.title'),
                          ),
                          horizontalSpacing(12),
                          DownloadExaminationIcon(
                              results: [_result], patient: _patient)
                        ],
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                    style: AppTextStyle.header1
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      DetailedResultPage(
                                    patient: _patient,
                                    result: _result,
                                  ),
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  transitionsBuilder:
                                      (_, animation, __, child) =>
                                          slideTransition(animation, child),
                                ));
                              },
                              child: Text(Languages.of(context)!
                                  .translate('result-screen.button-details'))),
                          horizontalSpacing(16),
                          OutlinedButton(
                              onPressed: (() {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (Route<dynamic> route) => false);
                              }),
                              child: Text(Languages.of(context)!
                                  .translate('result-screen.button-home'))),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

enum TaskResult { unlikely, likely, probable }
