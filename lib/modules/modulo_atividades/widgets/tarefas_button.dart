import 'package:flutter/material.dart';

class TarefasButton extends StatelessWidget {
  final VoidCallback onPressed;
  const TarefasButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        height: 50,
        child: Card(
          child: Text('Iniciar'),
        ),
      ),
    );
  }
}
