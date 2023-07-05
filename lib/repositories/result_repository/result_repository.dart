import 'package:research_package/research_package.dart';

abstract class ResultRepository {
  /// Returns the [RPTaskResult] with the given [key] from the database.
  Future<RPTaskResult> getResult(int key);

  /// Returns the latest [RPTaskResult] stored in the database.
  ///
  /// Requires at least one result to have been saved in the database.
  Future<RPTaskResult> getLatest();

  /// Returns a list of all [RPTaskResult]s stored in the database.
  ///
  /// The list is sorted from the most recently added result to the oldest.
  Future<List<RPTaskResult>> getResults();

  /// Inserts a [RPTaskResult] into the database. Saves the generated key of the result as `_latestId`.
  Future insertResult(RPTaskResult result);

  /// Deletes the [RPTaskResult] with the given [key] from the database.
  Future<void> deleteResult(int key);

  /// Deletes all [RPTaskResult]s from the database.
  Future<void> deleteAllResults();
}
