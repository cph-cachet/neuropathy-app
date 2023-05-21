import 'package:carp_serializable/carp_serializable.dart';
import 'package:get_it/get_it.dart';
import 'package:neuro_planner/repositories/result_repository.dart';
import 'package:neuro_planner/repositories/sembast_result_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:research_package/model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Init {
  static Future initialize() async {
    await _initSembast();
    _registerRepositories();
    FromJsonFactory().register(RPChoiceAnswerFormat(
        answerStyle: RPChoiceAnswerStyle.SingleChoice,
        choices: [
          RPChoice(text: "Yes", value: 1),
          RPChoice(text: "No", value: 0)
        ]));
    FromJsonFactory().register(RPChoice(text: "Yes", value: 1));
  }

  static Future _initSembast() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await appDocumentDir.create(recursive: true);
    final dbPath = '${appDocumentDir.path}/app.db';
    final db = await databaseFactoryIo.openDatabase(dbPath);
    GetIt.I.registerSingleton<Database>(db);
  }

  static _registerRepositories() {
    GetIt.I.registerLazySingleton<ResultRepository>(
        () => SembastResultRepository());
  }
}
