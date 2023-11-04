import 'package:novo_cogni/app/data/data_constants/tarefa_constants.dart';

import '../../../utils/enums/tarefa_enums.dart';

class TarefaEntity {
  int? tarefaID;
  String nome;
  StatusTarefa status;

  TarefaEntity({
    this.tarefaID,
    required this.nome,
    this.status = StatusTarefa.a_realizar,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_TAREFA: tarefaID,
      NOME: nome,
      STATUS: status.toString(),
    };
  }

  static TarefaEntity fromMap(Map<String, dynamic> map) {
    return TarefaEntity(
      tarefaID: map[ID_TAREFA] as int?,
      nome: map[NOME] as String,
      status: StatusTarefa.values.firstWhere(
        (e) => e.toString() == map[STATUS],
        orElse: () => StatusTarefa.a_realizar,
      ),
    );
  }

  @override
  String toString() {
    return 'TarefaEntity{'
        'tarefa_id: $tarefaID, '
        'nome: "$nome", '
        'status: ${status.description}'
        '}';
  }
}
