import 'package:novo_cogni/app/data/data_constants/tarefa_constants.dart';

import '../../enums/tarefa_enums.dart';

class TarefaEntity {
  int? tarefaID;
  int? moduloID;
  String nome;

  TarefaEntity(
      {this.tarefaID,
      required this.nome,
      this.moduloID});

  Map<String, dynamic> toMap() {
    return {
      ID_TAREFA: tarefaID,
      NOME: nome,
      MODULO_ID: moduloID,
    };
  }

  static TarefaEntity fromMap(Map<String, dynamic> map) {
    return TarefaEntity(
      tarefaID: map[ID_TAREFA] as int?,
      nome: map[NOME] as String,
      moduloID: map[MODULO_ID],
    );
  }

  @override
  String toString() {
    return 'TarefaEntity{'
        'tarefa_id: $tarefaID, '
        'nome: "$nome", '
        '}';
  }
}
