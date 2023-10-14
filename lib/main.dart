import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'core/routes/routes.dart';

void main() async {
  // Ensure that Flutter binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite for FFI.
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Load the .env file for environment variables.
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login,
      getPages: routes,
    );
  }
}
