library module_seeds;

import '../../app/module/module_entity.dart';

part "modules_seeds_constants.dart";


ModuleEntity way2AgeModule = ModuleEntity(
    moduleID: sociodemographicInfoId,
    title: sociodemographicInfo);

// ModuleEntity testsModule = ModuleEntity(
//     moduleID: testModuleId,
//     title: testsModuleTitle);

ModuleEntity testsModule = ModuleEntity(
    moduleID: testsModuleId,
    title: testsModuleTitle);


List<ModuleEntity> modulesList = [
  // testingOnlyAudioModule,
  testsModule,
  way2AgeModule,
];

void printModules() {
  for (var i = 1; i < modulesList.length; i++) {
    print('Module $i: ${modulesList[i].title}');
  }
}