import 'package:equatable/equatable.dart';
import '../../../constants/enums/person_enums.dart';
import '../../data/data_constants/participant_constants.dart';

class ParticipantEntity extends Equatable {
  final int? participantID;
  final String name;
  final String surname;
  final DateTime birthDate;
  final Sex sex;
  final EducationLevel educationLevel;

  ParticipantEntity({
    this.participantID,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.sex,
    required this.educationLevel,
  });

  ParticipantEntity.fromMap(Map<String, dynamic> map) :
        participantID = map[ID_PARTICIPANT] as int?,
        name = map[PARTICIPANT_NAME] ?? '',
        surname = map[PARTICIPANT_SURNAME] ?? '',
        birthDate = (map[BIRTH_DATE_PARTICIPANT] != null) ? DateTime.parse(map[BIRTH_DATE_PARTICIPANT]) : DateTime.now(),
        sex = (map[PARTICIPANT_SEX] == 'Male') ? Sex.male : Sex.female,
        educationLevel = (map[PARTICIPANT_EDUCATION_LEVEL] != null) ? EducationLevel.values.firstWhere((e) => e.toString().split('.').last == map[PARTICIPANT_EDUCATION_LEVEL]) : EducationLevel.other;

  Map<String, Object?> toMap() {
    return {
      if (participantID != null) ID_PARTICIPANT: participantID,
      PARTICIPANT_NAME: name,
      PARTICIPANT_SURNAME: surname,
      BIRTH_DATE_PARTICIPANT: birthDate.toIso8601String(),
      PARTICIPANT_SEX: sex == Sex.male ? 'Male' : 'Female',
      PARTICIPANT_EDUCATION_LEVEL: educationLevel.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return "Participant Name: $name $surname";
  }

  @override
  List<Object?> get props => [participantID];
}
