import 'dart:convert';

import 'package:carp_serializable/carp_serializable.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:research_package/model.dart';
import 'package:sembast/sembast.dart';

class SembastResultRepository extends ResultRepository {
  /// Get or create a singleton instance of [Database].
  final Database _database = GetIt.I.get();

  /// Get a pointer to the result store.
  final StoreRef _store = intMapStoreFactory.store("result_store");

  /// The in-store id of the latest [RPTaskResult] stored in the database.
  // ignore: prefer_typing_uninitialized_variables
  var _latestId;

  /// Decodes a JSON string record to a [RPTaskResult].
  ///
  /// Step result map is decoded separately and added to the task result.
  /// This is necessary because the step result map is not deserialized into [RPStepResult] objects,
  ///  but into [RPResult] instead, resulting in data loss.
  RPTaskResult decodeRecord(record) {
    Map<String, dynamic> stepResultMap1 =
        json.decode(record.toString())['results'];

    RPTaskResult taskResult = RPTaskResult.fromJson(
        json.decode(record.toString()) as Map<String, dynamic>);
    taskResult.results = stepResultMap1
        .map((key, value) => MapEntry(key, RPStepResult.fromJson(value)));

    return taskResult;
  }

  @override
  Future<RPTaskResult> getResult(int key) async {
    final record = await _store.record(key).get(_database);
    return decodeRecord(record);
  }

  @override
  Future<RPTaskResult> getLatest() async {
    return getResult(await _latestId);
  }

  @override
  Future<List<RPTaskResult>> getResults() async {
    final records = await _store.find(_database);
    return records
        .map((snapshot) {
          return decodeRecord(snapshot.value);
        })
        .toList()
        // sort by the most recently added
        .reversed
        .toList();
  }

  @override
  Future insertResult(RPTaskResult result) async {
    _latestId = _store.add(_database, toJsonString(result));
  }

  @override
  Future<void> deleteResult(int key) async {
    await _store.record(key).delete(_database);
  }

  @override
  Future<void> deleteAllResults() async {
    await _store.delete(_database);
  }
}
