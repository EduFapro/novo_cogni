import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/tarefa_entity.dart';
import '../data_constants/database_constants.dart';
import '../data_constants/tarefa_constants.dart';
import 'database_helper.dart';

class TarefaLocalDataSource {
  static final TarefaLocalDataSource _instance = TarefaLocalDataSource.internal();

  factory TarefaLocalDataSource() => _instance;

  TarefaLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(TarefaEntity tarefa) async {
    try {
      final Database? database = await db;

      return await database!.insert(
        TABELA_TAREFAS,
        tarefa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<TarefaEntity?> getTarefa(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABELA_TAREFAS,
        where: '$ID_TAREFA = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return TarefaEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<int> deleteTarefa(int id) async {
    try {
      final Database? database = await db;

      return await database!.delete(
        TABELA_TAREFAS,
        where: "$ID_TAREFA = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateTarefa(TarefaEntity tarefa) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABELA_TAREFAS,
        tarefa.toMap(),
        where: "$ID_TAREFA = ?",
        whereArgs: [tarefa.tarefaID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<TarefaEntity>> getAllTarefas() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABELA_TAREFAS);

      return List.generate(maps.length, (i) {
        return TarefaEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<int?> getNumeroTarefas() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABELA_TAREFAS");
    return result.first["count"] as int?;
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }
}
