import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/modules/admin_registration/admin_registration_controller.dart';

import '../../../constants/translation/ui_strings.dart';
import '../../../mixins/ValidationMixin.dart';
import '../../../routes.dart';

class EdAdminForm extends GetView<AdminRegistrationController>
    with ValidationMixin {
  final pageTitle;
  final GlobalKey<FormState> formKey;

  EdAdminForm({Key? key, required this.pageTitle, required this.formKey})
      : super(key: key);

  final controller = Get.find<AdminRegistrationController>();

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
              pageTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.fullNameController,
                            focusNode: controller.fullNameFocusNode,
                            validator: validateFullName,
                            decoration: InputDecoration(
                              labelText: UiStrings.fullName,
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth * 2),
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
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
                            onTap: () => controller.selectDate(context),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira a data de nascimento';
                              } else {
                                final date = DateFormat('dd/MM/yyyy').parseLoose(value);
                                final currentDate = DateTime.now();

                                if (date.isAfter(currentDate)) {
                                  return 'Data de nascimento inválida';
                                }

                                final eighteenYearsAgo = currentDate
                                    .subtract(Duration(days: 18 * 365));

                                if (date.isAfter(eighteenYearsAgo)) {
                                  return 'Deve ter ao menos 18 anos';
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
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Insira a especialidade";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: spacingWidth * 2),
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.usernameController,
                            decoration:
                                InputDecoration(labelText: UiStrings.username),
                            readOnly: true,
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
                            controller: controller.cpfOrNifController,
                            decoration: InputDecoration(
                              labelText: UiStrings.cpf,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Insira o CPF";
                              } else if (!isValidCPF(value)) {
                                return 'CPF Inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: spacingWidth * 2),
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.confirmCpfOrNifController,
                            decoration: InputDecoration(
                              labelText: "Confirmar CPF",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirme o CPF";
                              } else if (value !=
                                  controller.cpfOrNifController.text) {
                                return 'CPF não confere';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.orange[900]!,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ATENÇÃO',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'O CPF INSERIDO SERÁ A SENHA DO USUÁRIO',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.bottomCenter,
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
                              print("hahah - 1");
                              if (formKey.currentState!.validate()) {
                                print("hahah - 2");
                                if (controller.isUsernameValid.isTrue) {
                                  bool success =
                                      await controller.createEvaluator();

                                  if (success) {
                                    Get.toNamed(AppRoutes.login);
                                  } else {
                                    print(
                                        'Failed to create or update evaluator');
                                  }
                                } else {
                                  print('Username is invalid');
                                }
                              } else {
                                print('Form validation failed');
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
