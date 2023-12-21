import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/participant_registration/participant_registration_controller.dart';

import '../participant_registration/widgets/participant_form.dart';

class ParticipantRegistrationScreen extends GetView<ParticipantRegistrationController> {
  const ParticipantRegistrationScreen({Key? key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ParticipantRegistrationController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xfffdfdfd),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Participant Registration",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: ParticipantForm(controller: controller),
        ),
      ),
    );
  }
}
