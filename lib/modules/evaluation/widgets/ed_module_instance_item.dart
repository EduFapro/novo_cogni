import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/task_instance_entity.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_controller.dart';
import 'package:novo_cogni/modules/evaluation/widgets/ed_task_button.dart';
import 'package:novo_cogni/routes.dart';

import '../../../app/domain/entities/task_entity.dart';
import '../../../constants/route_arguments.dart';
import 'ed_module_button.dart';

class EdModuleInstanceItem extends GetView<EvaluationController> {
  final String moduleName;
  final int moduleId;
  final List<TaskInstanceEntity> taskInstances;

  const EdModuleInstanceItem({
    Key? key,
    required this.moduleName,
    required this.moduleId,
    required this.taskInstances,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFA2A0A0),
        borderRadius: BorderRadius.circular(20)
      ),
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
              controller.launchNextTask();
            },
          )
        ],
      ),
    );
  }
}

// class EdTaskItem extends StatelessWidget {
//   final String taskName;
//   final int taskId;
//   final taskInstanceId;
//
//   const EdTaskItem(
//       {Key? key,
//       required this.taskName,
//       required this.taskId,
//       required this.taskInstanceId})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Container(
//       color: Colors.red,
//       height: screenHeight * 0.09,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFD7D8D8),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     taskName,
//                     style: TextStyle(fontSize: 20, color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(flex: 1, child: SizedBox()),
//             Expanded(
//               flex: 2,
//               child: TasksButton(
//                 onPressed: () {
//                   print(taskId);
//                   Get.toNamed(
//                     AppRoutes.task,
//                     arguments: {
//                       RouteArguments.TASK_NAME: taskName,
//                       RouteArguments.TASK_ID: taskId,
//                       RouteArguments.TASK_INSTANCE_ID: taskInstanceId
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
