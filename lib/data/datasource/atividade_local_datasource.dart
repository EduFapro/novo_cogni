import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/atividade_entity.dart';
import '../data_constants/atividade_constants.dart';
import '../data_constants/constantes_gerais.dart';
import 'database_helper.dart';

class AtividadeLocalDataSource {

  static final AtividadeLocalDataSource _instance = AtividadeLocalDataSource.internal();

  factory AtividadeLocalDataSource() => _instance;

  AtividadeLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(AtividadeEntity atividade) async {
    try {
      final Database? database = await db;

      return await database!.insert(
        TABELA_ATIVIDADES,
        atividade.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<AtividadeEntity?> getAtividade(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABELA_ATIVIDADES,
        where: '$ID_ATIVIDADE = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return AtividadeEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<int> deleteAtividade(int id) async {
    try {
      final Database? database = await db;

      return await database!.delete(
        TABELA_ATIVIDADES,
        where: "$ID_ATIVIDADE = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateAtividade(AtividadeEntity atividade) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABELA_ATIVIDADES,
        atividade.toMap(),
        where: "$ID_ATIVIDADE = ?",
        whereArgs: [atividade.atividadeID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<AtividadeEntity>> getAllAtividades() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABELA_ATIVIDADES);

      return List.generate(maps.length, (i) {
        return AtividadeEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<int?> getNumeroAtividades() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABELA_ATIVIDADES");
    return result.first["count"] as int?;
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }
}
