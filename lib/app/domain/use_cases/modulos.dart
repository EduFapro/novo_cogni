import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import '../entities/tarefa_entity.dart';

int moduloTesteID = 999;
TarefaEntity tarefaOuvir = TarefaEntity(nome: "Ouvir o Áudio", moduloID: moduloTesteID,);
TarefaEntity apresentar = TarefaEntity(nome: "Contar-nos o seu nome", moduloID: moduloTesteID,);
ModuloEntity moduloTeste = ModuloEntity(tarefas: [tarefaOuvir, apresentar],  moduloID: moduloTesteID);

int moduloWay2AgeID = 444;
TarefaEntity contarHistoria = TarefaEntity(nome: "Conte uma História", moduloID: moduloWay2AgeID,);
TarefaEntity contarAte10 = TarefaEntity(nome: "Conte Até 10!", moduloID: moduloWay2AgeID,);
ModuloEntity moduloWay2Age = ModuloEntity(tarefas: [tarefaOuvir, apresentar],  moduloID: moduloWay2AgeID);

List<ModuloEntity> lista_modulos = [moduloTeste, moduloWay2Age ];