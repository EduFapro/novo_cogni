import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/evaluator_registration/widgets/ed_valuator_form.dart';
import 'evaluator_registration_controller.dart';

class EvaluatorRegistrationScreen extends GetView<EvaluatorRegistrationController> {
  const EvaluatorRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffdfdfd),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Evaluator Registration", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: EdEvaluatorForm(),
    );
  }
}
