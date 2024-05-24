import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import 'package:novo_cogni/modules/evaluators/widgets/ed_evaluators_list.dart';

import 'evaluators_controller.dart';
class EvaluatorsScreen extends GetView<EvaluatorsController>  {
  const EvaluatorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = screenHeight * 0.85;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffdfdfd),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(UiStrings.evaluators),
        centerTitle: true,
      ),
      body: Container(
        height: bodyHeight,
        child: EdEvaluatorsList(placeholder: UiStrings.searchPlaceholder,),
      ),
    );
  }
}
