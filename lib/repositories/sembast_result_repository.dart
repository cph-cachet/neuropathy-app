import 'dart:convert';

import 'package:carp_serializable/carp_serializable.dart';
import 'package:get_it/get_it.dart';
import 'package:neuro_planner/repositories/result_repository.dart';
import 'package:research_package/model.dart';
import 'package:sembast/sembast.dart';

class SembastResultRepository extends ResultRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("result_store");

  @override
  Future<RPTaskResult> getResult(int id) async {
    final record = await _store.record(id).get(_database);
    return RPTaskResult.fromJson(record as Map<String, dynamic>);
  }

  @override
  Future<List<RPTaskResult>> getResults() async {
    final finder = Finder(sortOrders: [SortOrder('id')]);
    final records = await _store.find(_database, finder: finder);
    //print(records);

    return records.map((snapshot) {
      Map<String, dynamic> stepResultMap1 =
          json.decode(snapshot.value.toString())['results'];

      RPTaskResult taskResult = RPTaskResult.fromJson(
          json.decode(snapshot.value.toString()) as Map<String, dynamic>);
      taskResult.results = stepResultMap1
          .map((key, value) => MapEntry(key, RPStepResult.fromJson(value)));

      return taskResult;
    }).toList();
  }

  @override
  Future insertResult(RPTaskResult result) async {
    await _store.add(_database, toJsonString(result));
  }

  @override
  Future<void> deleteResult(int id) async {
    await _store.record(id).delete(_database);
  }

  @override
  Future<void> deleteAllResults() async {
    await _store.delete(_database);
  }
}
