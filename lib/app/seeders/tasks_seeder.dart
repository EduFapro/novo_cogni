import '../../../constants/enums/task_enums.dart';
import '../task/task_entity.dart';
import 'modules_seeder.dart';

// TASKS
String whatsYourNameTaskTitle = "what_is_your_name";
int whatsYourNameTaskId = 1;


TaskEntity whatsYourNameTask = TaskEntity(
    taskID: whatsYourNameTaskId,
    title: whatsYourNameTaskTitle,
    moduleID: way2AgeModuleId,
    taskMode: TaskMode.record,
    timeForCompletion: 40,
    mayRepeatPrompt: true,
    position: 1);



List<TaskEntity> tasksList = [
  whatsYourNameTask,
];


























//
//
//
//
//
//
//
//
//
//
// TaskEntity introduceTask = TaskEntity(
//     taskID: tellUsYourNameId,
//     title: taskTitles[1],
//     moduleID: testModuleId,
//     taskMode: TaskMode.record,
//     position: 1);
//
// TaskEntity tellStoryTask = TaskEntity(
//     taskID: tellUsAStoryId,
//     title: taskTitles[2],
//     moduleID: way2AgeModuleId,
//     taskMode: TaskMode.play,
//     position: 0);
//
// // TaskEntity countToTenTask = TaskEntity(
// //     taskID: countUpTo10,
// //     title: taskTitles[3],
// //     moduleID: way2AgeModuleId,
// //     taskMode: TaskMode.play,
// //     position: 1);
// //
// // int cincoPatinhos = 5;
// // int umPassaroNaMao = 6;
// // int nemTudoQueReluz = 7;
// // int cincoPatinhosWithRecording = 8;
// // int umPassaroNaMaoWithRecording = 9;
// // int nemTudoQueReluzWithRecording = 10;
// //
// // List<String> testingOnlyAudioTasksTitles = [
// //   "Cinco Patinhos",
// //   "Um Pássaro na Mão",
// //   "Nem Tudo Que Reluz"
// // ];
// // List<String> testingAudioWithRecordingTasksTitles = [
// //   "Cinco Patinhos With Recording",
// //   "Um Pássaro na Mão With Recording",
// //   "Nem Tudo Que Reluz With Recording"
// // ];
// // TaskEntity cincoPatinhosTask = TaskEntity(
// //   taskID: cincoPatinhos,
// //   title: testingOnlyAudioTasksTitles[0],
// //   moduleID: testingOnlyAudioId,
// //   taskMode: TaskMode.play,
// //   position: 0,
// // );
// // TaskEntity umPassaroTask = TaskEntity(
// //   taskID: umPassaroNaMao,
// //   title: testingOnlyAudioTasksTitles[1],
// //   moduleID: testingOnlyAudioId,
// //   taskMode: TaskMode.play,
// //   position: 1,
// // );
// // TaskEntity nemTudoTask = TaskEntity(
// //   taskID: nemTudoQueReluz,
// //   title: testingOnlyAudioTasksTitles[2],
// //   moduleID: testingOnlyAudioId,
// //   taskMode: TaskMode.play,
// //   position: 2,
// // );
// //
// // TaskEntity cincoPatinhosTaskWithRecording = TaskEntity(
// //   taskID: cincoPatinhosWithRecording,
// //   title: testingAudioWithRecordingTasksTitles[0],
// //   moduleID: testingRecordingId,
// //   taskMode: TaskMode.record,
// //   position: 0,
// // );
// // TaskEntity umPassaroTaskWithRecording = TaskEntity(
// //   taskID: umPassaroNaMaoWithRecording,
// //   title: testingAudioWithRecordingTasksTitles[1],
// //   moduleID: testingRecordingId,
// //   taskMode: TaskMode.record,
// //   position: 1,
// // );
// // TaskEntity nemTudoTaskWithRecording = TaskEntity(
// //   taskID: nemTudoQueReluzWithRecording,
// //   title: testingAudioWithRecordingTasksTitles[2],
// //   moduleID: testingRecordingId,
// //   taskMode: TaskMode.record,
// //   position: 2,
// // );
//
// List<TaskEntity> tasksList = [
//   listenTask,
//   introduceTask,
//   tellStoryTask,
//   // countToTenTask,
//   // cincoPatinhosTask,
//   // umPassaroTask,
//   // nemTudoTask,
//   // cincoPatinhosTaskWithRecording,
//   // umPassaroTaskWithRecording,
//   // nemTudoTaskWithRecording,
// ];
