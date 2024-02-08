import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import '../../../constants/enums/person_enums/person_enums.dart';
import '../../home/home_controller.dart';
import '../../login/login_controller.dart';
import '../../widgets/ed_language_form_dropdown.dart';
import '../participant_registration_controller.dart';

class ParticipantForm extends GetView<ParticipantRegistrationController> {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    int? evaluatorId = loginController.currentEvaluatorId.value;
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
              UiStrings.identificationData,
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
                              filled: true,
                              fillColor: Color(0xffededed),
                              border: InputBorder.none,
                              labelText: UiStrings.fullName,
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow1,
                          child: TextFormField(
                            controller: controller.birthDateController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: UiStrings.dateOfBirth,
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                controller.birthDateController.text = pickedDate
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                                controller.selectedDate.value =
                                    pickedDate;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        SizedBox(
                          width: fieldWidthRow2,
                          child: DropdownButtonFormField<Sex>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: UiStrings.sex,
                            ),
                            items: Sex.values.map((sex) {
                              return DropdownMenuItem<Sex>(
                                value: sex,

                                child: Text(sex == Sex.male ? Sex.male.description : Sex.female.description),
                              );
                            }).toList(),
                            onChanged: (Sex? value) {
                              controller.selectedSex.value = value;
                            },
                            value: controller.selectedSex.value,
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: DropdownButtonFormField<EducationLevel>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: UiStrings.educationLevel,
                            ),
                            items: EducationLevel.values.map((educationLevel) {
                              return DropdownMenuItem<EducationLevel>(
                                value: educationLevel,
                                child: Text(educationLevel.description),
                              );
                            }).toList(),
                            onChanged: (EducationLevel? value) {
                              controller.selectedEducationLevel.value = value;
                            },
                            value: controller.selectedEducationLevel.value,
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: DropdownButtonFormField<Handedness>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: UiStrings.laterality,
                            ),
                            items: Handedness.values.map((laterality) {
                              return DropdownMenuItem<Handedness>(
                                value: laterality,
                                child: Text(laterality.description),
                              );
                            }).toList(),
                            onChanged: (Handedness? value) {
                              controller.selectedLaterality.value = value;
                            },
                            value: controller.selectedLaterality.value,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              UiStrings.modules,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow1,
                          child: EdLanguageFormDropdown(),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    Padding(
                      padding: EdgeInsets.only(left: spacingWidth),
                      child: SizedBox(
                        height: 300,
                        width: 200,
                        child: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                UiStrings.selectedModules,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ...controller.itemsMap.keys.map((String key) {
                                return CheckboxListTile(
                                  title: Text(key),
                                  value: controller.itemsMap[key],
                                  onChanged: (bool? value) {
                                    // Assign the value directly to the controller's itemsMap
                                    if (value != null) {
                                      controller.itemsMap[key] = value;
                                    }
                                  },
                                );
                              }).toList(),
                            ],
                          );
                        }),
                      ),
                    ),
                  ]),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xff000000), width: 2.0),
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(UiStrings.cancel,
                        style: TextStyle(color: Color(0xff000000))),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () async {
                      controller.printFormData();

                      // Capture selected activities from the form
                      List<String> selectedModules = controller.itemsMap.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList();

                      // Call the method to handle participant and modules creation
                      bool success =
                          await controller.createParticipantAndModules(
                              evaluatorId, selectedModules);

                      if (success) {
                        var homeCtrller = Get.find<HomeController>();
                        homeCtrller.refreshData();
                        Get.back();
                      } else {
                        // Handle the case where the operation failed
                        // For example, show an error message to the user
                        Get.snackbar(
                          'Error', // Title
                          'Failed to create participant and modules.',
                          // Message
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Color(0xff17120f),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(UiStrings.register),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
