import '../../data/datasource/task_prompt_local_datasource.dart';
import '../entities/task_prompt_entity.dart';

class TaskPromptRepository {
  final TaskPromptLocalDataSource _localDataSource;

  TaskPromptRepository(this._localDataSource);

  @override
  Future<int?> create(TaskPromptEntity taskPrompt) async {
    return _localDataSource.create(taskPrompt);
  }

  @override
  Future<TaskPromptEntity?> getTaskPrompt(int id) async {
    return _localDataSource.getTaskPrompt(id);
  }

  @override
  Future<int> updateTaskPrompt(TaskPromptEntity taskPrompt) async {
    return _localDataSource.updateTaskPrompt(taskPrompt);
  }

  @override
  Future<int> deleteTaskPrompt(int id) async {
    return _localDataSource.deleteTaskPrompt(id);
  }

  @override
  Future<List<TaskPromptEntity>> getAllTaskPrompts() async {
    return _localDataSource.getAllTaskPrompts();
  }

  Future<TaskPromptEntity?> getTaskPromptByTaskID(int taskID) async {
    return _localDataSource.getTaskPromptByTaskID(taskID);
  }

}
