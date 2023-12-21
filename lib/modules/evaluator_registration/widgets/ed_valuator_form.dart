import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../evaluator_registration_controller.dart';

class EdEvaluatorForm extends GetView<EvaluatorRegistrationController>{
  EdEvaluatorForm({Key? key}) : super(key: key);

  final controller = Get.find<EvaluatorRegistrationController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth * 0.8;
    const double spacingWidth = 16.0;
    double adjustedFormWidth = formWidth - spacingWidth;
    double adjustedFormWidthRow2 = formWidth - 2 * spacingWidth;

    double fieldWidthRow1 = (adjustedFormWidth) / 2;
    double fieldWidthRow2 = adjustedFormWidthRow2 / 3;

    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Identification Details',
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
                    // Form fields and layout
                    Row(
                      // First row fields
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      // Second row fields
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      // Third row fields
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
                            // Button style
                            child: const Text("Cancel",
                                style: TextStyle(color: Color(0xff000000))),
                          ),
                          SizedBox(width: 20),
                          TextButton(
                            onPressed: () async {
                              // Submit logic
                            },
                            // Button style
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
