import 'package:carp_serializable/carp_serializable.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/sembast_result_repository.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/sembast_settings_repository.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/settings_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:research_package/model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Initialize the app.
/// This should be called before the app is run.
///
/// Opens or creates the database, registers it in the GetIt service locator.
/// It registers the sembast repositories. It also registers the json factory for the RP classes.
/// This is needed for the RP classes to be deserialized.
class Init {
  static Future initialize() async {
    await _initSembast();
    _registerRepositories();
    _registerToJsonFactory();
  }

  /// Register the json factory for the RP classes.
  /// They were not automatically deserialized, so we need to register them.
  static _registerToJsonFactory() {
    FromJsonFactory().register(RPTextAnswerFormat(hintText: "Enter your name"));
    FromJsonFactory().register(RPSliderAnswerFormat(
        divisions: 10,
        minValue: 0,
        maxValue: 10,
        prefix: "Not at all",
        suffix: "Very much"));
    FromJsonFactory().register(RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.SingleChoice,
        choices: [
          RPChoice(text: "Yes", value: 1),
          RPChoice(text: "No", value: 0)
        ]));
    FromJsonFactory().register(RPChoice(text: "Yes", value: 1));
  }

  /// Initialize the sembast database.
  /// This is the database used for storing the results and settings.
  /// It is stored in the app's documents directory.
  /// The database is registered in the GetIt service locator.
  static Future _initSembast() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await appDocumentDir.create(recursive: true);
    final dbPath = '${appDocumentDir.path}/app.db';
    final db = await databaseFactoryIo.openDatabase(dbPath);
    GetIt.I.registerSingleton<Database>(db);
  }

  /// Register the sembast repositories.
  static _registerRepositories() {
    GetIt.I.registerLazySingleton<ResultRepository>(
        () => SembastResultRepository());
    GetIt.I.registerLazySingleton<SettingsRepository>(
        () => SembastSettingsRepository());
  }
}
