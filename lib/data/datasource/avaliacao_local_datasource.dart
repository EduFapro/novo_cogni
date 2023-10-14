import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/avaliacao_entity.dart';
import '../data_constants/avaliacao_constants.dart';
import '../data_constants/constantes_gerais.dart';
import 'database_helper.dart';

class AvaliacaoLocalDataSource {
  static final AvaliacaoLocalDataSource _instance = AvaliacaoLocalDataSource.internal();

  factory AvaliacaoLocalDataSource() => _instance;
  AvaliacaoLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int> create(AvaliacaoEntity avaliacao) async {
    final Database? database = await db;

    return await database!.insert(
      TABELA_AVALIACOES,
      avaliacao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<AvaliacaoEntity?> getAvaliacao(int id) async {
    final Database? database = await db;
    List<Map<String, dynamic>> maps = await database!.query(
      TABELA_AVALIACOES,
      columns: [
        ID_AVALIACAO,
        ID_AVALIADOR_FK,
        ID_PARTICIPANTE_FK,
      ],
      where: "$ID_AVALIACAO = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return AvaliacaoEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteAvaliacao(int id) async {
    final Database? database = await db;

    return await database!.delete(
      TABELA_AVALIACOES,
      where: "$ID_AVALIACAO = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateAvaliacao(AvaliacaoEntity avaliacao) async {
    final Database? database = await db;

    return await database!.update(
      TABELA_AVALIACOES,
      avaliacao.toMap(),
      where: "$ID_AVALIACAO = ?",
      whereArgs: [avaliacao.avaliacaoID],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AvaliacaoEntity>> getAllAvaliacoes() async {
    final Database? database = await db;

    var result = await database!.query(TABELA_AVALIACOES);
    List<AvaliacaoEntity> avaliacoes = result.isNotEmpty
        ? result.map((c) => AvaliacaoEntity.fromMap(c as Map<String, dynamic>)).toList()
        : [];
    return avaliacoes;
  }

  Future<int?> getNumeroAvaliacoes() async {  // Newly added function
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABELA_AVALIACOES");
    return result.first["count"] as int?;
  }
}
