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

  EdAdminForm({Key? key, required this.pageTitle, required this.formKey}) : super(key: key);

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
                            onTap: () => controller.selectDate(context),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira a data de nascimento';
                              } else {
                                final date = DateFormat.yMd().parseLoose(value);
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
                                return "Insira o CPF";
                              } else if (!isValidCPF(value)) {
                                return 'CPF Inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          height: fieldContainerHeight,
                          width: fieldWidthRow2,
                          child: Obx(() => TextFormField(
                            controller: controller.usernameController,
                            decoration: InputDecoration(
                                labelText: UiStrings.username),
                            readOnly: !(controller.isEditMode.value),
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Obx(() => Row(
                      children: [
                        if (controller.isEditMode.isTrue)
                          SizedBox(
                            width: fieldWidthRow2,
                            child: SwitchListTile(
                              title: Text(UiStrings.modifyPassword),
                              value: controller.isPasswordChangeEnabled.value,
                              onChanged: (bool value) {
                                controller.isPasswordChangeEnabled.value = value;
                                if (!value) {
                                  controller.newPasswordController.clear();
                                  controller.confirmNewPasswordController.clear();
                                  formKey.currentState?.validate();
                                }
                              },
                            ),
                          ),
                        SizedBox(width: spacingWidth),
                      ],
                    )),
                    if (controller.isEditMode.isTrue)
                      Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: fieldContainerHeight,
                                width: fieldWidthRow2,
                                child: TextFormField(
                                  controller: controller.newPasswordController,
                                  obscureText: true,
                                  enabled: controller.isPasswordChangeEnabled.value,
                                  decoration: InputDecoration(
                                      labelText: "Nova Senha"),
                                  validator: (value) {
                                    if (controller.isPasswordChangeEnabled.value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Insira a nova senha';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: spacingWidth),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            children: [
                              SizedBox(
                                height: fieldContainerHeight,
                                width: fieldWidthRow2,
                                child: TextFormField(
                                  controller: controller.confirmNewPasswordController,
                                  obscureText: true,
                                  enabled: controller.isPasswordChangeEnabled.value,
                                  decoration: InputDecoration(
                                      labelText: "Confirme Senha"),
                                  validator: (value) {
                                    if (controller.isPasswordChangeEnabled.value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirme a nova senha';
                                      }
                                      if (value != controller.newPasswordController.text) {
                                        return 'Senhas diferentes';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: spacingWidth),
                            ],
                          ),
                        ],
                      )),
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
                              if (controller.isEditMode.isTrue &&
                                  !controller.isPasswordChangeEnabled.value) {
                                controller.newPasswordController.text = '';
                                controller.confirmNewPasswordController.text = '';
                              }

                              print("hahah - 1");
                              if (formKey.currentState!.validate()) {
                                print("hahah - 2");
                                if (controller.isUsernameValid.isTrue) {
                                  bool success;
                                  if (controller.isEditMode.isTrue) {
                                    success = await controller.updateEvaluator();
                                  } else {
                                    success = await controller.createEvaluator();
                                  }
                                  if (success) {

                                      Get.toNamed(AppRoutes.login);


                                  } else {
                                    print('Failed to create or update evaluator');
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
