import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import 'package:novo_cogni/enums/task_enums.dart';
import '../entities/task_entity.dart';

// Module and task identifiers
int testModuleId = 1;
int way2AgeModuleId = 2;

List<String> taskTitles = [
  "Listen to the Audio",
  "Tell Us Your Name",
  "Tell a Story",
  "Count Up to 10!"
];

// // Module titles
// List<String> moduleTitles = ['Tests', 'Way2Age',];

// Tasks for the 'Tests' module
TaskEntity listenTask = TaskEntity(
    title: taskTitles[0],
    moduleID: testModuleId,
    taskMode: TaskMode.play,
    position: 0);
TaskEntity introduceTask = TaskEntity(
    title: taskTitles[1],
    moduleID: testModuleId,
    taskMode: TaskMode.record,
    position: 1);

ModuleEntity testModule = ModuleEntity(
    tasks: [listenTask, introduceTask],
    moduleID: testModuleId,
    title: moduleTitles[0]);

// Tasks for the 'Way2Age' module
TaskEntity tellStoryTask = TaskEntity(
    title: taskTitles[2],
    moduleID: way2AgeModuleId,
    taskMode: TaskMode.play,
    position: 0);
TaskEntity countToTenTask = TaskEntity(
    title: taskTitles[3],
    moduleID: way2AgeModuleId,
    taskMode: TaskMode.play,
    position: 1);

ModuleEntity way2AgeModule = ModuleEntity(
    tasks: [tellStoryTask, countToTenTask],
    moduleID: way2AgeModuleId,
    title: moduleTitles[1]);

int testingOnlyAudioId = 3;
List<String> testingOnlyAudioTasksTitles = [
  "Cinco Patinhos",
  "Um Pássaro na Mão",
  "Nem Tudo Que Reluz"
];
TaskEntity cincoPatinhosTask = TaskEntity(
  title: testingOnlyAudioTasksTitles[0],
  moduleID: testingOnlyAudioId,
  taskMode: TaskMode.play,
  position: 0,
);
TaskEntity umPassaroTask = TaskEntity(
  title: testingOnlyAudioTasksTitles[1],
  moduleID: testingOnlyAudioId,
  taskMode: TaskMode.play,
  position: 1,
);
TaskEntity nemTudoTask = TaskEntity(
  title: testingOnlyAudioTasksTitles[2],
  moduleID: testingOnlyAudioId,
  taskMode: TaskMode.play,
  position: 2,
);

List<String> moduleTitles = ['Tests', 'Way2Age', "testingOnlyAudio"];

ModuleEntity testingOnlyAudioModule = ModuleEntity(
    tasks: [cincoPatinhosTask, umPassaroTask, nemTudoTask],
    moduleID: testingOnlyAudioId,
    title: moduleTitles[2]);

// Lists of modules and tasks
List<ModuleEntity> modulesList = [
  testModule,
  way2AgeModule,
  testingOnlyAudioModule
];
List<TaskEntity> tasksList = [
  listenTask,
  introduceTask,
  tellStoryTask,
  countToTenTask,
  cincoPatinhosTask,
  umPassaroTask,
  nemTudoTask
];
