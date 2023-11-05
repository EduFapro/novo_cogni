import 'dart:convert';

import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';

import '../../../utils/enums/modulo_enums.dart';
import '../../data/data_constants/modulo_constants.dart';

class ModuloEntity {
  int? moduloID;
  DateTime? date;
  int? score;
  StatusModulo status;
  List<TarefaEntity> tarefas;

  ModuloEntity({
    this.moduloID,
    this.date,
    this.score,
    this.status = StatusModulo.a_iniciar,
    required this.tarefas,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_MODULO: moduloID,
      DATA_MODULO: date?.toIso8601String(),
      PONTUACAO_MODULO: score,
      STATUS: status.description,
      TAREFAS: jsonEncode(tarefas.map((tarefa) => tarefa.toMap()).toList()),
    };
  }

  static ModuloEntity fromMap(Map<String, dynamic> map) {
    return ModuloEntity(
      moduloID: map[ID_MODULO] as int?,
      date: map[DATA_MODULO] != null ? DateTime.parse(map[DATA_MODULO] as String) : null,
      score: map[PONTUACAO_MODULO] as int?,
      status: StatusModulo.values.firstWhere((e) => e.description == map[STATUS], orElse: () => StatusModulo.a_iniciar),
      tarefas: map[TAREFAS] != null
          ? List<TarefaEntity>.from(jsonDecode(map[TAREFAS]).map((tarefaMap) => TarefaEntity.fromMap(tarefaMap)))
          : [],

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
