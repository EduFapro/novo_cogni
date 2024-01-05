import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/enums/person_enums.dart';
import '../evaluator_registration_controller.dart';

class EdEvaluatorForm extends GetView<EvaluatorRegistrationController> {
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

    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Evaluator Registration',
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
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow1,
                          child: TextFormField(
                            controller: controller.dateOfBirthController,
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
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
                              labelText: 'Specialty',
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.cpfOrNifController,
                            decoration: InputDecoration(
                              labelText: 'CPF/NIF',
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
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
                          labelText: 'Sex',
                        ),
                        items: Sex.values.map((Sex sex) {
                          return DropdownMenuItem<Sex>(
                            value: sex,
                            child: Text(sex == Sex.male ? 'Male' : 'Female'),
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
                            child: const Text("Cancel",
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
                            child: const Text("Register"),
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
}
