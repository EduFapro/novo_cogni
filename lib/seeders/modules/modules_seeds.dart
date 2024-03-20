library module_seeds;

import '../../app/module/module_entity.dart';

part "modules_seeds_constants.dart";


ModuleEntity way2AgeModule = ModuleEntity(
    moduleID: way2AgeModuleId,
    title: way2AgeTitle);

// ModuleEntity testsModule = ModuleEntity(
//     moduleID: testModuleId,
//     title: testsModuleTitle);

ModuleEntity testingOnlyAudioModule = ModuleEntity(
    moduleID: testingOnlyAudioModuleId,
    title: testingOnlyAudioTitle);


List<ModuleEntity> modulesList = [
  testingOnlyAudioModule,
  // testsModule,
  way2AgeModule,
];

void printModules() {
  for (var i = 1; i < modulesList.length; i++) {
    print('Module $i: ${modulesList[i].title}');
  }
}