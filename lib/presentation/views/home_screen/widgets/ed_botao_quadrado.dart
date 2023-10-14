import 'package:flutter/material.dart';

class EdBotaoQuadrado extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color backgroundColor;

  const EdBotaoQuadrado({
    Key? key,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.0,  // You can adjust the size as needed
        height: 60.0, // Keeping it square
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0), // Rounded edges
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}