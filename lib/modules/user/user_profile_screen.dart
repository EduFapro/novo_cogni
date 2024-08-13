import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/evaluation/evaluation_entity.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/module_instance/module_instance_entity.dart';
import '../../app/task_instance/task_instance_entity.dart';
import '../../constants/enums/task_enums.dart';
import 'user_profile_screen_controller.dart';

class UserProfileScreen extends GetView<UserProfileScreenController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações Usuário",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        var userInfo = controller
            .userAvaliador.value; // Remove the '!' to safely access the value
        var evaluationMap = controller.evaluationMap;

        return SingleChildScrollView(
          child: Column(
            children: [
              // Check if userInfo is not null before building the UserInfoSection
              if (userInfo != null) UserInfoSection(userInfo: userInfo),

              // Evaluations and Module Instances
              ...evaluationMap.entries
                  .map((entry) => EvaluationSection(
                        evaluation: entry.key,
                        moduleInstanceMap: entry.value,
                      ))
                  .toList(),
            ],
          ),
        );
      }),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final EvaluatorEntity userInfo;

  const UserInfoSection({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: ExpansionTile(
        title: Text("Avaliador: ${userInfo.name}"),
        children: [
          ListTile(
            title: Text("${userInfo.name} ${userInfo.surname}"),
            subtitle: Text("Username: ${userInfo.username}"),
            // Add more details as needed
          ),
        ],
      ),
    );
  }
}

class EvaluationSection extends StatelessWidget {
  final EvaluationEntity evaluation;
  final Map<ModuleInstanceEntity, List<TaskInstanceEntity>> moduleInstanceMap;

  const EvaluationSection({
    Key? key,
    required this.evaluation,
    required this.moduleInstanceMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileScreenController>();
    String participantName =
        controller.participants[evaluation.participantID]?.fullName ??
            "Unknown";

    return Container(
      color: Colors.blueAccent.shade100,
      child: ExpansionTile(
        title: Text(
            "Id da Avaliação: ${evaluation.evaluationID} - Avaliando: $participantName"),
        children: moduleInstanceMap.entries
            .map((moduleEntry) => ModuleInstanceSection(
                  moduleInstance: moduleEntry.key,
                  taskInstances: moduleEntry.value,
                ))
            .toList(),
      ),
    );
  }
}

class ModuleInstanceSection extends StatelessWidget {
  final ModuleInstanceEntity moduleInstance;
  final List<TaskInstanceEntity> taskInstances;

  const ModuleInstanceSection({
    Key? key,
    required this.moduleInstance,
    required this.taskInstances,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserProfileScreenController>();
    String moduleName =
        controller.modules[moduleInstance.moduleID]?.title ?? "Unknown Module";

    return Container(
      color: Colors.lightBlue.shade100,
      padding: const EdgeInsets.only(left: 20.0),
      child: ExpansionTile(
        title: Text("Módulo: $moduleName"),
        children: taskInstances.map((task) {
          String taskTitle =
              controller.tasks[task.taskID]?.title ?? "Tarefa Desconhecida";
          String statusTranslated = translateTaskStatus(
              task.status.description);
          String recordingPath = controller.taskRecordingPaths[task.taskInstanceID] ?? "No recording";

          return Container(
            color: Colors.lightBlue.shade50,
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              title: Text("Tarefa: $taskTitle - $statusTranslated"),
              trailing: Container(
                color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (recordingPath != "No recording") {
                          print("Playing audio from path: $recordingPath");
                          controller.playRecorded(recordingPath);
                        } else {
                          print("No recording available for this task.");
                        }
                      },
                      child: Text(
                        "Tocar Gravação",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text("Duração: ${task.completingTime ?? 'Não concluída'}"),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String translateTaskStatus(String status) {
    switch (status) {
      case 'done':
        return 'Concluído';
      case 'pending':
        return 'Pendente';
      default:
        return 'Desconhecido';
    }
  }
}
