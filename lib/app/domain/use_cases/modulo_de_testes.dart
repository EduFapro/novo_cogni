import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import '../entities/tarefa_entity.dart';

int moduloID = 999;
TarefaEntity tarefaOuvir = TarefaEntity(nome: "Ouvir o Áudio", moduloID: moduloID,);
TarefaEntity apresentar = TarefaEntity(nome: "Contar-nos o seu nome", moduloID: moduloID,);
ModuloEntity moduloIntroducao = ModuloEntity(tarefas: [tarefaOuvir, apresentar], date: DateTime.now(), moduloID: moduloID);