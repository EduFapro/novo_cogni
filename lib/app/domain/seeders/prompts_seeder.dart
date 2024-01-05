import 'package:novo_cogni/app/domain/seeders/tasks_seeder.dart';
import '../../../constants/assets_file_paths.dart';
import '../entities/task_prompt_entity.dart';

final cincoPatinhosTaskPrompt = TaskPromptEntity(
    taskID: cincoPatinhosTask.taskID!, filePath: AudioFilePaths.cincoPatinhos);
final umPassaroTaskPrompt = TaskPromptEntity(
    taskID: umPassaroTask.taskID!,
    filePath: AudioFilePaths.ehMelhorUmPassaro);
final nemTudoTaskPrompt = TaskPromptEntity(
    taskID: nemTudoTask.taskID!, filePath: AudioFilePaths.nemTudoQueReluz);
List<TaskPromptEntity> tasksPromptsList = [
  cincoPatinhosTaskPrompt,
  umPassaroTaskPrompt,
  nemTudoTaskPrompt
];
