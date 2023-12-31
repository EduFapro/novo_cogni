import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/module_entity.dart';
import '../data_constants/module_constants.dart';
import '../data_constants/database_constants.dart';
import 'database_helper.dart';

class ModuleLocalDataSource {

  static final ModuleLocalDataSource _instance = ModuleLocalDataSource.internal();

  factory ModuleLocalDataSource() => _instance;

  ModuleLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(ModuleEntity module) async {
    try {
      final Database? database = await db;

      return await database!.insert(
        TABLE_MODULES,
        module.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<ModuleEntity?> getModuleById(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_MODULES,
        where: '$ID_MODULE = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ModuleEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<int> deleteModule(int id) async {
    try {
      final Database? database = await db;

      return await database!.delete(
        TABLE_MODULES,
        where: "$ID_MODULE = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateModule(ModuleEntity module) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABLE_MODULES,
        module.toMap(),
        where: "$ID_MODULE = ?",
        whereArgs: [module.moduleID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<ModuleEntity>> getAllModules() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABLE_MODULES);

      return List.generate(maps.length, (i) {
        return ModuleEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<int?> getNumberOfModules() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABLE_MODULES");
    return result.first["count"] as int?;
  }

  Future<ModuleEntity?> getModuleByName(String title) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_MODULES,
        where: '$TITLE = ?',
        whereArgs: [title],
      );

      if (maps.isNotEmpty) {
        return ModuleEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }
}
