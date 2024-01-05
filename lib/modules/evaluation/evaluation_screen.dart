import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/evaluation/widgets/ed_module_instance_task.dart';

import 'evaluation_controller.dart';

class EvaluationScreen extends GetView<EvaluationController> {
  const EvaluationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Avaliação"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.greenAccent,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => Card(
                color: Color(0x00282728),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: screenWidth * 0.3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(controller.participant.value?.name ?? ''),
                        Text('Idade:${controller.age} anos'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: screenWidth,
              child: const Text(
                "Lista de Atividades",
                style: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: screenWidth * 0.3,
                child: Card(
                  child: Obx(() {
                    if (controller.isLoading.isTrue) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      // Retrieve all module titles asynchronously along with their tasks
                      var futureModules = controller.modulesInstanceList.value?.map((moduleInstance) async {
                        var module = await moduleInstance?.module; // Await the future to get the module
                        var tasks = await controller.getTasks(moduleInstance!.moduleID); // Fetch tasks for the module
                        return EdModuleInstanceTask(
                          moduleName: module!.title!,
                          moduleId: moduleInstance.moduleID,
                          taskInstances: tasks, // Pass the tasks here
                        );
                      }).toList() ?? [];

                      return FutureBuilder<List<EdModuleInstanceTask>>(
                        // Wait for all futures to complete
                        future: Future.wait(futureModules),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Text('No modules available');
                          }
                          // Return the list of widgets if data is available
                          return Column(children: snapshot.data!);
                        },
                      );
                    }
                  }),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
