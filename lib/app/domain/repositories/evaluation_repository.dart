import '../../data/datasource/evaluation_local_datasource.dart';
import '../../domain/entities/evaluation_entity.dart';

class EvaluationRepository {
  final EvaluationLocalDataSource localDataSource;

  EvaluationRepository({required this.localDataSource});

  // Create an Evaluation
  Future<int?> createEvaluation(EvaluationEntity evaluation) async {
    return await localDataSource.create(evaluation);
  }

  // Get an Evaluation by ID
  Future<EvaluationEntity?> getEvaluation(int id) async {
    return await localDataSource.getEvaluation(id);
  }

  // Delete an Evaluation by ID
  Future<int> deleteEvaluation(int id) async {
    return await localDataSource.deleteEvaluation(id);
  }

  // Update an Evaluation
  Future<int> updateEvaluation(EvaluationEntity evaluation) async {
    return await localDataSource.updateEvaluation(evaluation);
  }

  // Get all Evaluations
  Future<List<EvaluationEntity>> getAllEvaluations() async {
    try {
      return await localDataSource.getAllEvaluations();
    } catch (e) {
      print('Error fetching all evaluations: $e');
      return [];
    }
  }

  // Get the number of Evaluations
  Future<int?> getNumberOfEvaluations() async {
    return await localDataSource.getNumberOfEvaluations();
  }

  // Get Evaluations by Evaluator ID
  Future<List<EvaluationEntity>> getEvaluationsByEvaluatorID(int evaluatorID) async {
    return await localDataSource.getEvaluationsByEvaluatorID(evaluatorID);
  }
}
