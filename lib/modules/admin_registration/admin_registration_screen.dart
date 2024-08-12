import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/translation/ui_strings.dart';
import 'admin_registration_controller.dart';
import 'widgets/ed_admin_form.dart';

class AdminRegistrationScreen extends GetView<AdminRegistrationController> {
  const AdminRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageTitle = UiStrings.adminRegistration;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffdfdfd),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(pageTitle, style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: EdAdminForm(
        pageTitle: pageTitle,
        formKey: GlobalKey<FormState>(),
      ),
    );
  }
}
