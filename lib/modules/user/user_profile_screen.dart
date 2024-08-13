import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/evaluation/evaluation_entity.dart';
import '../../app/evaluator/evaluator_entity.dart';
import '../../app/module_instance/module_instance_entity.dart';
import '../../app/task_instance/task_instance_entity.dart';
import 'user_profile_screen_controller.dart';

class UserProfileScreen extends GetView<UserProfileScreenController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações Usuário", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        var userInfo = controller.userAvaliador.value;
        var evaluationMap = controller.evaluationMap;

        return SingleChildScrollView(
          child: Column(
            children: [
              if (userInfo != null) UserInfoSection(userInfo: userInfo),
              ...evaluationMap.entries.map((entry) => EvaluationSection(
                  evaluation: entry.key,
                  moduleInstanceMap: entry.value)).toList(),
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
    return ExpansionTile(
      title: Text("Evaluator: ${userInfo.name}"),
      children: [
        ListTile(
          title: Text("${userInfo.name} ${userInfo.surname}"),
          subtitle: Text("Username: ${userInfo.username}"),
          // Add more details as needed
        ),
      ],
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
    String participantName = controller.participants[evaluation.participantID]?.fullName ?? "Unknown";

    return ExpansionTile(
      title: Text("Evaluation: ${evaluation.evaluationID} - Participant: $participantName"),
      children: moduleInstanceMap.entries.map((moduleEntry) => ModuleInstanceSection(
        moduleInstance: moduleEntry.key,
        taskInstances: moduleEntry.value,
      )).toList(),
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
    String moduleName = controller.modules[moduleInstance.moduleID]?.title ?? "Unknown Module";

    return ExpansionTile(
      title: Text("Module: $moduleName"),
      children: taskInstances.map((task) {
        String taskTitle = controller.tasks[task.taskID]?.title ?? "Unknown Task";
        return ListTile(
          title: Text("Task: $taskTitle - ${task.status.description}"),
          trailing: Text("Duration: ${task.completingTime ?? 'Not completed'}"),
        );
      }).toList(),
    );
  }
}
