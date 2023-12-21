import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/task_entity.dart';
import '../data_constants/database_constants.dart';
import '../data_constants/task_constants.dart';
import 'database_helper.dart';

class TaskLocalDataSource {
  static final TaskLocalDataSource _instance = TaskLocalDataSource.internal();

  factory TaskLocalDataSource() => _instance;

  TaskLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(TaskEntity task) async {
    try {
      final Database? database = await db;

      return await database!.insert(
        TABLE_TASKS,
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<TaskEntity?> getTask(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_TASKS,
        where: '$ID_TASK = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return TaskEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final Database? database = await db;

      return await database!.delete(
        TABLE_TASKS,
        where: "$ID_TASK = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateTask(TaskEntity task) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABLE_TASKS,
        task.toMap(),
        where: "$ID_TASK = ?",
        whereArgs: [task.taskID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<TaskEntity>> getAllTasks() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABLE_TASKS);

      return List.generate(maps.length, (i) {
        return TaskEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<int?> getNumberOfTasks() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABLE_TASKS");
    return result.first["count"] as int?;
  }

  Future<List<TaskEntity>> getTasksForModule(int moduleId) async {
    final Database? database = await db;
    final List<Map<String, dynamic>> maps = await database!.query(
      TABLE_TASKS,
      where: '$MODULE_ID = ?',
      whereArgs: [moduleId],
    );
    return List.generate(maps.length, (i) {
      return TaskEntity.fromMap(maps[i]);
    });
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }
}
