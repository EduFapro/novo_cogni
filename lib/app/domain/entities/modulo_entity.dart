import 'dart:convert';
import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';
import '../../data/data_constants/modulo_constants.dart';
import '../../enums/modulo_enums.dart';

class ModuloEntity {
  int? moduloID;

  int? score;
  Status status;
  List<TarefaEntity> tarefas;

  ModuloEntity({
    this.moduloID,
    this.score,
    this.status = Status.a_iniciar,
    this.tarefas = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      ID_MODULO: moduloID,
      PONTUACAO_MODULO: score,
      STATUS: status.description,
      TAREFAS: jsonEncode(tarefas.map((tarefa) => tarefa.toMap()).toList()),
    };
  }

  static ModuloEntity fromMap(Map<String, dynamic> map) {
    return ModuloEntity(
      moduloID: map[ID_MODULO] as int?,
      score: map[PONTUACAO_MODULO] as int?,
      status: Status.values.firstWhere((e) => e.description == map[STATUS], orElse: () => Status.a_iniciar),
      tarefas: map[TAREFAS] != null
          ? List<TarefaEntity>.from(jsonDecode(map[TAREFAS]).map((tarefaMap) => TarefaEntity.fromMap(tarefaMap)))
          : [],
    );
  }
}
