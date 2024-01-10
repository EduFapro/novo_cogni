import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/enums/evaluation_enums.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import 'package:novo_cogni/modules/evaluation/widgets/ed_module_instance_item.dart';

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
        title: Text(UiStrings.evaluation),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0x42000000),
        width: screenWidth,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
Card(
                color: Color(0x00282728),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: screenWidth * 0.8,
                    child: ParticipantCard(),
                  ),
                ),
              ),

            const SizedBox(height: 20),
            Container(
              width: screenWidth,
              child: Text(
                UiStrings.listOfActivities,
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
                width: screenWidth * 0.4,
                child: Card(
                  child: Obx(() {
                    if (controller.isLoading.isTrue) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      var futureModules = controller.modulesInstanceList.value
                              ?.map((moduleInstance) async {
                            var module = await moduleInstance?.module;
                            var tasks = await controller
                                .getTasks(moduleInstance!.moduleInstanceID!);
                            return EdModuleInstanceItem(
                              moduleName: module!.title!,
                              moduleId: moduleInstance.moduleID,
                              taskInstances: tasks,
                            );
                          }).toList() ??
                          [];

                      return FutureBuilder<List<EdModuleInstanceItem>>(
                        // Wait for all futures to complete
                        future: Future.wait(futureModules),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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

class ParticipantCard extends StatelessWidget {
  // No need to extend GetView since this widget doesn't need the controller directly

  @override
  Widget build(BuildContext context) {
    // Use Get.find to access the controller within the build method
    final EvaluationController controller = Get.find<EvaluationController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Now, you're accessing the controller directly without Obx, which is fine
        buildRichText("Nome", controller.participant.value?.name ?? ''),
        buildRichText("Idade", "${controller.age} anos"),
        buildRichText("Status", controller.evaluation.value!.status.description),
      ],
    );
  }

  RichText buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
