import '../module/module_entity.dart';

int testModuleId = 1;
int way2AgeModuleId = 2;
int testingOnlyAudioId = 3;
int testingRecordingId = 4;

List<String> moduleTitles = ['Tests', 'Way2Age', "testingOnlyAudio", 'testingRecording'];

ModuleEntity testModule = ModuleEntity(
    moduleID: testModuleId,
    title: moduleTitles[0]);

ModuleEntity way2AgeModule = ModuleEntity(
    moduleID: way2AgeModuleId,
    title: moduleTitles[1]);

ModuleEntity testingOnlyAudioModule = ModuleEntity(
    moduleID: testingOnlyAudioId,
    title: moduleTitles[2]);

ModuleEntity testingRecordingModule = ModuleEntity(
  moduleID: testingRecordingId,
  title: moduleTitles[3]);


List<ModuleEntity> modulesList = [
  testModule,
  way2AgeModule,
  testingOnlyAudioModule,
  testingRecordingModule
];

