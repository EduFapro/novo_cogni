import 'package:flutter/material.dart';
import 'package:novo_cogni/constants/enums/module_enums.dart';

class ModuleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final ModuleStatus moduleStatus;

  const ModuleButton({
    Key? key,
    this.onPressed,
    required this.moduleStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() {
      switch (moduleStatus) {
        case ModuleStatus.pending:
          return Colors.white;
        case ModuleStatus.in_progress:
          return Colors.orange;
        case ModuleStatus.completed:
          return Colors.green;
        default:
          return Colors.white;
      }
    }

    Color getBorderColor() {
      switch (moduleStatus) {
        case ModuleStatus.pending:
          return Colors.blue;
        case ModuleStatus.in_progress:
          return Colors.orange;
        case ModuleStatus.completed:
          return Colors.grey;
        default:
          return Colors.blue;
      }
    }

    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        height: 50,
        child: Card(
          color: getBackgroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: getBorderColor(),
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              moduleStatus.description,
              style: TextStyle(
                color: moduleStatus == ModuleStatus.completed
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
