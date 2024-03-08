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

// MÓDULOS P VERIFICAÇÃO

String testingOnlyAudioTitle = 'Testando Audio';
int testingOnlyAudioModuleId = 9001;

ModuleEntity testingOnlyAudioModule = ModuleEntity(
    moduleID: testingOnlyAudioModuleId,
    title: testingOnlyAudioTitle);

List<ModuleEntity> modulesList = [
  testsModule,
  way2AgeModule,
  testingOnlyAudioModule
];



void printModules() {
  for (var i = 1; i < modulesList.length; i++) {
    print('Module $i: ${modulesList[i].title}');
  }
}


//
// ModuleEntity testingRecordingModule = ModuleEntity(
//   moduleID: testingRecordingId,
//   title: moduleTitles[3]);


