import '../../../constants/enums/task_enums.dart';
import '../entities/task_entity.dart';
import 'modules_seeder.dart';

// Module and task identifiers
int listenToAudioId = 1;
int tellUsYourNameId = 2;
int tellUsAStoryId = 3;
int countUpTo10 = 4;

List<String> taskTitles = [
  "Listen to the Audio",
  "Tell Us Your Name",
  "Tell a Story",
  "Count Up to 10!"
];

TaskEntity listenTask = TaskEntity(
    taskID: listenToAudioId,
    title: taskTitles[0],
    moduleID: testModuleId,
    taskMode: TaskMode.play,
    position: 0);

TaskEntity introduceTask = TaskEntity(
    taskID: tellUsYourNameId,
    title: taskTitles[1],
    moduleID: testModuleId,
    taskMode: TaskMode.record,
    position: 1);

TaskEntity tellStoryTask = TaskEntity(
    taskID: tellUsAStoryId,
    title: taskTitles[2],
    moduleID: way2AgeModuleId,
    taskMode: TaskMode.play,
    position: 0);

TaskEntity countToTenTask = TaskEntity(
    taskID: countUpTo10,
    title: taskTitles[3],
    moduleID: way2AgeModuleId,
    taskMode: TaskMode.play,
    position: 1);


int cincoPatinhos = 5;
int umPassaroNaMao = 6;
int nemTudoQueReluz = 7;

List<String> testingOnlyAudioTasksTitles = [
  "Cinco Patinhos",
  "Um Pássaro na Mão",
  "Nem Tudo Que Reluz"
];

TaskEntity cincoPatinhosTask = TaskEntity(
  taskID: cincoPatinhos,
  title: testingOnlyAudioTasksTitles[0],
  moduleID: testingOnlyAudioId,
  taskMode: TaskMode.play,
  position: 0,
);
TaskEntity umPassaroTask = TaskEntity(
  taskID: umPassaroNaMao,
  title: testingOnlyAudioTasksTitles[1],
  moduleID: testingOnlyAudioId,
  taskMode: TaskMode.play,
  position: 1,
);
TaskEntity nemTudoTask = TaskEntity(
  taskID: nemTudoQueReluz,
  title: testingOnlyAudioTasksTitles[2],
  moduleID: testingOnlyAudioId,
  taskMode: TaskMode.play,
  position: 2,
);

List<TaskEntity> tasksList = [
  listenTask,
  introduceTask,
  tellStoryTask,
  countToTenTask,
  cincoPatinhosTask,
  umPassaroTask,
  nemTudoTask
];
