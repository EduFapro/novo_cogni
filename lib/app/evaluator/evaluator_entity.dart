import 'package:equatable/equatable.dart';

import '../../../constants/enums/person_enums/person_enums.dart';
import 'evaluator_constants.dart';

class EvaluatorEntity extends Equatable {
  final int? evaluatorID;
  final String name;
  final String surname;
  final DateTime birthDate;
  final Sex sex;
  final String specialty;
  final String cpfOrNif;
  final String username;
  late String password;
  bool firstLogin;
  bool isAdmin = false;

  EvaluatorEntity({
    this.evaluatorID,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.sex,
    required this.specialty,
    required this.cpfOrNif,
    required this.username,
    this.password = '0000',
    this.firstLogin = false,
  });

  EvaluatorEntity.fromMap(Map<String, dynamic> map)
      : evaluatorID = map[ID_EVALUATOR],
        name = map[EVALUATOR_NAME],
        surname = map[EVALUATOR_SURNAME],
        birthDate = DateTime.parse(map[BIRTH_DATE_EVALUATOR]),
        sex = SexExtension.fromValue(map[EVALUATOR_SEX]),
        specialty = map[SPECIALTY_EVALUATOR],
        cpfOrNif = map[CPF_OR_NIF_EVALUATOR],
        username = map[USERNAME_EVALUATOR],
        password = map[PASSWORD_EVALUATOR],
        firstLogin = map[FIRST_LOGIN] == 1,
        isAdmin = map[IS_ADMIN] == 1;

  Map<String, dynamic> toMap() {
    return {
      ID_EVALUATOR: evaluatorID,
      EVALUATOR_NAME: name,
      EVALUATOR_SURNAME: surname,
      BIRTH_DATE_EVALUATOR: birthDate.toIso8601String(),
      EVALUATOR_SEX: sex.toInt(),
      SPECIALTY_EVALUATOR: specialty,
      CPF_OR_NIF_EVALUATOR: cpfOrNif,
      USERNAME_EVALUATOR: username,
      PASSWORD_EVALUATOR: password,
      FIRST_LOGIN: firstLogin ? 1 : 0,
      IS_ADMIN: isAdmin ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [
        evaluatorID,
        name,
        surname,
        birthDate,
        sex,
        specialty,
        cpfOrNif,
        username,
        firstLogin,
        isAdmin
      ];

  @override
  String toString() {
    return 'EvaluatorEntity{'
        'ID: $evaluatorID, '
        'Name: $name $surname, '
        'Birth Date: ${birthDate.toIso8601String()}, '
        'Sex: ${sex.description}, '
        'Specialty: $specialty, '
        'CPF/NIF: $cpfOrNif, '
        'Username: $username, '
        'First Login: ${firstLogin ? "Yes" : "No"}'
        'Is Admin: ${isAdmin ? "Yes" : "No"}'
        '}';
  }
}
