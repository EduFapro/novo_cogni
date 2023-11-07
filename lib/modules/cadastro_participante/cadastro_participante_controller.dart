import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';
import 'package:novo_cogni/app/domain/repositories/tarefa_repository.dart';
import '../../app/domain/entities/avaliacao_entity.dart';
import '../../app/domain/entities/avaliacao_modulo_entity.dart';
import '../../app/domain/entities/modulo_entity.dart';
import '../../app/domain/entities/participante_entity.dart';
import '../../app/domain/repositories/avaliacao_modulo_repository.dart';
import '../../app/domain/repositories/avaliacao_repository.dart';
import '../../app/domain/repositories/modulo_repository.dart';
import '../../app/domain/repositories/participante_repository.dart';
import '../../utils/enums/idioma_enums.dart';
import '../../utils/enums/modulo_enums.dart';
import '../../utils/enums/pessoa_enums.dart';
import '../../utils/enums/tarefa_enums.dart';

class CadastroParticipanteController extends GetxController {
  final ParticipanteRepository participanteRepository;
  final AvaliacaoRepository avaliacaoRepository;
  final ModuloRepository moduloRepository;
  final TarefaRepository tarefaRepository;
  final AvaliacaoModuloRepository avaliacaoModuloRepository;

  CadastroParticipanteController(
      {required this.participanteRepository,
      required this.avaliacaoRepository,
      required this.moduloRepository,
      required this.avaliacaoModuloRepository,
      required this.tarefaRepository});

  final nomeCompletoController = TextEditingController();
  final dataNascimentoController = TextEditingController();

  final selectedSexo = Rx<Sexo?>(null);
  final selectedEscolaridade = Rx<Escolaridade?>(null);
  final selectedDate = Rx<DateTime?>(null);
  final selectedLateralidade = Rx<Lateralidade?>(null);
  final selectedIdioma = Rx<Idioma?>(null);

  // Method to select a date using a date picker
  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dataNascimentoController.text = DateFormat.yMd().format(pickedDate);
    }
  }

  // Method to create a new participant
  // Method to create a new participant
  Future<int?> createParticipante(
      int avaliadorID, List<String> selectedModulos) async {
    try {
      // Assuming you have a ParticipanteEntity that takes necessary parameters
      // You would need to gather all the necessary data to create a new participant
      // For example, let's assume we need the name, date of birth, and other details
      String nomeCompleto = nomeCompletoController.text;
      DateTime? dataNascimento = selectedDate
          .value; // or parse from dataNascimentoController.text if necessary
      Sexo? sexo = selectedSexo.value;
      Escolaridade? escolaridade = selectedEscolaridade.value;
      Lateralidade? lateralidade = selectedLateralidade.value;
      Idioma? idioma = selectedIdioma.value;

      // Create the ParticipanteEntity
      ParticipanteEntity novoParticipante = ParticipanteEntity(
        nome: nomeCompleto,
        dataNascimento: dataNascimento!,
        sexo: sexo!,
        escolaridade: escolaridade!,
        sobrenome: 'aaa',
        // Include other fields as required
      );

      // Call the method on the repository to save the participant
      int? participanteId =
          await participanteRepository.createParticipante(novoParticipante);

      if (participanteId == null) {
        // Handle the case where the participant could not be saved
        throw Exception('Failed to create the participant');
      }

      // Return the ID of the newly created participant
      return participanteId;
    } catch (e) {
      // Handle any exceptions that occur during the creation
      // This could involve logging the error or rethrowing the exception
      print('An error occurred while creating the participant: $e');
      rethrow;
    }
  }

  // Method to create modules and tasks
  List<ModuloEntity> createModulosEntities(List<String> selectedActivities) {
    return selectedActivities.map((activity) {
      // Create a ModuloEntity for each activity
      return ModuloEntity(
        date: DateTime.now(),
        score: 0,
        status: StatusModulo.a_iniciar,
        tarefas: [
          TarefaEntity(
            nome: activity,
            status: StatusTarefa.a_realizar,
            // The moduloID will be set after the ModuloEntity is saved to the database
            moduloID: null,
          )
        ],
      );
    }).toList();
  }

