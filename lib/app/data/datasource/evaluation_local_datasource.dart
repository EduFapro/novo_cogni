import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/evaluation_entity.dart';
import '../data_constants/evaluation_constants.dart';
import '../data_constants/database_constants.dart';
import 'database_helper.dart';

class EvaluationLocalDataSource {
  static final EvaluationLocalDataSource _instance =
      EvaluationLocalDataSource.internal();

  factory EvaluationLocalDataSource() => _instance;

  EvaluationLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(EvaluationEntity evaluation) async {
    try {
      final Database? database = await db;

      return await database!.insert(
        TABLE_EVALUATIONS,
        evaluation.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<EvaluationEntity?> getEvaluation(int id) async {
    final Database? database = await db;
    List<Map<String, dynamic>> maps = await database!.query(
      TABLE_EVALUATIONS,
      columns: [
        ID_EVALUATION,
        ID_EVALUATOR_FK,
        ID_PARTICIPANT_FK,
      ],
      where: "$ID_EVALUATION = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return EvaluationEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteEvaluation(int id) async {
    final Database? database = await db;

    return await database!.delete(
      TABLE_EVALUATIONS,
      where: "$ID_EVALUATION = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateEvaluation(EvaluationEntity evaluation) async {
    final Database? database = await db;

    return await database!.update(
      TABLE_EVALUATIONS,
      evaluation.toMap(),
      where: "$ID_EVALUATION = ?",
      whereArgs: [evaluation.evaluationID],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<EvaluationEntity>> getAllEvaluations() async {
    final Database? database = await db;

    var result = await database!.query(TABLE_EVALUATIONS);
    List<EvaluationEntity> evaluations = result.isNotEmpty
        ? result
            .map((c) => EvaluationEntity.fromMap(c as Map<String, dynamic>))
            .toList()
        : [];
    return evaluations;
  }

  Future<int?> getNumberOfEvaluations() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!
        .rawQuery("SELECT COUNT(*) AS count FROM $TABLE_EVALUATIONS");
    return result.first["count"] as int?;
  }

  Future<List<EvaluationEntity>> getEvaluationsByEvaluatorID(
      int evaluatorID) async {
    final Database? database = await db;
    List<Map<String, dynamic>> maps = await database!.query(
      TABLE_EVALUATIONS,
      columns: [ID_EVALUATION, ID_EVALUATOR_FK, ID_PARTICIPANT_FK, LANGUAGE],
      where: "$ID_EVALUATOR_FK = ?",
      whereArgs: [evaluatorID],
    );
    if (maps.isNotEmpty) {
      return maps.map((map) => EvaluationEntity.fromMap(map)).toList();
    }
    return [];
  }
}
