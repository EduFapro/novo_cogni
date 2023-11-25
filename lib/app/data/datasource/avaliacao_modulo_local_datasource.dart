import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/avaliacao_entity.dart';
import '../../domain/entities/avaliacao_modulo_entity.dart';
import '../../domain/entities/modulo_entity.dart';
import '../data_constants/avaliacao_modulo_constants.dart';
import '../data_constants/database_constants.dart';
import 'avaliacao_local_datasource.dart';
import 'database_helper.dart';
import 'modulo_local_datasource.dart';

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

  Future<List<ModuloEntity>> getModulosByAvaliacaoId(int avaliacaoId) async {
    final Database? database = await db;
    final List<Map<String, dynamic>> maps = await database!.query(
      TABELA_AVALIACAO_MODULOS,
      columns: [ID_MODULO_FK],
      where: '$ID_AVALIACAO_FK = ?',
      whereArgs: [avaliacaoId],
    );

    var moduloIds = maps.map((map) => map[ID_MODULO_FK] as int).toList();
    var modulos = <ModuloEntity>[];

    for (var id in moduloIds) {
      var modulo = await ModuloLocalDataSource().getModulo(id);
      if (modulo != null) {
        modulos.add(modulo);
      }
    }

    return modulos;
  }

  Future<List<AvaliacaoEntity>> getAvaliacoesByModuloId(int moduloId) async {
    final Database? database = await db;
    final List<Map<String, dynamic>> maps = await database!.query(
      TABELA_AVALIACAO_MODULOS,
      columns: [ID_AVALIACAO_FK],
      where: '$ID_MODULO_FK = ?',
      whereArgs: [moduloId],
    );

    var avaliacaoIds = maps.map((map) => map[ID_AVALIACAO_FK] as int).toList();
    var avaliacoes = <AvaliacaoEntity>[];

    for (var id in avaliacaoIds) {
      var avaliacao = await AvaliacaoLocalDataSource().getAvaliacao(id);
      if (avaliacao != null) {
        avaliacoes.add(avaliacao);
      }
    }

    return avaliacoes;
  }
}
