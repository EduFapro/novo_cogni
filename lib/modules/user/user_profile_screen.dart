import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:novo_cogni/modules/user/user_profile_screen_controller.dart';

class UserProfileScreen extends GetView<UserProfileScreenController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = screenHeight * 0.85;

    return Scaffold(
      appBar: AppBar(
        title: Text("User HOHOHO"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            Text("AVALIADOR"),
            Text(controller.userAvaliador.value.toString()),
            Text("Avaliações:"),
            Text(controller.evaluations.toString()),
            Text("Instancias de módulo:"),
            Text(controller.modules.toString())
          ],
        ),
      ),
    );
  }
}
