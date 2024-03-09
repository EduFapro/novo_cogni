import '../../../constants/enums/task_enums.dart';
import '../task/task_entity.dart';
import 'modules_seeder.dart';

// TASKS
String helloHowAreYouTaskTitle = "hello_how_are_you";
int helloHowAreYouTaskId = 1;

String whatsYourNameTaskTitle = "what_is_your_name";
int whatsYourNameTaskId = 2;

String whatsYourDOBTitle = "what_is_dob";
int whatsYourDOBTaskId = 3;

String whatsYourEducationLevelTitle = "what_is_your_education_level";
int whatsYourEducationLevelTaskId = 4;

String whatsYourProfessionTitle = "what_is_your_profession";
int whatsYourProfessionTaskId = 5;

String whoDoYouLiveWithTitle = "who_do_you_live_with";
int whoDoYouLiveWithTaskId = 6;

String doYouExerciseFrequentlyTitle = "do_you_exercise_frequently";
int doYouExerciseFrequentlyTaskId = 7;

String doYouReadFrequentlyTitle = "do_you_read_frequently";
int doYouReadFrequentlyTaskId = 8;

String doYouPlayPuzzlesOrVideoGamesFrequentlyTitle = "do_you_play_puzzles_or_video_games_frequently";
int doYouPlayPuzzlesOrVideoGamesFrequentlyTaskId = 9;

String doYouHaveAnyDiseasesTitle = "do_you_have_any_diseases";
int doYouHaveAnyDiseasesTaskId = 10;

TaskEntity helloHowAreYouTask = TaskEntity(
  taskID: helloHowAreYouTaskId,
  title: helloHowAreYouTaskTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 1,
);

TaskEntity whatsYourNameTask = TaskEntity(
    taskID: whatsYourNameTaskId,
    title: whatsYourNameTaskTitle,
    moduleID: way2AgeModuleId,
    taskMode: TaskMode.record,
    timeForCompletion: 40,
    mayRepeatPrompt: true,
    position: 2);

TaskEntity whatsYourDOBTask = TaskEntity(
  taskID: whatsYourDOBTaskId,
  title: whatsYourDOBTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 3,
);

TaskEntity whatsYourEducationLevelTask = TaskEntity(
  taskID: whatsYourEducationLevelTaskId,
  title: whatsYourEducationLevelTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 4,
);

TaskEntity whatsYourProfessionTask = TaskEntity(
  taskID: whatsYourProfessionTaskId,
  title: whatsYourProfessionTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 5,
);

TaskEntity whoDoYouLiveWithTask = TaskEntity(
  taskID: whoDoYouLiveWithTaskId,
  title: whoDoYouLiveWithTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 6,
);

TaskEntity doYouExerciseFrequentlyTask = TaskEntity(
  taskID: doYouExerciseFrequentlyTaskId,
  title: doYouExerciseFrequentlyTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 7,
);

TaskEntity doYouReadFrequentlyTask = TaskEntity(
  taskID: doYouReadFrequentlyTaskId,
  title: doYouReadFrequentlyTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 8,
);

TaskEntity doYouPlayPuzzlesOrVideoGamesFrequentlyTask = TaskEntity(
  taskID: doYouPlayPuzzlesOrVideoGamesFrequentlyTaskId,
  title: doYouPlayPuzzlesOrVideoGamesFrequentlyTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 9,
);

TaskEntity doYouHaveAnyDiseasesTask = TaskEntity(
  taskID: doYouHaveAnyDiseasesTaskId,
  title: doYouHaveAnyDiseasesTitle,
  moduleID: way2AgeModuleId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 10,
);


// TASKS VERIFICAÇÃO
int cincoPatinhos = 9005;
int umPassaroNaMao = 9006;
int nemTudoQueReluz = 9007;

List<String> testingOnlyAudioTasksTitles = [
  "Cinco Patinhos",
  "Um Pássaro na Mão",
  "Nem Tudo Que Reluz"
];

TaskEntity cincoPatinhosTask = TaskEntity(
  taskID: cincoPatinhos,
  title: testingOnlyAudioTasksTitles[0],
  moduleID: testingOnlyAudioModuleId,
  taskMode: TaskMode.play,
  position: 1,
);
TaskEntity umPassaroTask = TaskEntity(
  taskID: umPassaroNaMao,
  title: testingOnlyAudioTasksTitles[1],
  moduleID: testingOnlyAudioModuleId,
  taskMode: TaskMode.play,
  position: 2,
);
TaskEntity nemTudoTask = TaskEntity(
  taskID: nemTudoQueReluz,
  title: testingOnlyAudioTasksTitles[2],
  moduleID: testingOnlyAudioModuleId,
  taskMode: TaskMode.play,
  position: 3,
);

List<TaskEntity> tasksList = [
  helloHowAreYouTask,
  whatsYourNameTask,
  whatsYourDOBTask,
  whatsYourEducationLevelTask,
  whatsYourProfessionTask,
  whoDoYouLiveWithTask,
  doYouExerciseFrequentlyTask,
  doYouReadFrequentlyTask,
  doYouPlayPuzzlesOrVideoGamesFrequentlyTask,
  doYouHaveAnyDiseasesTask,
  cincoPatinhosTask,
  umPassaroTask,
  nemTudoTask
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
