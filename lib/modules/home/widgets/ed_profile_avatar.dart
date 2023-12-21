import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class EdProfileAvatar extends StatelessWidget {
  const EdProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();

    return Center(
      child: Obx(() {
        var user = homeController.user.value;
        if (user == null || homeController.isLoading.isTrue) {
          return CircularProgressIndicator(); // Or some placeholder
        }

        return Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 50.0,
              child: Image.asset('assets/profile-placeholder.png',
                  width: 300, height: 300),
            ),
            Text(
              user.name ?? 'Unknown Name',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              user.specialty ?? 'Unknown Specialty',
              style: TextStyle(color: Colors.white),
            ),
          ],
        );
      }),
    );
  }
}
