import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novo_cogni/modules/home/home_controller.dart';

class EdInputText extends GetView<HomeController> {
  final String placeholder;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController? textController;
  final Widget? suffixIcon;

  const EdInputText({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.textController,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      style: GoogleFonts.inter(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class EdSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  EdSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        hintText: "Search...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            onSearch(controller.text); // Perform the search operation
          },
        ),
      ),
      onFieldSubmitted: (value) {
        onSearch(value); // Also perform search when enter is pressed
      },
    );
  }
}
