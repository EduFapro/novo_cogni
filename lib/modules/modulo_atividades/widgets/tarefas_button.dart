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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0), // Rounded corners for the card
            side: BorderSide(
              color: Colors.blue, // Border color
              width: 2.0, // Border width
            ),
          ),
          child: Center(child: Text('Iniciar')),
        ),
      ),
    );
  }
}
