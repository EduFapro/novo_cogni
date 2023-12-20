import 'dart:convert';
import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';
import '../../data/data_constants/module_constants.dart';
import '../../enums/modulo_enums.dart';

class ModuloEntity {
  int? moduloID;
  String? titulo;
  List<TarefaEntity> tarefas;

  ModuloEntity({
    this.moduloID,
    this.titulo,
    this.tarefas = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      ID_MODULO: moduloID,
      TITULO: titulo,
      TAREFAS: jsonEncode(tarefas.map((tarefa) => tarefa.toMap()).toList()),
    };
  }

  static ModuloEntity fromMap(Map<String, dynamic> map) {
    return ModuloEntity(
      moduloID: map[ID_MODULO] as int?,
      tarefas: map[TAREFAS] != null
          ? List<TarefaEntity>.from(jsonDecode(map[TAREFAS]).map((tarefaMap) => TarefaEntity.fromMap(tarefaMap)))
          : [], titulo: map[TITULO],
    );
  }
}
