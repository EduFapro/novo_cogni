import 'package:novo_cogni/app/data/datasource/task_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/task_entity.dart';

class TaskRepository {
  final TaskLocalDataSource _localDataSource;

  TaskRepository({required TaskLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  // Create a Task
  Future<int?> createTask(TaskEntity task) async {
    return await _localDataSource.create(task);
  }

  // Get a Task by ID
  Future<TaskEntity?> getTask(int id) async {
    var task = await _localDataSource.getTask(id);
    if (task != null) {
      var modifiableMap = Map<String, dynamic>.from(task.toMap());
      return TaskEntity.fromMap(modifiableMap);
    }
    return task;
  }

  // Update a Task
  Future<int> updateTask(TaskEntity task) async {
    return await _localDataSource.updateTask(task);
  }

  // Delete a Task by ID
  Future<int> deleteTask(int id) async {
    return await _localDataSource.deleteTask(id);
  }

  // List all Tasks
  Future<List<TaskEntity>> getAllTasks() async {
    return await _localDataSource.listTasks();
  }

  // List tasks by Module ID
  Future<List<TaskEntity>> getTasksForModule(int moduleId) async {
    var tasks = await _localDataSource.listTasksByModuleId(moduleId);
    return tasks.map((task) {
      var modifiableMap = Map<String, dynamic>.from(task.toMap());
      return TaskEntity.fromMap(modifiableMap);
    }).toList();
  }
}
