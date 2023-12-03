import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import '../entities/tarefa_entity.dart';

int moduloTesteID = 1;
TarefaEntity tarefaOuvir = TarefaEntity(nome: "Ouvir o Áudio", moduloID: moduloTesteID,);
TarefaEntity apresentar = TarefaEntity(nome: "Contar-nos o seu nome", moduloID: moduloTesteID,);
ModuloEntity moduloTeste = ModuloEntity(tarefas: [tarefaOuvir, apresentar],  moduloID: moduloTesteID, titulo: 'Testes');

int moduloWay2AgeID = 2;
TarefaEntity contarHistoria = TarefaEntity(nome: "Conte uma História", moduloID: moduloWay2AgeID,);
TarefaEntity contarAte10 = TarefaEntity(nome: "Conte Até 10!", moduloID: moduloWay2AgeID,);
ModuloEntity moduloWay2Age = ModuloEntity(tarefas: [tarefaOuvir, apresentar],  moduloID: moduloWay2AgeID, titulo: 'Way2Age');

List<ModuloEntity> lista_modulos = [moduloTeste, moduloWay2Age ];

List<TarefaEntity> lista_tarefas = [tarefaOuvir, apresentar, contarHistoria, contarAte10];