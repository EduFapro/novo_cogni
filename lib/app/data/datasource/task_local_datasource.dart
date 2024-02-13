import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/entities/task_entity.dart';
import '../data_constants/database_constants.dart';
import '../data_constants/task_constants.dart';
import 'database_helper.dart';
import '../../../constants/enums/task_enums.dart';

class TaskLocalDataSource {
  static final TaskLocalDataSource _instance = TaskLocalDataSource._internal();

  factory TaskLocalDataSource() => _instance;

  TaskLocalDataSource._internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  // Create a new Task
  Future<int?> create(TaskEntity task) async {
    try {
      final Database? database = await db;
      final map = task.toMap();
      map[MODE] = task.taskMode.numericValue;
      return await database!.insert(TABLE_TASKS, map,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Update a Task
  Future<int> updateTask(TaskEntity task) async {
    try {
      final Database? database = await db;
      final map = task.toMap();
      map[MODE] = task.taskMode.numericValue;
      return await database!.update(TABLE_TASKS, map,
          where: '$ID_TASK = ?', whereArgs: [task.taskID]);
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  // Delete a Task by ID
  Future<int> deleteTask(int id) async {
    try {
      final Database? database = await db;
      return await database!
          .delete(TABLE_TASKS, where: '$ID_TASK = ?', whereArgs: [id]);
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  // Retrieve a Task by ID with proper casting
  Future<TaskEntity?> getTask(int id) async {
    try {
      final Database? database = await db;
      final maps = await database!.query(TABLE_TASKS, where: '$ID_TASK = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        final map = Map<String, dynamic>.from(maps.first);
        int modeValue = map[MODE] is int ? map[MODE] as int : 0;
        map[MODE] = TaskModeExtension.fromNumericValue(modeValue);
        return TaskEntity.fromMap(map);
      }
      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }


  // List all Tasks with proper casting
  Future<List<TaskEntity>> listTasks() async {
    try {
      final Database? database = await db;
      final maps = await database!.query(TABLE_TASKS);
      return List.generate(maps.length, (i) {
        // Create a mutable copy of the map
        final map = Map<String, dynamic>.from(maps[i]);
        int modeValue = int.parse(map[MODE].toString());
        // Update the mutable copy with the converted TaskMode
        map[MODE] = TaskModeExtension.fromNumericValue(modeValue);
        // Use the mutable copy to create the TaskEntity
        return TaskEntity.fromMap(map);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }


  // List tasks by Module ID with proper casting
  Future<List<TaskEntity>> listTasksByModuleId(int moduleId) async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_TASKS,
        where: '$MODULE_ID = ?',
        whereArgs: [moduleId],
      );
      return maps.map((map) {
        final newMap = Map<String, dynamic>.from(map);
        newMap[MODE] = TaskModeExtension.fromNumericValue(newMap[MODE] as int);
        return TaskEntity.fromMap(newMap);
      }).toList();

    } catch (e) {
      print('Error fetching tasks for module ID $moduleId: $e');
      return []; // Returning an empty list in case of error
    }
  }





}