// Method to save modules to the database
  Future<List<int>> saveModulos(List<ModuloEntity> modulos) async {
    List<int> moduloIds = [];
    for (var modulo in modulos) {
      // Save the ModuloEntity to the database
      int? moduloId = await moduloRepository.createModulo(modulo);
      if (moduloId != null) {
        // If the ModuloEntity is saved successfully, add its ID to the list
        moduloIds.add(moduloId);

        // Now that we have the moduloID, we can update the tarefas with this ID
        for (var tarefa in modulo.tarefas) {
          tarefa.moduloID = moduloId;
          // Here you would save the TarefaEntity to the database
          // For example: await tarefaRepository.createTarefa(tarefa);
        }
      } else {
        // Handle the case where the ModuloEntity could not be saved
        // This could involve throwing an exception or continuing to try to save other modules
        // For simplicity, we'll continue here
        continue;
      }
    }
    return moduloIds;
  }

  // Method to create and save tasks for modules
  Future<void> createAndSaveTarefasForModulos(
      List<ModuloEntity> modulos, List<String> selectedActivities) async {
    // Iterate over the modules and create tasks for each one
    for (int i = 0; i < modulos.length; i++) {
      ModuloEntity modulo = modulos[i];
      String activity = selectedActivities[i];
      // Create a new task
      TarefaEntity tarefa = TarefaEntity(
        nome: activity,
        status: StatusTarefa.a_realizar,
        moduloID: modulo.moduloID!,
      );
      // Save the task
      await saveTarefa(tarefa);
    }
  }

  // Method to link an evaluation to modules
  Future<void> linkAvaliacaoToModulos(
      int avaliacaoId, List<int> moduloIds) async {
    try {
      // Iterate over the list of modulo IDs and create a link for each one
      for (int moduloId in moduloIds) {
        // Create an AvaliacaoModuloEntity (or similar) to represent the link
        AvaliacaoModuloEntity avaliacaoModulo = AvaliacaoModuloEntity(
          avaliacaoId: avaliacaoId,
          moduloId: moduloId,
        );

        // Call the method on the repository to save the link
        await avaliacaoModuloRepository.createAvaliacaoModulo(avaliacaoModulo);
      }
    } catch (e) {
      // Handle any exceptions that occur during the linking
      // This could involve logging the error or rethrowing the exception
      print('An error occurred while linking the evaluation to modules: $e');
      rethrow;
    }
  }

  // Main method to orchestrate the creation of a participant and related entities
  Future<bool> createParticipanteAndModulos(
      int avaliadorID, List<String> selectedActivities) async {
    try {
      // Step 1: Create the participant and get the participantID
      int? participantID =
          await createParticipante(avaliadorID, selectedActivities);
      if (participantID == null) {
        throw Exception('Failed to create participant');
      }

      // Step 2: Create AvaliacaoEntity and get the evaluationID
      int? evaluationID = await createAvaliacao(participantID, avaliadorID);
      if (evaluationID == null) {
        throw Exception('Failed to create evaluation');
      }

      // Step 3: Create ModuloEntity objects for each selected activity
      List<ModuloEntity> modulos = createModulosEntities(selectedActivities);

      _initializeDefaultModulo(participantID);

      // Step 4: Save ModuloEntity objects and get their IDs
      List<int> moduloIds = await saveModulos(modulos);
      if (moduloIds.isEmpty) {
        throw Exception('Failed to save modules');
      }

      // Step 5: Link the Avaliacao to the Modulos
      await linkAvaliacaoToModulos(evaluationID, moduloIds);

      // If all steps were successful, return true
      return true;
    } catch (e) {
      // Log the error or handle it as needed
      print('An error occurred while creating participant and modules: $e');
      return false;
    }
  }

  // Method to create an evaluation
  // Method to create an evaluation
  Future<int?> createAvaliacao(int participanteID, int avaliadorID) async {
    try {
      // Create a new AvaliacaoEntity object
      AvaliacaoEntity novaAvaliacao = AvaliacaoEntity(
        avaliacaoID: null, // Assuming the ID is auto-generated by the database
        avaliadorID: avaliadorID,
        participanteID: participanteID,
        // Add any other fields that are required for the AvaliacaoEntity
      );

      // Call the method on the repository to save the evaluation
      int? avaliacaoId =
          await avaliacaoRepository.createAvaliacao(novaAvaliacao);

      if (avaliacaoId == null) {
        // Handle the case where the evaluation could not be saved
        throw Exception('Failed to create the evaluation');
      }

      // Return the ID of the newly created evaluation
      return avaliacaoId;
    } catch (e) {
      // Handle any exceptions that occur during the creation
      // This could involve logging the error or rethrowing the exception
      print('An error occurred while creating the evaluation: $e');
      rethrow;
    }
  }

  // Method to save a task to the database
  // Method to save a task to the database
  Future<void> saveTarefa(TarefaEntity tarefa) async {
    try {
      // Call the method on the repository to save the task
      int? tarefaId = await tarefaRepository.createTarefa(tarefa);

      if (tarefaId == null) {
        // Handle the case where the task could not be saved
        throw Exception('Failed to save the task');
      }

      // Optionally, update the tarefa object with the new ID
      tarefa.tarefaID = tarefaId;
    } catch (e) {
      // Handle any exceptions that occur during saving
      print('An error occurred while saving the task: $e');
      rethrow;
    }
  }

  Future<ModuloEntity> _initializeDefaultModulo(int participantID) async {
    // Create the ModuloEntity for the introduction module
    ModuloEntity moduloIntroducao = ModuloEntity(
      tarefas: [],
      date: DateTime.now(),
      moduloID: null, // This will be set after saving the module
    );

    // Save the ModuloEntity to the database and get the generated moduloID
    int? moduloID = await moduloRepository.createModulo(moduloIntroducao);
    if (moduloID == null) {
      throw Exception('Failed to create the introduction module');
    }

    // Create the TarefaEntity instances with the correct moduloID
    TarefaEntity tarefaOuvir = TarefaEntity(
      nome: "Ouvir o Áudio",
      moduloID: moduloID,
    );
    TarefaEntity apresentar = TarefaEntity(
      nome: "Contar-nos o seu nome",
      moduloID: moduloID,
    );

    // Save the TarefaEntity instances to the database
    await tarefaRepository.createTarefa(tarefaOuvir);
    await tarefaRepository.createTarefa(apresentar);

    // Add the tasks to the module's task list
    moduloIntroducao.tarefas.add(tarefaOuvir);
    moduloIntroducao.tarefas.add(apresentar);

    // Update the module with the tasks
    await moduloRepository.updateModulo(moduloIntroducao);

    // Return the updated module
    return moduloIntroducao;
  }


  // Method to print form data for debugging purposes
  void printFormData() {
    // Your logic to print form data goes here
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is removed from memory
    nomeCompletoController.dispose();
    dataNascimentoController.dispose();
    super.onClose();
  }
}
