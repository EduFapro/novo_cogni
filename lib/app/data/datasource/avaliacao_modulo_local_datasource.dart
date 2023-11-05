import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/entities/avaliacao_modulo_entity.dart';
import '../data_constants/avaliacao_modulo_constants.dart';
import '../data_constants/database_constants.dart';
import 'database_helper.dart';

class AvaliacaoModuloLocalDataSource {
  static final AvaliacaoModuloLocalDataSource _instance =
      AvaliacaoModuloLocalDataSource.internal();

  factory AvaliacaoModuloLocalDataSource() => _instance;

  AvaliacaoModuloLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> createAvaliacaoModulo(int avaliacaoId, int moduloId) async {
    try {
      final Database? database = await db;
      return await database!.insert(
        TABELA_AVALIACAO_MODULOS,
        {ID_AVALIACAO_FK: avaliacaoId, ID_MODULO_FK: moduloId},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<AvaliacaoModuloEntity?> getAvaliacaoModulo(
      int avaliacaoId, int moduloId) async {
    final Database? database = await db;
    final List<Map<String, dynamic>> maps = await database!.query(
      TABELA_AVALIACAO_MODULOS,
      where: '$ID_AVALIACAO_FK = ? AND $ID_MODULO_FK = ?',
      whereArgs: [avaliacaoId, moduloId],
    );

    if (maps.isNotEmpty) {
      return AvaliacaoModuloEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteAvaliacaoModulo(int avaliacaoId, int moduloId) async {
    final Database? database = await db;
    return await database!.delete(
      TABELA_AVALIACAO_MODULOS,
      where: '$ID_AVALIACAO_FK = ? AND $ID_MODULO_FK = ?',
      whereArgs: [avaliacaoId, moduloId],
    );
  }

  Future<int> updateAvaliacaoModulo(
      AvaliacaoModuloEntity avaliacaoModulo) async {
    final Database? database = await db;
    return await database!.update(
      TABELA_AVALIACAO_MODULOS,
      avaliacaoModulo.toMap(),
      where: '$ID_AVALIACAO_FK = ? AND $ID_MODULO_FK = ?',
      whereArgs: [avaliacaoModulo.avaliacaoId, avaliacaoModulo.moduloId],
    );
  }

  Future<List<AvaliacaoModuloEntity>> getAllAvaliacaoModulos() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> maps =
        await database!.query(TABELA_AVALIACAO_MODULOS);

    return List.generate(maps.length, (i) {
      return AvaliacaoModuloEntity.fromMap(maps[i]);
    });
  }
}
