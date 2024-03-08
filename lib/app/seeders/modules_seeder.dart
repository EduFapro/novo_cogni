import '../module/module_entity.dart';

// MODULES
String way2AgeTitle = 'Way2Age';
int way2AgeModuleId = 1;

String testsModuleTitle = 'Tests';
int testModuleId = 2;

ModuleEntity way2AgeModule = ModuleEntity(
    moduleID: way2AgeModuleId,
    title: way2AgeTitle);

ModuleEntity testsModule = ModuleEntity(
    moduleID: testModuleId,
    title: testsModuleTitle);

List<ModuleEntity> modulesList = [
  testsModule,
  way2AgeModule,
];



void printModules() {
  for (var i = 1; i < modulesList.length; i++) {
    print('Module $i: ${modulesList[i].title}');
  }
}

//
// ModuleEntity testingOnlyAudioModule = ModuleEntity(
//     moduleID: testingOnlyAudioId,
//     title: moduleTitles[2]);
//
// ModuleEntity testingRecordingModule = ModuleEntity(
//   moduleID: testingRecordingId,
//   title: moduleTitles[3]);


