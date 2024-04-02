import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';

import '../../../mixins/ValidationMixin.dart';
import '../evaluator_registration_controller.dart';

class EdEvaluatorForm extends GetView<EvaluatorRegistrationController>
    with ValidationMixin {
  EdEvaluatorForm({Key? key}) : super(key: key);

  final controller = Get.find<EvaluatorRegistrationController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth * 0.8;
    const double spacingWidth = 16.0;
    double adjustedFormWidth = formWidth - spacingWidth;
    double adjustedFormWidthRow2 = formWidth - 2 * spacingWidth;

    double fieldWidthRow1 = adjustedFormWidth / 2;
    double fieldWidthRow2 = adjustedFormWidthRow2 / 3;
    var fieldContainerHeight = 80.0;
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              UiStrings.evaluatorRegistration,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow1,
                          child: TextFormField(
                            controller: controller.fullNameController,
                            focusNode: controller.fullNameFocusNode,
                            validator: validateFullName,
                            decoration: InputDecoration(
                              labelText: UiStrings.fullName,
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow1,
                          child: TextFormField(
                            controller: controller.dateOfBirthController,
                            decoration: InputDecoration(
                              labelText: UiStrings.dateOfBirth,
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                            ),
                            readOnly: !(controller.isEditMode.value),
                            onTap: () => controller.selectDate(context),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Date of birth is required';
                              } else {
                                // Assuming you are using the intl package and the date format 'yMd'
                                final date = DateFormat.yMd().parseLoose(value);
                                final currentDate = DateTime.now();

                                if (date.isAfter(currentDate)) {
                                  return 'Invalid date of birth';
                                }

                                // Here, we assume the age requirement is 18 years
                                final eighteenYearsAgo = currentDate
                                    .subtract(Duration(days: 18 * 365));

                                if (date.isAfter(eighteenYearsAgo)) {
                                  return 'Must be at least 18 years old';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.specialtyController,
                            decoration: InputDecoration(
                              labelText: UiStrings.specialty,
                              // Add your other decoration properties
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Specialty is required'; // Your validation message
                              }
                              // Add any other specialty validation logic here
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.cpfOrNifController,
                            decoration: InputDecoration(
                              labelText: UiStrings.cpf,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'CPF is required'; // CPF cannot be empty
                              } else if (!isValidCPF(value)) {
                                return 'Invalid CPF'; // Use your validation logic for a CPF
                              }
                              return null; // Return null if the CPF is valid
                            },
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
                          child: Obx(
                            () => TextFormField(
                              // Always show the TextFormField
                              controller: TextEditingController(
                                text: controller.isEditMode.value
                                    ? controller.username.value
                                    : controller.isUsernameValid.isTrue
                                        ? controller.username
                                            .value // If valid, show the username
                                        : '', // If not valid, show an empty string
                              ),
                              decoration: InputDecoration(
                                  labelText: UiStrings.username),
                              readOnly: !(controller.isEditMode.value),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    if (controller.isEditMode.isTrue)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row( // Use a Row to align the fields horizontally
                            children: [
                              SizedBox(
                                height: fieldContainerHeight,
                                width: fieldWidthRow2, // Use the same width as the second row fields
                                child: TextFormField(
                                  controller: controller.newPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(labelText: "Nova Senha"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'New password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: spacingWidth), // Consistent spacing
                              // ... Include more widgets here if needed
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row( // Again, use a Row to align the fields horizontally
                            children: [
                              SizedBox(
                                height: fieldContainerHeight,
                                width: fieldWidthRow2, // Use the same width as the second row fields
                                child: TextFormField(
                                  controller: controller.confirmNewPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(labelText: "Confirme Senha"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirm password is required';
                                    }
                                    if (value != controller.newPasswordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: spacingWidth), // Consistent spacing
                              // ... Include more widgets here if needed
                            ],
                          ),
                          // ... (the rest of your code remains the same)
                        ],
                      ),
                    SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(UiStrings.cancel,
                                style: TextStyle(color: Color(0xff000000))),
                          ),
                          SizedBox(width: 20),
                          TextButton(
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                // Check if all fields are valid
                                if (controller.isUsernameValid.isTrue) {
                                  // Proceed if the username is valid
                                  if (await controller.createEvaluator()) {
                                    Get.back();
                                  } else {
                                    // Handle the error, for example by showing a Snackbar
                                  }
                                } else {
                                  // Handle the invalid username case
                                }
                              }
                            },
                            child: Text(UiStrings.register),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidCPF(String cpf) {
    String sanitizedCPF = cpf.replaceAll(RegExp(r'\D'), '');

    if (sanitizedCPF.length != 11) {
      return false;
    }

    return true;
  }
}
