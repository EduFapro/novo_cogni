import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/task_audio_file_entity.dart';
import '../data_constants/database_constants.dart';
import '../data_constants/task_audio_file_constants.dart';
import 'database_helper.dart';

class TaskAudioFileLocalDataSource {
  static final TaskAudioFileLocalDataSource _instance = TaskAudioFileLocalDataSource.internal();

  factory TaskAudioFileLocalDataSource() => _instance;

  TaskAudioFileLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  // Create a Task Audio File
  Future<int?> create(TaskAudioFileEntity taskAudioFile) async {
    try {
      final Database? database = await db;
      return await database!.insert(
        TABLE_FILES,
        taskAudioFile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Get a Task Audio File by ID
  Future<TaskAudioFileEntity?> getTaskAudioFile(int id) async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(
        TABLE_FILES,
        where: '$ID_FILE = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return TaskAudioFileEntity.fromMap(maps.first);
      }
      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Update a Task Audio File
  Future<int> updateTaskAudioFile(TaskAudioFileEntity taskAudioFile) async {
    try {
      final Database? database = await db;
      return await database!.update(
        TABLE_FILES,
        taskAudioFile.toMap(),
        where: "$ID_FILE = ?",
        whereArgs: [taskAudioFile.fileID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  // Delete a Task Audio File
  Future<int> deleteTaskAudioFile(int id) async {
    try {
      final Database? database = await db;
      return await database!.delete(
        TABLE_FILES,
        where: "$ID_FILE = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  // Get all Task Audio Files
  Future<List<TaskAudioFileEntity>> getAllTaskAudioFiles() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABLE_FILES);
      return List.generate(maps.length, (i) {
        return TaskAudioFileEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }
}
