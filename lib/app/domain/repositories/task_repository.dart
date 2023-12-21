import 'package:novo_cogni/app/data/datasource/task_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/task_entity.dart';

class TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepository({required this.localDataSource});

  // Get Tasks for a Module
  Future<List<TaskEntity>?> getTasksForModule(int moduleId) async {
    try {
      return localDataSource.getTasksForModule(moduleId);
    } on Exception catch (e) {
      print(e);
      print("Failed to retrieve tasks for module with id $moduleId");
      return null;
    }
  }

  // Create a Task
  Future<int?> createTask(TaskEntity task) async {
    return await localDataSource.create(task);
  }

  // Get a Task by ID
  Future<TaskEntity?> getTask(int id) async {
    return await localDataSource.getTask(id);
  }

  // Delete a Task by ID
  Future<int> deleteTask(int id) async {
    return await localDataSource.deleteTask(id);
  }

  // Update a Task
  Future<int> updateTask(TaskEntity task) async {
    return await localDataSource.updateTask(task);
  }

  // Get all Tasks
  Future<List<TaskEntity>> getAllTasks() async {
    return await localDataSource.getAllTasks();
  }

  // Get the number of Tasks
  Future<int?> getNumberOfTasks() async {
    return await localDataSource.getNumberOfTasks();
  }

  // Close the database
  Future<void> closeDatabase() async {
    await localDataSource.closeDatabase();
  }
}
