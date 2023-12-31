import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import 'package:novo_cogni/enums/task_enums.dart';
import '../entities/task_entity.dart';

// Module and task identifiers
int testModuleId = 1;
int way2AgeModuleId = 2;

List<String> taskTitles = ["Listen to the Audio", "Tell Us Your Name", "Tell a Story", "Count Up to 10!"];

// Module titles
List<String> moduleTitles = ['Tests', 'Way2Age'];

// Tasks for the 'Tests' module
TaskEntity listenTask = TaskEntity(title: taskTitles[0], moduleID: testModuleId, taskMode: TaskMode.play, position: 0);
TaskEntity introduceTask = TaskEntity(title: taskTitles[1], moduleID: testModuleId, taskMode: TaskMode.record, position: 1);

ModuleEntity testModule = ModuleEntity(tasks: [listenTask, introduceTask], moduleID: testModuleId, title: moduleTitles[0]);

// Tasks for the 'Way2Age' module
TaskEntity tellStoryTask = TaskEntity(title: taskTitles[2], moduleID: way2AgeModuleId, taskMode: TaskMode.play, position: 0);
TaskEntity countToTenTask = TaskEntity(title: taskTitles[3], moduleID: way2AgeModuleId, taskMode: TaskMode.play, position: 1);

ModuleEntity way2AgeModule = ModuleEntity(tasks: [tellStoryTask, countToTenTask], moduleID: way2AgeModuleId, title: moduleTitles[1]);

// Lists of modules and tasks
List<ModuleEntity> modulesList = [testModule, way2AgeModule];
List<TaskEntity> tasksList = [listenTask, introduceTask, tellStoryTask, countToTenTask];

// Lists of modules and tasks
//
// List<ModuleEntity> modulesList = [];
// List<TaskEntity> tasksList = [];
