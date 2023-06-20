import 'package:research_package/research_package.dart';

abstract class ResultRepository {
  Future<RPTaskResult> getResult(int id);
  Future<RPTaskResult> getLatest();
  Future<List<RPTaskResult>> getResults();
  Future insertResult(RPTaskResult result);
  Future<void> deleteResult(int id);
  Future<void> deleteAllResults();
}
