import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/home/home_controller.dart';
import 'ed_evaluation_history.dart';
import 'ed_folder_card.dart';
import 'ed_new_participant_button.dart';

class EdHomePanel extends GetView<HomeController> {
  const EdHomePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cardWidth = screenWidth / 6;
    double cardHeight = 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Home",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.0),
              EdNewParticipantButton(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: <Widget>[
              Obx(
                    () => EdFolderCard(
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  folderColor: Color(0xff50bee9),
                  titleCard: "Total Projects",
                  number: controller.numEvaluationsTotal.value,
                ),
              ),
              SizedBox(width: 50.0),
              Obx(
                    () => EdFolderCard(
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  folderColor: Color(0xfffdbb11),
                  titleCard: "In Progress",
                  number: controller.numEvaluationsInProgress.value,
                ),
              ),
              SizedBox(width: 50.0),
              Obx(
                    () => EdFolderCard(
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  folderColor: Color(0xff02bf72),
                  titleCard: "Completed",
                  number: controller.numEvaluationsFinished.value,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: EdEvaluationHistory(),
        ),
      ],
    );
  }
}
