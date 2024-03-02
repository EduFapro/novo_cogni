import 'package:flutter/material.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';

class ModuleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isCompleted;

  const ModuleButton({Key? key, this.onPressed, required this.isCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        height: 50,
        child: Card(
          color: isCompleted ? Colors.green : Colors.white,
          // Change color based on completion status
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: isCompleted ? Colors.grey : Colors.blue,
              // Change border color based on status
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              isCompleted ? "COMPLETO" : UiStrings.start_task_button,
              style: TextStyle(
                  color: isCompleted ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
