import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/translation/ui_strings.dart';
import 'evaluator_registration_controller.dart';
import 'widgets/ed_evaluator_form.dart';

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
