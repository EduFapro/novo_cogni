import 'package:novo_cogni/app/seeders/tasks_seeder.dart';
import '../../../constants/assets_file_paths.dart';
import '../task_prompt/task_prompt_entity.dart';

final cincoPatinhosTaskPromptID = 1;
final umPassaroTaskPromptID = 2;
final nemTudoTaskPromptID = 3;
final cincoPatinhosWithRecordingTaskPromptID = 4;
final umPassaroWithRecordingTaskPromptID = 5;
final nemTudoWithRecordingTaskPromptID = 6;

final cincoPatinhosTaskPrompt = TaskPromptEntity(
    promptID: cincoPatinhosTaskPromptID,
    taskID: cincoPatinhosTask.taskID!,
    filePath: AudioFilePaths.cincoPatinhos);

final umPassaroTaskPrompt = TaskPromptEntity(
    promptID: umPassaroTaskPromptID,
    taskID: umPassaroTask.taskID!,
    filePath: AudioFilePaths.ehMelhorUmPassaro);

final nemTudoTaskPrompt = TaskPromptEntity(
    promptID: nemTudoTaskPromptID,
    taskID: nemTudoTask.taskID!,
    filePath: AudioFilePaths.nemTudoQueReluz);

final cincoPatinhosWithRecordingTaskPrompt = TaskPromptEntity(
    promptID: cincoPatinhosWithRecordingTaskPromptID,
    taskID: cincoPatinhosTaskWithRecording.taskID!,
    filePath: AudioFilePaths.cincoPatinhos);

final umPassaroWithRecordingTaskPrompt = TaskPromptEntity(
    promptID: umPassaroWithRecordingTaskPromptID,
    taskID: umPassaroTaskWithRecording.taskID!,
    filePath: AudioFilePaths.ehMelhorUmPassaro);

final nemTudoWithRecordingTaskPrompt = TaskPromptEntity(
    promptID: nemTudoWithRecordingTaskPromptID,
    taskID: nemTudoTaskWithRecording.taskID!,
    filePath: AudioFilePaths.nemTudoQueReluz);

List<TaskPromptEntity> tasksPromptsList = [
  cincoPatinhosTaskPrompt,
  umPassaroTaskPrompt,
  nemTudoTaskPrompt,
  cincoPatinhosWithRecordingTaskPrompt,
  umPassaroWithRecordingTaskPrompt,
  nemTudoWithRecordingTaskPrompt
];
