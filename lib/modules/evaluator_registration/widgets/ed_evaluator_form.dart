import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';

import '../../../constants/enums/person_enums/person_enums.dart';
import '../../../mixins/ValidationMixin.dart';
import '../evaluator_registration_controller.dart';

class EdEvaluatorForm extends GetView<EvaluatorRegistrationController>
    with ValidationMixin {
  EdEvaluatorForm({Key? key}) : super(key: key);

  final controller = Get.find<EvaluatorRegistrationController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double formWidth = screenWidth * 0.8;
    const double spacingWidth = 16.0;
    double adjustedFormWidth = formWidth - spacingWidth;
    double adjustedFormWidthRow2 = formWidth - 2 * spacingWidth;

    double fieldWidthRow1 = adjustedFormWidth / 2;
    double fieldWidthRow2 = adjustedFormWidthRow2 / 3;

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
                child: Column(
                  children: [
                Row(
                children: [
                SizedBox(
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
                width: fieldWidthRow1,
                child: TextFormField(
                  controller: controller.dateOfBirthController,
                  decoration: InputDecoration(
                    labelText: UiStrings.dateOfBirth,
                  ),
                  readOnly: true,
                  onTap: () => controller.selectDate(context),
                ),
              ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                  width: fieldWidthRow2,
                  child: TextFormField(
                    controller: controller.specialtyController,
                    decoration: InputDecoration(
                      labelText: UiStrings.specialty,
                    ),
                  ),
                ),
                SizedBox(width: spacingWidth),
                SizedBox(
                  width: fieldWidthRow2,
                  child: TextFormField(
                    controller: controller.cpfOrNifController,
                    decoration: InputDecoration(
                      labelText: UiStrings.cpfNif,
                    ),
                  ),
                ),
                SizedBox(width: spacingWidth),
                SizedBox(
                  width: fieldWidthRow2,
                  child: Obx(
                        () => TextFormField(
                      // Always show the TextFormField
                      controller: TextEditingController(
                        text: controller.isUsernameValid.isTrue
                            ? controller.username.value // If valid, show the username
                            : '', // If not valid, show an empty string
                      ),
                      decoration: InputDecoration(labelText: UiStrings.username),
                      readOnly: true, // You can set this to true if you don't want the user to edit this field
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: fieldWidthRow2,
              child: DropdownButtonFormField<Sex>(
                decoration: InputDecoration(
                  labelText: UiStrings.sex,
                ),
                items: Sex.values.map((Sex sex) {
                  return DropdownMenuItem<Sex>(
                    value: sex,
                    child: Text(sex == Sex.male
                        ? Sex.male.description
                        : Sex.female.description),
                  );
                }).toList(),
                onChanged: (Sex? value) {
                  controller.selectedSex.value = value;
                },
                value: controller.selectedSex.value,
              ),
            ),
            SizedBox(width: spacingWidth),
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
                      if (await controller.createEvaluator()) {
                        Get.back();
                      } else {
                        Get.snackbar(
                          'Error',
                          'Failed to create avaliador. Please check the details and try again.',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
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
    ),]
    ,
    )
    ,
    )
    ,
    );
  }
}
