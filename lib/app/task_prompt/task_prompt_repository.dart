import 'package:novo_cogni/app/task_prompt/task_prompt_entity.dart';
import 'package:novo_cogni/app/task_prompt/task_prompt_local_datasource.dart';

class TaskPromptRepository {
  final TaskPromptLocalDataSource localDataSource;

  TaskPromptRepository({required this.localDataSource});

  @override
  Future<int?> create(TaskPromptEntity taskPrompt) async {
    return localDataSource.create(taskPrompt);
  }

  @override
  Future<TaskPromptEntity?> getTaskPrompt(int id) async {
    return localDataSource.getTaskPrompt(id);
  }

  @override
  Future<int> updateTaskPrompt(TaskPromptEntity taskPrompt) async {
    return localDataSource.updateTaskPrompt(taskPrompt);
  }

  @override
  Future<int> deleteTaskPrompt(int id) async {
    return localDataSource.deleteTaskPrompt(id);
  }

  @override
  Future<List<TaskPromptEntity>> getAllTaskPrompts() async {
    return localDataSource.getAllTaskPrompts();
  }

  Future<TaskPromptEntity?> getTaskPromptByTaskInstanceID(int taskID) async {
    return localDataSource.getTaskPromptByTaskID(taskID);
  }

}
