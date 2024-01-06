import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import 'package:novo_cogni/modules/evaluators/widgets/ed_evaluators_list.dart';

import 'evaluators_controller.dart';
class EvaluatorsScreen extends StatelessWidget {
  const EvaluatorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final evaluatorsController = Get.find<EvaluatorsController>();
    // final evaluatorsList = evaluatorsController.evaluatorsList;

    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = screenHeight * 0.85;

    return Scaffold(
      appBar: AppBar(
        title: Text(UiStrings.evaluators),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: bodyHeight,
        child: EdEvaluatorsList(placeholder: 'Search...',),
      ),
    );
  }
}
