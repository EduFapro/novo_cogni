import 'package:novo_cogni/app/data/datasource/evaluator_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/evaluator_entity.dart';

class EvaluatorRepository {
  final EvaluatorLocalDataSource localDataSource;

  EvaluatorRepository({required this.localDataSource});

  // Create an Evaluator
  Future<int?> createEvaluator(EvaluatorEntity evaluator) async {
    return await localDataSource.create(evaluator);
  }

  // Get an Evaluator by ID
  Future<EvaluatorEntity?> getEvaluator(int id) async {
    return await localDataSource.getEvaluator(id);
  }

  // Get an Evaluator by Email
  Future<EvaluatorEntity?> getEvaluatorByEmail(String email) async {
    return await localDataSource.getEvaluatorByEmail(email);
  }

  // Delete an Evaluator by ID
  Future<int> deleteEvaluator(int id) async {
    return await localDataSource.deleteEvaluator(id);
  }

  // Update an Evaluator
  Future<int> updateEvaluator(EvaluatorEntity evaluator) async {
    return await localDataSource.updateEvaluator(evaluator);
  }

  // Get all Evaluators
  Future<List<EvaluatorEntity>> getAllEvaluators() async {
    try {
      return await localDataSource.getAllEvaluators();
    } catch (e) {
      print('Error fetching all evaluators: $e');
      return [];
    }
  }

  // Get the number of Evaluators
  Future<int?> getNumberOfEvaluators() async {
    return await localDataSource.getNumberOfEvaluators();
  }
}
