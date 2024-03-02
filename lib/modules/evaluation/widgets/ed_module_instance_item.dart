import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_controller.dart';

import '../../../app/module_instance/module_instance_entity.dart';
import '../../../app/task_instance/task_instance_entity.dart';
import 'ed_module_button.dart';

class EdModuleInstanceItem extends GetView<EvaluationController> {
  final String moduleName;
  final ModuleInstanceEntity moduleInstace;
  final List<TaskInstanceEntity> taskInstances;

  const EdModuleInstanceItem({
    Key? key,
    required this.moduleName,
    required this.moduleInstace,
    required this.taskInstances,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFA2A0A0), borderRadius: BorderRadius.circular(20)),
      width: screenWidth * 0.5,
      height: screenHeight * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            moduleName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          ModuleButton(
              onPressed: () {
                controller.launchNextTask(moduleInstace);
              },
              moduleStatus: moduleInstace.status),
        ],
      ),
    );
  }
}
