import 'package:novo_cogni/app/data/datasource/evaluator_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/evaluator_entity.dart';

/// A repository class that abstracts the data layer for evaluators,
/// providing a clean interface for the domain layer to interact with evaluator data.
class EvaluatorRepository {
  final EvaluatorLocalDataSource localDataSource;

  EvaluatorRepository({required this.localDataSource});

  /// Creates a new evaluator in the database.
  /// Returns the ID of the newly created evaluator or null in case of failure.
  Future<int?> createEvaluator(EvaluatorEntity evaluator) async {
    return await localDataSource.create(evaluator);
  }

  /// Retrieves an evaluator by their ID.
  /// Returns an [EvaluatorEntity] if found, or null otherwise.
  Future<EvaluatorEntity?> getEvaluator(int id) async {
    return await localDataSource.getEvaluator(id);
  }

  /// Retrieves an evaluator by their email address.
  /// Returns an [EvaluatorEntity] if found, or null otherwise.
  Future<EvaluatorEntity?> getEvaluatorByEmail(String email) async {
    return await localDataSource.getEvaluatorByEmail(email);
  }

  /// Deletes an evaluator by their ID.
  /// Returns the number of rows affected (should be 1 if successful, 0 otherwise).
  Future<int> deleteEvaluator(int id) async {
    return await localDataSource.deleteEvaluator(id);
  }

  /// Updates an existing evaluator's information in the database.
  /// Returns the number of rows affected (should be 1 if successful, 0 otherwise).
  Future<int> updateEvaluator(EvaluatorEntity evaluator) async {
    return await localDataSource.updateEvaluator(evaluator);
  }

  /// Retrieves all evaluators from the database.
  /// Returns a list of [EvaluatorEntity] or an empty list in case of failure or if no evaluators are found.
  Future<List<EvaluatorEntity>> getAllEvaluators() async {
    try {
      return await localDataSource.getAllEvaluators();
    } catch (e) {
      print('Error fetching all evaluators: $e');
      return [];
    }
  }

  /// Retrieves the total number of evaluators in the database.
  /// Returns the count or null in case of failure.
  Future<int?> getNumberOfEvaluators() async {
    return await localDataSource.getNumberOfEvaluators();
  }
}
