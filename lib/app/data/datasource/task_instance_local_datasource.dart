import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/task_instance_entity.dart';
import '../data_constants/database_constants.dart';
import '../data_constants/task_instance_constants.dart';
import 'database_helper.dart';

class TaskInstanceLocalDataSource {
  static final TaskInstanceLocalDataSource _instance = TaskInstanceLocalDataSource.internal();

  factory TaskInstanceLocalDataSource() => _instance;

  TaskInstanceLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(TaskInstanceEntity taskInstance) async {
    try {
      final Database? database = await db;

      return await database!.insert(
        TABLE_TASK_INSTANCES,
        taskInstance.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<TaskInstanceEntity?> getTaskInstance(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_TASK_INSTANCES,
        where: '$ID_TASK_INSTANCE = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return TaskInstanceEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<int> deleteTaskInstance(int id) async {
    try {
      final Database? database = await db;

      return await database!.delete(
        TABLE_TASK_INSTANCES,
        where: "$ID_TASK_INSTANCE = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateTaskInstance(TaskInstanceEntity taskInstance) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABLE_TASK_INSTANCES,
        taskInstance.toMap(),
        where: "$ID_TASK_INSTANCE = ?",
        whereArgs: [taskInstance.taskInstanceID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<TaskInstanceEntity>> getAllTaskInstances() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABLE_TASK_INSTANCES);

      return List.generate(maps.length, (i) {
        return TaskInstanceEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<int?> getNumberOfTaskInstances() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABLE_TASK_INSTANCES");
    return result.first["count"] as int?;
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }

  Future<TaskInstanceEntity?> getTaskInstanceById(int id) async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_TASK_INSTANCES,
        where: '$ID_TASK_INSTANCE = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return TaskInstanceEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }
  Future<List<TaskInstanceEntity>> getTaskInstancesForModuleInstance(int moduleInstanceId) async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_TASK_INSTANCES,
        where: '$ID_MODULE_INSTANCE_FK = ?',
        whereArgs: [moduleInstanceId],
      );

      return List.generate(maps.length, (i) {
        return TaskInstanceEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

}
