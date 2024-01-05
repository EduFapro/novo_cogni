import 'package:equatable/equatable.dart';
import '../../../constants/enums/person_enums.dart';
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
    required this.password,
    required this.firstLogin});

  EvaluatorEntity.fromMap(Map<String, dynamic> map)
      : evaluatorID = map[ID_EVALUATOR] as int?,
        name = map[EVALUATOR_NAME] ?? '',
        surname = map[EVALUATOR_SURNAME] ?? '',
        birthDate = (map[BIRTH_DATE_EVALUATOR] != null)
            ? DateTime.parse(map[BIRTH_DATE_EVALUATOR])
            : DateTime.now(),
        sex = (map[EVALUATOR_SEX] == 'Male') ? Sex.male : Sex.female,
        specialty = map[SPECIALTY_EVALUATOR] ?? '',
        cpfOrNif = map[CPF_OR_NIF_EVALUATOR] ?? '',
        email = map[EMAIL_EVALUATOR] ?? '',
        password = map[PASSWORD_EVALUATOR] ?? '0000',
        firstLogin = map[FIRST_LOGIN] == 0 ? false : true;

  Map<String, Object?> toMap() {
    return {
      ID_EVALUATOR: evaluatorID,
      EVALUATOR_NAME: name,
      EVALUATOR_SURNAME: surname,
      BIRTH_DATE_EVALUATOR: birthDate.toIso8601String(),
      EVALUATOR_SEX: sex == Sex.male ? 'Male' : 'Female',
      SPECIALTY_EVALUATOR: specialty,
      CPF_OR_NIF_EVALUATOR: cpfOrNif,
      EMAIL_EVALUATOR: email,
      PASSWORD_EVALUATOR: password,
      FIRST_LOGIN: firstLogin ? 1 : 0
    };
  }

  @override
  String toString() {
    return "Evaluator Name: $name $surname";
  }

  @override
  List<Object?> get props => [evaluatorID];
}
