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
    return Container(
      color: Colors.blue.shade800,
      child: ExpansionTile(
        title: Text("Avaliador: ${userInfo.name}",
            style: TextStyle(color: Colors.black)
        ),
        children: [
          ListTile(
            title: Text("${userInfo.name} ${userInfo.surname}",
                style: TextStyle(color: Colors.black)),
            subtitle: Text("Username: ${userInfo.username}",
            style: TextStyle(color: Colors.black),),
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
    String participantName = controller.participants[evaluation.participantID]?.fullName ?? "Unknown";

    return Container(
      color: Colors.blue.shade300,
      padding: EdgeInsets.only(left: 20),
      child: ExpansionTile(
        title: Text("ID da Avaliação: ${evaluation.evaluationID} - Participante: $participantName"),
        children: moduleInstanceMap.entries.map((moduleEntry) => ModuleInstanceSection(
          moduleInstance: moduleEntry.key,
          taskInstances: moduleEntry.value,
        )).toList(),
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
    String moduleName = controller.modules[moduleInstance.moduleID]?.title ?? "Unknown Module";

    return Container(
      color: Colors.blue.shade100,
      padding: EdgeInsets.only(left: 20),
      child: ExpansionTile(
        title: Text("Módulo: $moduleName"),
        children: taskInstances.map((task) {
          String taskTitle = controller.tasks[task.taskID]?.title ?? "Unknown Task";
          String statusTranslated = translateTaskStatus(task.status.description);
          return  Container(

          padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Cor da borda
                width: 1.0, // Largura da borda
              ),
              color: Colors.white70,
              borderRadius: BorderRadius.circular(2.0), // Bordas arredondadas
            ),
            child: ListTile(
              title: Text("Tarefa: $taskTitle - ${statusTranslated}"),
              trailing: Text("Duração: ${task.completingTime ?? 'Não iniciado'}"),
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
