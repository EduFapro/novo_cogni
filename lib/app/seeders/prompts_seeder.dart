import 'package:novo_cogni/app/seeders/tasks_seeder.dart';
import '../../../constants/assets_file_paths.dart';
import '../task_prompt/task_prompt_entity.dart';


var helloHowAreYouTaskPromptID = 1;
var whatsYourNameTaskPromptID = 2;
var whatsYourDOBTaskPromptID = 3;
var whatsYourEducationLevelTaskPromptID = 4;
var whatsYourProfessionTaskPromptID = 5;
var whoDoYouLiveWithTaskPromptID = 6;
var doYouExerciseFrequentlyTaskPromptID = 7;
var doYouReadFrequentlyTaskPromptID = 8;
var doYouPlayPuzzlesOrVideoGamesFrequentlyTaskPromptID = 9;
var doYouHaveAnyDiseasesTaskPromptID = 10;

final helloHowAreYouPrompt = TaskPromptEntity(
  promptID: helloHowAreYouTaskPromptID,
  taskID: helloHowAreYouTask.taskID!,
  filePath: AudioFilePaths.farei_algumas_perguntas,
  transcription: "Olá, tudo bem! Agora vou fazer algumas perguntas para conhecer você melhor.",
);

final whatsYourNamePrompt = TaskPromptEntity(
  promptID: whatsYourNameTaskPromptID,
  taskID: whatsYourNameTask.taskID!,
  filePath: AudioFilePaths.qual_o_seu_nome,
  transcription: "Qual o seu nome?",
);


final whatsYourDOBPrompt = TaskPromptEntity(
  promptID: whatsYourDOBTaskPromptID,
  taskID: whatsYourDOBTask.taskID!,
  filePath: AudioFilePaths.qual_a_sua_data_de_nascimento,
  transcription: "Qual a sua data de nascimento?",
);


final whatsYourEducationLevelPrompt = TaskPromptEntity(
  promptID: whatsYourEducationLevelTaskPromptID,
  taskID: whatsYourEducationLevelTask.taskID!,
  filePath: AudioFilePaths.qual_a_sua_escolaridade,
  transcription: "Qual a sua escolaridade? Me diga até quando você estudou:",
);


final whatsYourProfessionPrompt = TaskPromptEntity(
  promptID: whatsYourProfessionTaskPromptID,
  taskID: whatsYourProfessionTask.taskID!,
  filePath: AudioFilePaths.qual_era_a_sua_profissao,
  transcription: "Qual era a sua profissão?",
);


final whoDoYouLiveWithPrompt = TaskPromptEntity(
  promptID: whoDoYouLiveWithTaskPromptID,
  taskID: whoDoYouLiveWithTask.taskID!,
  filePath: AudioFilePaths.com_quem_voce_mora_atualmente,
  transcription: "Com quem você mora atualmente?",
);


final doYouExerciseFrequentlyPrompt = TaskPromptEntity(
  promptID: doYouExerciseFrequentlyTaskPromptID,
  taskID: doYouExerciseFrequentlyTask.taskID!,
  filePath: AudioFilePaths.voce_faz_alguma_atividade_fisica_com_frequencia,
  transcription: "Você faz alguma atividade física com frequência?",
);


final doYouReadFrequentlyPrompt = TaskPromptEntity(
  promptID: doYouReadFrequentlyTaskPromptID,
  taskID: doYouReadFrequentlyTask.taskID!,
  filePath: AudioFilePaths.voce_costuma_ler_com_frequencia,
  transcription: "Você costuma ler com frequência?",
);


final doYouPlayPuzzlesOrVideoGamesFrequentlyPrompt = TaskPromptEntity(
  promptID: doYouPlayPuzzlesOrVideoGamesFrequentlyTaskPromptID,
  taskID: doYouPlayPuzzlesOrVideoGamesFrequentlyTask.taskID!,
  filePath: AudioFilePaths.voce_costuma_jogar_palavras_cruzadas,
  transcription: "Você costuma jogar palavras-cruzadas, caça-palavras ou jogos eletrônicos com frequência?",
);


final doYouHaveAnyDiseasesPrompt = TaskPromptEntity(
  promptID: doYouHaveAnyDiseasesTaskPromptID,
  taskID: doYouHaveAnyDiseasesTask.taskID!,
  filePath: AudioFilePaths.algum_medico_ja_disse_que_voce_tem_alguma_doenca,
  transcription: "Algum médico já disse que você tem alguma doença? Me diga quais são essas doenças:",
);
final cincoPatinhosTaskPromptID = 9001;
final umPassaroTaskPromptID = 9002;
final nemTudoTaskPromptID = 99033;

final cincoPatinhosTaskPrompt = TaskPromptEntity(
    promptID: cincoPatinhosTaskPromptID,
    taskID: cincoPatinhosTask.taskID!,
    filePath: AudioFilePaths.cincoPatinhos);

final umPassaroTaskPrompt = TaskPromptEntity(
    promptID: umPassaroTaskPromptID,
    taskID: umPassaroTask.taskID!,
    filePath: AudioFilePaths.ehMelhorUmPassaro);

final nemTudoTaskPrompt = TaskPromptEntity(
    promptID: nemTudoTaskPromptID,
    taskID: nemTudoTask.taskID!,
    filePath: AudioFilePaths.nemTudoQueReluz);

List<TaskPromptEntity> tasksPromptsList = [
  helloHowAreYouPrompt,
  whatsYourNamePrompt,
  whatsYourDOBPrompt,
  whatsYourEducationLevelPrompt,
  whatsYourProfessionPrompt,
  whoDoYouLiveWithPrompt,
  doYouExerciseFrequentlyPrompt,
  doYouReadFrequentlyPrompt,
  doYouPlayPuzzlesOrVideoGamesFrequentlyPrompt,
  doYouHaveAnyDiseasesPrompt,
  cincoPatinhosTaskPrompt,
  umPassaroTaskPrompt,
  nemTudoTaskPrompt,
];


// final cincoPatinhosWithRecordingTaskPrompt = TaskPromptEntity(
//     promptID: cincoPatinhosWithRecordingTaskPromptID,
//     taskID: cincoPatinhosTaskWithRecording.taskID!,
//     filePath: AudioFilePaths.cincoPatinhos);
//
// final umPassaroWithRecordingTaskPrompt = TaskPromptEntity(
//     promptID: umPassaroWithRecordingTaskPromptID,
//     taskID: umPassaroTaskWithRecording.taskID!,
//     filePath: AudioFilePaths.ehMelhorUmPassaro);
//
// final nemTudoWithRecordingTaskPrompt = TaskPromptEntity(
//     promptID: nemTudoWithRecordingTaskPromptID,
//     taskID: nemTudoTaskWithRecording.taskID!,
//     filePath: AudioFilePaths.nemTudoQueReluz);

// List<TaskPromptEntity> tasksPromptsList = [
//   // cincoPatinhosTaskPrompt,
//   // umPassaroTaskPrompt,
//   // nemTudoTaskPrompt,
//   // cincoPatinhosWithRecordingTaskPrompt,
//   // umPassaroWithRecordingTaskPrompt,
//   // nemTudoWithRecordingTaskPrompt
// ];
