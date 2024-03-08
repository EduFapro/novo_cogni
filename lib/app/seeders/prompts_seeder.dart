import 'package:novo_cogni/app/seeders/tasks_seeder.dart';
import '../../../constants/assets_file_paths.dart';
import '../task_prompt/task_prompt_entity.dart';

var whatsYourNameTaskPromptID = 1;

final whatsYourNamePrompt = TaskPromptEntity(
  promptID: whatsYourNameTaskPromptID,
  taskID: whatsYourNameTask.taskID!,
  filePath: AudioFilePaths.qual_o_seu_nome,
  transcription: "Qual o seu nome?",
);

final cincoPatinhosTaskPromptID = 9001;
final umPassaroTaskPromptID = 9002;
final nemTudoTaskPromptID = 99033;

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

List<TaskPromptEntity> tasksPromptsList = [
  whatsYourNamePrompt,
  cincoPatinhosTaskPrompt,
  umPassaroTaskPrompt,
  nemTudoTaskPrompt
];

// final cincoPatinhosWithRecordingTaskPrompt = TaskPromptEntity(
//     promptID: cincoPatinhosWithRecordingTaskPromptID,
//     taskID: cincoPatinhosTaskWithRecording.taskID!,
//     filePath: AudioFilePaths.cincoPatinhos);
//
// final umPassaroWithRecordingTaskPrompt = TaskPromptEntity(
//     promptID: umPassaroWithRecordingTaskPromptID,
//     taskID: umPassaroTaskWithRecording.taskID!,
//     filePath: AudioFilePaths.ehMelhorUmPassaro);
//
// final nemTudoWithRecordingTaskPrompt = TaskPromptEntity(
//     promptID: nemTudoWithRecordingTaskPromptID,
//     taskID: nemTudoTaskWithRecording.taskID!,
//     filePath: AudioFilePaths.nemTudoQueReluz);

// List<TaskPromptEntity> tasksPromptsList = [
//   // cincoPatinhosTaskPrompt,
//   // umPassaroTaskPrompt,
//   // nemTudoTaskPrompt,
//   // cincoPatinhosWithRecordingTaskPrompt,
//   // umPassaroWithRecordingTaskPrompt,
//   // nemTudoWithRecordingTaskPrompt
// ];
