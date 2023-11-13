import 'package:flutter/material.dart';

class EdMainLateralButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;

  const EdMainLateralButton({
    Key? key,
    required this.icon,
    required this.text, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    );
  }
}