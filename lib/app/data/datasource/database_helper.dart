import 'package:novo_cogni/app/data/data_constants/module_instance_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/use_cases/module_use_cases.dart';
import '../data_constants/module_constants.dart';
import '../data_constants/evaluation_constants.dart';
import '../data_constants/evaluator_constants.dart';
import '../data_constants/database_constants.dart';
import '../data_constants/participant_constants.dart';
import '../data_constants/task_constants.dart';
import '../data_constants/task_instance_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, DATABASE_NAME);
      print("Database path: $path");

      var db = await openDatabase(path,
          version: DATABASE_VERSION, onCreate: _onCreate);
      print("Database initialized");
      return db;
    } catch (e) {
      print("Error initializing database: $e");
      throw e;
    }
  }

  void _onCreate(Database db, int newVersion) async {
    try {
      await db.execute(SCRIPT_CREATE_TABLE_EVALUATORS);
      await db.execute(SCRIPT_CREATE_TABLE_PARTICIPANTS);
      await db.execute(SCRIPT_CREATE_TABLE_EVALUATIONS);
      await db.execute(SCRIPT_CREATE_TABLE_MODULES);
      await db.execute(SCRIPT_CREATE_TABLE_TASKS);
      await db.execute(SCRIPT_CREATE_TABLE_MODULE_INSTANCES);
      await db.execute(SCRIPT_CREATE_TABLE_TASK_INSTANCES);
      insertInitialData();
    } catch (e) {
      print("Error creating tables: $e");
      throw e;
    }
  }

  Future<void> insertInitialData() async {
    final db = await this.db;
    for (var module in modulesList) {
      await db.insert(TABLE_MODULES, module.toMap());
    }
    for (var task in tasksList) {
      await db.insert(TABLE_TASKS, task.toMap());
    }
  }
}
