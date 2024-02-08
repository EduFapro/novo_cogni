import 'package:equatable/equatable.dart';

import '../../../constants/enums/person_enums/person_enums.dart';
import '../../data/data_constants/evaluator_constants.dart';

class EvaluatorEntity extends Equatable {
  final int? evaluatorID;
  final String name;
  final String surname;
  final DateTime birthDate;
  final Sex sex;
  final String specialty;
  final String cpfOrNif;
  final String email;
  late String password;
  bool firstLogin;

  EvaluatorEntity({
    this.evaluatorID,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.sex,
    required this.specialty,
    required this.cpfOrNif,
    required this.email,
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
        email = map[EMAIL_EVALUATOR],
        password = map[PASSWORD_EVALUATOR],
        firstLogin = map[FIRST_LOGIN] == 1;

  Map<String, dynamic> toMap() {
    return {
      ID_EVALUATOR: evaluatorID,
      EVALUATOR_NAME: name,
      EVALUATOR_SURNAME: surname,
      BIRTH_DATE_EVALUATOR: birthDate.toIso8601String(),
      EVALUATOR_SEX: sex.toInt(),
      SPECIALTY_EVALUATOR: specialty,
      CPF_OR_NIF_EVALUATOR: cpfOrNif,
      EMAIL_EVALUATOR: email,
      PASSWORD_EVALUATOR: password,
      FIRST_LOGIN: firstLogin ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [evaluatorID, name, surname, birthDate, sex, specialty, cpfOrNif, email, firstLogin];

  @override
  String toString() {
    return 'EvaluatorEntity{'
        'ID: $evaluatorID, '
        'Name: $name $surname, '
        'Birth Date: ${birthDate.toIso8601String()}, '
        'Sex: ${sex.description}, '
        'Specialty: $specialty, '
        'CPF/NIF: $cpfOrNif, '
        'Email: $email, '
        'First Login: ${firstLogin ? "Yes" : "No"}'
        '}';
  }

}


