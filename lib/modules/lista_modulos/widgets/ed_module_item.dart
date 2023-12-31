import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes.dart';
import '../modules_list_controller.dart';
import 'ed_task_button.dart';


class EdModuleItem extends GetView<ModulesListController> {
  final String moduleName;
  final int moduleId;

  const EdModuleItem({
    super.key,
    required this.moduleName,
    required this.moduleId
  });

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
                color: Colors.white70),
          ),
        ),
        Obx(() {
          var tasks = controller.tasksListDetails.value
              .firstWhere((element) => element.containsKey(moduleId), orElse: () => {})
          [moduleId] ?? [];

          return Column(
            children: tasks.map((task) => EdTaskItem(taskName: task.title)).toList(),
          );
        }),
      ],
    );
  }
}

class EdTaskItem extends StatelessWidget {
  final String taskName;

  const EdTaskItem({
    super.key,
    required this.taskName,
  });

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
                  Get.toNamed(AppRoutes.task);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
