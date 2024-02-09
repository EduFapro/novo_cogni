import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/task_instance_entity.dart';
import '../data_constants/database_constants.dart';
import '../data_constants/task_constants.dart';
import '../data_constants/task_instance_constants.dart';
import 'database_helper.dart';

class TaskInstanceLocalDataSource {
  static final TaskInstanceLocalDataSource _instance =
      TaskInstanceLocalDataSource.internal();

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
      final updatedMap = taskInstance.toMap();

      // Include the completingTime in the update if it's not null
      if (taskInstance.completingTime != null) {
        updatedMap[TASK_COMPLETING_TIME] = taskInstance.completingTime;
      }

      return await database!.update(
        TABLE_TASK_INSTANCES,
        updatedMap,
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
      final List<Map<String, dynamic>> maps =
          await database!.query(TABLE_TASK_INSTANCES);

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
    final List<Map<String, dynamic>> result = await database!
        .rawQuery("SELECT COUNT(*) AS count FROM $TABLE_TASK_INSTANCES");
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

  Future<List<TaskInstanceEntity>> getTaskInstancesForModuleInstance(
      int moduleInstanceId) async {
    print(
        "Attempting to fetch task instances for module instance ID: $moduleInstanceId");
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_TASK_INSTANCES,
        where: '$ID_MODULE_INSTANCE_FK = ?',
        whereArgs: [moduleInstanceId],
      );

      print(
          "Successfully fetched ${maps.length} task instances for module instance ID: $moduleInstanceId");
      return List.generate(maps.length, (i) {
        return TaskInstanceEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(
          "Error fetching task instances for module instance ID $moduleInstanceId: $ex");
      return [];
    }
  }

  Future<TaskInstanceEntity?> getFirstPendingTaskInstance() async {
    try {
      final Database? database = await db;
      print("Fetching the first pending task instance...");

      final List<Map<String, dynamic>> maps = await database!.rawQuery('''
      SELECT ti.*
      FROM $TABLE_TASK_INSTANCES ti
      JOIN $TABLE_TASKS t ON ti.$ID_TASK_FK = t.$ID_TASK
      WHERE ti.$TASK_INSTANCE_STATUS = 0
      ORDER BY t.$POSITION ASC
      LIMIT 1
    ''');

      if (maps.isNotEmpty) {
        Map<String, dynamic> editableMap = Map<String, dynamic>.from(maps.first);
        print("Found 1 pending task instance(s). First task instance: $editableMap");
        return TaskInstanceEntity.fromMap(editableMap);
      } else {
        print("No pending task instances found.");
      }
    } catch (ex) {
      print("An error occurred while fetching the first pending task instance: $ex");
    }

    return null;
  }

}
