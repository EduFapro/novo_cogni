import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/enums/module_enums.dart';
import '../../../routes.dart';
import '../../widgets/ed_input_text.dart';
import '../home_controller.dart';

class EdEvaluationHistory extends StatelessWidget {
  EdEvaluationHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Evaluation History",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              EdInputText(
                placeholder: "Search...",
                obscureText: false,
              ),
            ],
          ),
        ),
        Obx(() {
          if (homeController.isLoading.isTrue) {
            return Center(child: CircularProgressIndicator());
          } else {
            return buildTable(homeController);
          }
        }),
      ],
    );
  }

  Widget buildTable(HomeController homeController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Table Header
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("Evaluator", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Divider(),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.evaluations.length,
              itemBuilder: (context, index) {
                final evaluation = homeController.evaluations[index];
                final dateFormat = DateFormat.yMd();
                final participante = homeController.participantDetails[evaluation.evaluationID];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(participante?.name ?? 'Unknown')
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(evaluation.status.description)
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(homeController.user.value?.name ?? 'Unknown')
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                              evaluation.evaluationDate != null
                                  ? dateFormat.format(evaluation.evaluationDate!)
                                  : ''
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.module,
                              arguments: {
                                'participant': participante,
                                'evaluation': evaluation,
                              },
                            );
                          },
                          child: const Icon(Icons.create_rounded),
                        ),
                        const Icon(Icons.delete),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
