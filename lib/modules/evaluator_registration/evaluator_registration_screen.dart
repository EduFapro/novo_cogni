import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import 'package:novo_cogni/modules/evaluator_registration/widgets/ed_evaluator_form.dart';
import 'evaluator_registration_controller.dart';

class EvaluatorRegistrationScreen extends GetView<EvaluatorRegistrationController> {
  const EvaluatorRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageTitle = controller.saveAsAdmin.isTrue ? UiStrings.adminRegistration : UiStrings.evaluatorRegistration;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffdfdfd),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(pageTitle, style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: EdEvaluatorForm(pageTitle: pageTitle),
    );
  }
}
