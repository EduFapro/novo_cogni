import '../../../utils/enums/modulo_enums.dart';
import '../../data/data_constants/modulo_constants.dart';

class ModuloEntity {
  int? moduloID;
  DateTime? date;
  int? score;
  int? evaluationID;
  Status status;
  List<String> tarefas;

  ModuloEntity({
    this.moduloID,
    this.date,
    this.score,
    this.evaluationID,
    this.status = Status.a_iniciar,
    required this.tarefas,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_MODULO: moduloID,
      DATA_MODULO: date?.toIso8601String(),
      PONTUACAO_MODULO: score,
      STATUS: status.description,
      ID_AVALIACAO_FK: evaluationID,
      TAREFAS: tarefas.join(','), // Convert list to a comma-separated string
    };
  }

  static ModuloEntity fromMap(Map<String, dynamic> map) {
    return ModuloEntity(
      moduloID: map['modulo_id'] as int?,
      date: map['data_modulo'] != null ? DateTime.parse(map['data_modulo'] as String) : null,
      score: map['pontuacao'] as int?,
      evaluationID: map['avaliacao_id'] as int?,
      status: Status.values.firstWhere((e) => e.description == map['status'], orElse: () => Status.a_iniciar),
      tarefas: map[TAREFAS] != null ? (map[TAREFAS] as String).split(',') : [],

    );
  }
}

// // Helper function to convert string back to Status enum
// Status statusFromString(String statusStr) {
//   // Add your logic here to convert string to Status enum
//   // Example:
//   // if (statusStr == 'a_iniciar') return Status.a_iniciar;
//   // ... handle other cases ...
// }
