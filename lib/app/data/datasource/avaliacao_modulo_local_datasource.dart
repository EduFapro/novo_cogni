import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../data_constants/avaliacao_modulo_constants.dart';
import '../data_constants/database_constants.dart';
import 'database_helper.dart';

class AvaliacaoModuloLocalDataSource {
  static final AvaliacaoModuloLocalDataSource _instance = AvaliacaoModuloLocalDataSource.internal();

  factory AvaliacaoModuloLocalDataSource() => _instance;

  AvaliacaoModuloLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> createAvaliacaoModulo(int avaliacaoId, int moduloId) async {
    try {
      final Database? database = await db;
      return await database!.insert(
        TABELA_AVALIACAO_MODULOS,
        {
          ID_AVALIACAO_FK: avaliacaoId,
          ID_MODULO_FK: moduloId
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

// Add other CRUD operations as needed...
}
