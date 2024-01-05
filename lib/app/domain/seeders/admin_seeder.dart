import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../constants/enums/person_enums.dart';
import '../../data/data_constants/evaluator_constants.dart';
import '../entities/evaluator_entity.dart';

class Config {
  static String get adminName => dotenv.env['ADMIN_NAME'] ?? '';

  static String get adminSurname => dotenv.env['ADMIN_SURNAME'] ?? '';

  static String get adminSpecialty => dotenv.env['ADMIN_SPECIALTY'] ?? '';

  static String get adminCpfOrNif => dotenv.env['ADMIN_CPF_OR_NIF'] ?? '';

  static String get adminEmail => dotenv.env['ADMIN_EMAIL'] ?? '';

  static String get secretKey => dotenv.env['SECRET_KEY'] ?? '';

  static EvaluatorEntity get admin {
    return EvaluatorEntity(
      name: adminName,
      surname: adminSurname,
      birthDate: _adminBirthDate,
      sex: _adminSex,
      specialty: adminSpecialty,
      cpfOrNif: adminCpfOrNif,
      email: adminEmail,
      password: secretKey,
      firstLogin: false,
    );
  }


  static Sex get _adminSex {
    final sexString = dotenv.env['ADMIN_SEX']?.toLowerCase() ?? '';
    switch (sexString) {
      case 'male':
        return Sex.male;
      case 'female':
        return Sex.female;
      default:
        return Sex.male;
    }
  }

  static DateTime get _adminBirthDate {
    final birthDateString = dotenv.env['ADMIN_BIRTHDATE'];
    if (birthDateString != null && birthDateString.isNotEmpty) {
      try {
        return DateTime.parse(birthDateString);
      } catch (e) {
        print("Error parsing birth date: $e");
        // Provide a fallback date or handle accordingly
        return DateTime.now(); // Example fallback
      }
    } else {
      // Handle the case where the date string is null or empty
      return DateTime.now(); // Example fallback
    }
  }


  static Map<String, dynamic> get adminMap {
    var map = admin.toMap();
    map[IS_ADMIN] = 1;
    return map;
  }


}
