import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EdInputText extends StatelessWidget {
  final String placeholder;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const EdInputText({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      textAlign: TextAlign.start,
      validator: validator,
      onSaved: onSaved,
      style: GoogleFonts.inter(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
    );
  }
}
