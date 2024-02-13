import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import 'package:novo_cogni/modules/evaluation/evaluation_controller.dart';

class ModuleButton extends GetView<EvaluationController> {
  final VoidCallback onPressed;
  const ModuleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        height: 50,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          child: Center(child: Text(UiStrings.start_task_button)),
        ),
      ),
    );
  }
}
