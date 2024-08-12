import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/database_helper.dart';
import '../../constants/route_arguments.dart';
import '../../routes.dart';

class InitialRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: DatabaseHelper().isAdminConfigured(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          bool isAdminConfigured = snapshot.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (isAdminConfigured) {
              Get.offNamed(AppRoutes.login);
            } else {
              Get.offNamed(
                AppRoutes.adminRegistration,
              );
            }
          });
          return Container();
        } else {
          return Center(child: Text('Unknown state'));
        }
      },
    );
  }
}

