import 'package:flutter/material.dart';

class EdMainLateralButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;
  final Color color;

  const EdMainLateralButton({
    Key? key,
    required this.icon,
    this.color = Colors.black,
    required this.text, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
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