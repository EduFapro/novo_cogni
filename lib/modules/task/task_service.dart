import 'package:novo_cogni/app/domain/repositories/task_prompt_repository.dart';

import '../../app/domain/entities/task_prompt_entity.dart';

class TaskService {
  final TaskPromptRepository taskPromptRepository;

  TaskService({required this.taskPromptRepository});

  Future<TaskPromptEntity?> getTaskPromptByTaskID(int taskID) async {
    return taskPromptRepository.getTaskPromptByTaskID(taskID);
  }

}
