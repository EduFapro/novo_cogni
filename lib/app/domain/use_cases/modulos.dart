import 'package:novo_cogni/app/domain/entities/modulo_entity.dart';
import '../entities/tarefa_entity.dart';

int moduloTesteID = 1;
TarefaEntity tarefaOuvir = TarefaEntity(nome: nomes_tarefas[0], moduloID: moduloTesteID,);
TarefaEntity apresentar = TarefaEntity(nome: nomes_tarefas[1], moduloID: moduloTesteID,);
ModuloEntity moduloTeste = ModuloEntity(tarefas: [tarefaOuvir, apresentar],  moduloID: moduloTesteID, titulo: titulos_modulos[0]);

int moduloWay2AgeID = 2;
TarefaEntity contarHistoria = TarefaEntity(nome: nomes_tarefas[2], moduloID: moduloWay2AgeID,);
TarefaEntity contarAte10 = TarefaEntity(nome: nomes_tarefas[3], moduloID: moduloWay2AgeID,);
ModuloEntity moduloWay2Age = ModuloEntity(tarefas: [tarefaOuvir, apresentar],  moduloID: moduloWay2AgeID, titulo: titulos_modulos[1]);

List<ModuloEntity> lista_modulos = [moduloTeste, moduloWay2Age ];

List<TarefaEntity> lista_tarefas = [tarefaOuvir, apresentar, contarHistoria, contarAte10];

List<String> titulos_modulos = ['Testes', 'Way2Age'];
List<String> nomes_tarefas = ["Ouvir o Áudio", "Contar-nos o seu nome", "Conte uma História", "Conte Até 10!"];