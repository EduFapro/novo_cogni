import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/task_instance_entity.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_controller.dart';
import 'package:novo_cogni/modules/evaluation/widgets/ed_task_button.dart';
import 'package:novo_cogni/routes.dart';

import '../../../app/domain/entities/task_entity.dart';

class EdModuleInstanceTask extends GetView<EvaluationController> {
  final String moduleName;
  final int moduleId;
  final List<TaskInstanceEntity> taskInstances;

  const EdModuleInstanceTask({
    Key? key,
    required this.moduleName,
    required this.moduleId,
    required this.taskInstances,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.5,
          height: screenHeight * 0.07,
          color: Colors.black54,
          child: Text(
            moduleName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
        ),
        Column(
          children: taskInstances.map((taskInstance) {
            return FutureBuilder<TaskEntity?>(
              future: taskInstance.task,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('Task not found');
                } else {
                  return EdTaskItem(taskName: snapshot.data!.title);
                }
              },
            );
          }).toList(),
        )
      ],
    );
  }
}

class EdTaskItem extends StatelessWidget {
  final String taskName;

  const EdTaskItem({
    Key? key,
    required this.taskName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.red,
      height: screenHeight * 0.09,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD7D8D8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    taskName,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: TasksButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.task,
                    arguments: {
                      'taskName': taskName,
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
