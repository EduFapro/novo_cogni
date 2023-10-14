import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<bool> logAdmin(String email, String password) async {
  final envFile = await dotenv.load(fileName: ".env");
  final storedEmail = dotenv.env['EMAIL_ADMIN'];
  final secretKey = dotenv.env['SECRET_KEY'];

  // Hash the entered password
  var bytes = utf8.encode(password);
  var hashedEnteredPassword = sha256.convert(bytes).toString();

  // Hash the stored secret key (this mimics hashing the actual password for comparison)
  var secretBytes = utf8.encode(secretKey!);
  var hashedStoredPassword = sha256.convert(secretBytes).toString();

  if (email == storedEmail && hashedEnteredPassword == hashedStoredPassword) {
    return true;
  } else {
    // This is where you'd handle the invalid login
    Get.snackbar("Login Error", "Invalid email or password", // Using GetX's snackbar for feedback
        backgroundColor: Colors.red,
        colorText: Colors.white);
    return false;
  }
}
