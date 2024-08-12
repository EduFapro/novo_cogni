import 'package:get/get.dart';
import 'package:novo_cogni/app/evaluator/evaluator_repository.dart';
import 'package:novo_cogni/app/participant/participant_repository.dart';

import 'dart:convert';
import 'dart:io';

import '../../app/evaluation/evaluation_entity.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../evaluation/evaluation_service.dart';
import 'package:path/path.dart' as path;

class EvalDataService {
  final evaluationService = Get.find<EvaluationService>();
  final evaluatorRepo = Get.find<EvaluatorRepository>();
  final participantRepo = Get.find<ParticipantRepository>();

  Future<void> generateParticipantRecordFile(
      {required EvaluationEntity evaluation, required String filePath}) async {
    print("generateParticipantRecordFile called");
    print("Calling evaluation service");

    var moduleInstances = await evaluationService
        .getModuleInstancesByEvaluationId(evaluation.evaluationID!);

    List<String> moduleNames =
        await Future.wait(moduleInstances.map((element) async {
      var module = await element.module;
      return module!.title!;
    }));

    Map<String, List<TaskInstanceEntity>> taskMaps = {};

    for (int i = 0; i < moduleInstances.length; i++) {
      var moduleInstId = moduleInstances[i].moduleInstanceID;
      var module = await moduleInstances[i].module;
      var taskInstancesByModule = await evaluationService
          .getTaskInstancesByModuleInstanceId(moduleInstId!);
      taskMaps[module!.title!] = taskInstancesByModule!;
    }

    final evaluator = await evaluatorRepo.getEvaluator(evaluation.evaluatorID);
    final participant =
        await participantRepo.getParticipant(evaluation.participantID);

    var newParticipantRecordFile = ParticipantRecordFile(
        evaluation.evaluationID!,
        evaluation.evaluatorID,
        evaluation.participantID,
        moduleNames,
        taskMaps,
        evaluator!.fullName,
        participant!.fullName);

    print("newParticipantRecordFile: $newParticipantRecordFile");

    ParticipantRecordFile.generateJsonFile(newParticipantRecordFile, filePath);
  }
}

class ParticipantRecordFile {
  final int evaluationID;
  final int evaluatorID;
  final int participantID;
  final List<String> modules;
  final Map<String, List<TaskInstanceEntity>> taskMaps;
  final String nomeAvaliador;
  final String nomeParticipante;

  ParticipantRecordFile(
    this.evaluationID,
    this.evaluatorID,
    this.participantID,
    this.modules,
    this.taskMaps,
    this.nomeAvaliador,
    this.nomeParticipante,
  );

  Future<Map<String, dynamic>> detailedJson() async {
    Map<String, dynamic> details = {
      'Nome do Avaliador': nomeAvaliador,
      'Nome do Avaliando': nomeParticipante,
      'ID da Avaliação': evaluationID,
      'Lista de Módulos': modules,
      'Informações das Tarefas': {}
    };

    for (String key in taskMaps.keys) {
      List<Map<String, dynamic>> detailedTasks = [];
      for (TaskInstanceEntity task in taskMaps[key]!) {
        Map<String, dynamic> taskDetail = await task.detailedJson();
        detailedTasks.add(taskDetail);
      }
      details['Informações das Tarefas'][key] = detailedTasks;
    }

    return details;
  }

  static Future<void> generateJsonFile(
      ParticipantRecordFile participantRecordFile, String directoryPath) async {
    // Make sure the directory path is correct and points to a valid directory
    final String fileName =
        'A${participantRecordFile.evaluatorID.toString().padLeft(2, '0')}P${participantRecordFile.participantID.toString().padLeft(2, '0')}.json';
    final String fullPath = path.join(directoryPath, fileName);
    final file = File(fullPath);

    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true); // Ensure the directory exists
    }

    // Await the detailedJson method to get the fully resolved map
    final detailedData = await participantRecordFile.detailedJson();
    final jsonStr = jsonEncode(detailedData);  // Encode the resolved map
    await file.writeAsString(jsonStr);

    print('JSON file generated: ${file.path}');
  }


  @override
  String toString() {
    return 'ParticipantRecordFile{evaluationID: $evaluationID, evaluatorID: $evaluatorID, participantID: $participantID, modules: $modules, tasks: $taskMaps}';
  }
}
