import 'package:novo_cogni/app/domain/repositories/task_prompt_repository.dart';

import '../../app/domain/entities/task_instance_entity.dart';
import '../../app/domain/entities/task_prompt_entity.dart';
import '../../app/domain/repositories/task_instance_repository.dart';

class TaskService {
  final TaskPromptRepository taskPromptRepository;
  final TaskInstanceRepository taskInstanceRepository;

  TaskService(
      {required this.taskPromptRepository,
      required this.taskInstanceRepository});

  Future<TaskPromptEntity?> getTaskPromptByTaskInstanceID(int taskInstanceId) async {
    try {
      // Log the start of the operation
      print('Fetching task prompt for task instance ID: $taskInstanceId');

      // Retrieve the task prompt
      final taskPrompt = await taskPromptRepository.getTaskPromptByTaskInstanceID(taskInstanceId);

      // Check if the task prompt was successfully retrieved
      if (taskPrompt != null) {
        // Log the successful retrieval
        print('Task prompt retrieved: ${taskPrompt.filePath}');
        return taskPrompt;
      } else {
        // Log the case where no task prompt was found
        print('No task prompt found for task instance ID: $taskInstanceId');
        return null;
      }
    } catch (e) {
      // Log any errors that occur during the operation
      print('Error fetching task prompt for task instance ID: $taskInstanceId: $e');
      return null;
    }
  }


// New method to get a task instance
  Future<TaskInstanceEntity?> getTaskInstance(int taskInstanceId) async {
    return await taskInstanceRepository.getTaskInstance(taskInstanceId);
  }

  // New method to update a task instance
  Future<bool> updateTaskInstance(TaskInstanceEntity taskInstance) async {
    int result = await taskInstanceRepository.updateTaskInstance(taskInstance);
    return result > 0; // Return true if update was successful
  }
}
