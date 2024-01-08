import 'package:novo_cogni/app/data/datasource/task_instance_local_datasource.dart';
import 'package:novo_cogni/app/domain/entities/task_instance_entity.dart';

class TaskInstanceRepository {
  final TaskInstanceLocalDataSource localDataSource;

  TaskInstanceRepository({required this.localDataSource});

  // Create a Task Instance
  Future<int?> createTaskInstance(TaskInstanceEntity taskInstance) async {
    return await localDataSource.create(taskInstance);
  }

  // Get a Task Instance by ID
  Future<TaskInstanceEntity?> getTaskInstance(int id) async {
    return await localDataSource.getTaskInstanceById(id);
  }

  // Delete a Task Instance by ID
  Future<int> deleteTaskInstance(int id) async {
    return await localDataSource.deleteTaskInstance(id);
  }

  // Update a Task Instance
  Future<int> updateTaskInstance(TaskInstanceEntity taskInstance) async {
    return await localDataSource.updateTaskInstance(taskInstance);
  }

  // Get all Task Instances
  Future<List<TaskInstanceEntity>> getAllTaskInstances() async {
    return await localDataSource.getAllTaskInstances();
  }

  // Get Task Instances for a specific Module Instance
  Future<List<TaskInstanceEntity>> getTaskInstancesForModuleInstance(int moduleInstanceId) async {
    return await localDataSource.getTaskInstancesForModuleInstance(moduleInstanceId);
  }

  Future<TaskInstanceEntity?> getFirstPendingTaskInstance() async {
    try {
    return await localDataSource.getFirstPendingTaskInstance();
    } catch (ex) {
      print(ex);
      return null;
    }
  }


  // Close the database
  Future<void> closeDatabase() async {
    await localDataSource.closeDatabase();
  }
}
