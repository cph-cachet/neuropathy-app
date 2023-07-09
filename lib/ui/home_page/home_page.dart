import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/settings_repository.dart';
import 'package:neuropathy_grading_tool/ui/home_page/home_page_body_empty.dart';
import 'package:neuropathy_grading_tool/ui/home_page/home_page_body_examinations.dart';
import 'package:neuropathy_grading_tool/ui/settings/settings.dart';
import 'package:neuropathy_grading_tool/ui/widgets/add_examination_button.dart';
import 'package:neuropathy_grading_tool/ui/widgets/app_loading_indicator.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/model.dart';

/// The home page of the app.
///
/// The init display is a loading indicator, while the app is loading the data from repositories.
/// The home page displays the list of examinations or a welcome message if there are no examinations.
/// The user can add a new examination by pressing the floating action button.
/// The user can also navigate to the settings page by pressing the settings icon.
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ResultRepository _resultRepository = GetIt.I.get();
  final SettingsRepository _settingsRepository = GetIt.I.get();
  Languages languages = Languages();
  List<RPTaskResult> _results = [];
  Patient? _patient;

  bool _hasLoaded = false;
  @override
  void initState() {
    _loadResults();
    _loadPatient();
    super.initState();
  }

  /// Loads the patient information from the settings repository.
  /// Used for examination export.
  _loadPatient() async {
    Patient patient = await _settingsRepository.getPatientInformation();
    setState(() => _patient = patient);
  }

  /// Loads the results from the result repository.
  _loadResults() async {
    final results = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getResults());
    setState(() => _results = results);
    setState(() => _hasLoaded = true);
  }

  @override
  setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// A slide transition that is used when navigating to the settings page.
  Widget _slideTransition(animation, child) {
    const begin = Offset(1.0, 0);
    const end = Offset.zero;
    const curve = Curves.ease;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _hasLoaded
          ? AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                  Languages.of(context)!.translate(widget.title).toUpperCase(),
                  style: AppTextStyle.extraLightIBM16sp.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                    onPressed: () => Navigator.of(context)
                            .push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const SettingsScreen(),
                          transitionsBuilder: (_, animation, __, child) =>
                              _slideTransition(animation, child),
                        ))
                            .then((shouldReload) {
                          // Reload the data if the user has changed relevant settings.
                          if (shouldReload == true) {
                            setState(() => _hasLoaded = false);
                            _loadResults();
                            _loadPatient();
                          }
                        }),
                    icon: const Icon(Icons.settings_outlined))
              ],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _hasLoaded && _results.isNotEmpty
          ? const AddExaminationButton()
          : null,
      body: _hasLoaded
          ? _results.isNotEmpty
              ? HomePageBodyWithExaminations(
                  taskResults: _results,
                  languages: languages,
                  patient: _patient ?? Patient(),
                )
              : const HomePageEmptyResults()
          : Center(
              child: AppLoadingIndicator(
              label: widget.title,
            )),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
