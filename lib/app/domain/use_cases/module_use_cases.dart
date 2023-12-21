import 'package:novo_cogni/app/domain/entities/module_entity.dart';
import '../entities/task_entity.dart';

// Module and task identifiers
int testModuleId = 1;
int way2AgeModuleId = 2;

// Task names
List<String> taskNames = ["Listen to the Audio", "Tell Us Your Name", "Tell a Story", "Count Up to 10!"];

// Module titles
List<String> moduleTitles = ['Tests', 'Way2Age'];

// Tasks for the 'Tests' module
TaskEntity listenTask = TaskEntity(name: taskNames[0], moduleID: testModuleId);
TaskEntity introduceTask = TaskEntity(name: taskNames[1], moduleID: testModuleId);
ModuleEntity testModule = ModuleEntity(tasks: [listenTask, introduceTask], moduleID: testModuleId, title: moduleTitles[0]);

// Tasks for the 'Way2Age' module
TaskEntity tellStoryTask = TaskEntity(name: taskNames[2], moduleID: way2AgeModuleId);
TaskEntity countToTenTask = TaskEntity(name: taskNames[3], moduleID: way2AgeModuleId);
ModuleEntity way2AgeModule = ModuleEntity(tasks: [tellStoryTask, countToTenTask], moduleID: way2AgeModuleId, title: moduleTitles[1]);

// Lists of modules and tasks
List<ModuleEntity> modulesList = [testModule, way2AgeModule];
List<TaskEntity> tasksList = [listenTask, introduceTask, tellStoryTask, countToTenTask];
