import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/modulo_entity.dart';
import '../data_constants/modulo_constants.dart';
import '../data_constants/constantes_gerais.dart';
import 'database_helper.dart';

class AtividadeLocalDataSource {

  static final AtividadeLocalDataSource _instance = AtividadeLocalDataSource.internal();

  factory AtividadeLocalDataSource() => _instance;

  AtividadeLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(ModuloEntity modulo) async {
    try {
      final Database? database = await db;

      return await database!.insert(
        TABELA_MODULOS,
        modulo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<ModuloEntity?> getAtividade(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABELA_MODULOS,
        where: '$ID_MODULO = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ModuloEntity.fromMap(maps.first);
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
        TABELA_MODULOS,
        where: "$ID_MODULO = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateAtividade(ModuloEntity modulo) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABELA_MODULOS,
        modulo.toMap(),
        where: "$ID_MODULO = ?",
        whereArgs: [modulo.moduloID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<ModuloEntity>> getAllAtividades() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABELA_MODULOS);

      return List.generate(maps.length, (i) {
        return ModuloEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<int?> getNumeroAtividades() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABELA_MODULOS");
    return result.first["count"] as int?;
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }
}
