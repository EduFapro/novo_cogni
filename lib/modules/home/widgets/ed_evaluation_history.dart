import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/constants/enums/evaluation_enums.dart';
import 'package:novo_cogni/constants/route_arguments.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import '../../../routes.dart';
import '../../widgets/ed_input_text.dart';
import '../home_controller.dart';

class EdEvaluationHistory extends GetView<HomeController>  {
  EdEvaluationHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              UiStrings.evaluationHistory,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Obx(
                      () => buildIconLabel(
                    context,
                    Icons.folder_open,
                    UiStrings.totalProjects,
                    controller.numEvaluationsTotal.value,
                  ),
                ),
                Obx(
                      () => buildIconLabel(
                    context,
                    Icons.hourglass_empty,
                    UiStrings.inProgress,
                    controller.numEvaluationsInProgress.value,
                  ),
                ),
                Obx(
                      () => buildIconLabel(
                    context,
                    Icons.check_circle_outline,
                    UiStrings.completed,
                    controller.numEvaluationsFinished.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            EdInputText(
              placeholder: "Search...",
              obscureText: false,
            ),
          ],
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

  Widget buildTable(HomeController homeController)  {
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
                child: Text(UiStrings.name, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text(UiStrings.status, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text(UiStrings.evaluator, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text(UiStrings.date, style: TextStyle(fontWeight: FontWeight.bold)),
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
                final participant = homeController.participantDetails[evaluation.evaluationID];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(participant?.name ?? 'Unknown')
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
                              AppRoutes.evaluation,
                              arguments: {
                                RouteArguments.PARTICIPANT: participant,
                                RouteArguments.EVALUATION: evaluation,
                              },
                            );
                          },
                          child: const Icon(Icons.create_rounded),
                        ),
                        const Icon(Icons.delete),
                        GestureDetector(
                          onTap: () {
                            print('Download button tapped for evaluation ID: ${evaluation.evaluationID}');
                            homeController.createDownload(evaluation!);
                          },
                          child: const Icon(Icons.download_rounded),
                        ),
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


  Widget buildIconLabel(
      BuildContext context, IconData icon, String label, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 24.0),
          SizedBox(width: 8.0),
          Text('$label: $count'),
        ],
      ),
    );
  }
}
