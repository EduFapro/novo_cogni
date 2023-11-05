import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import '../entities/tarefa_entity.dart';

TarefaEntity tarefaOuvir = TarefaEntity(nome: "Ouvir o Áudio",);
TarefaEntity apresentar = TarefaEntity(nome: "Contar-nos o seu nome",);
ModuloEntity moduloIntroducao = ModuloEntity(tarefas: [tarefaOuvir, apresentar], date: DateTime.now());