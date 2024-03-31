library task_seeds;

import '../../app/task/task_entity.dart';
import '../../constants/enums/task_enums.dart';
import '../modules/modules_seeds.dart';

part "task_seeds_list.dart";

part "task_seeds_constants.dart";

TaskEntity helloHowAreYouTask = TaskEntity(
  taskID: helloHowAreYouTaskId,
  title: helloHowAreYouTaskTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 1,
);

TaskEntity whatsYourNameTask = TaskEntity(
    taskID: whatsYourNameTaskId,
    title: whatsYourNameTaskTitle,
    moduleID: sociodemographicInfoId,
    taskMode: TaskMode.record,
    timeForCompletion: 40,
    mayRepeatPrompt: true,
    position: 2);

TaskEntity whatsYourDOBTask = TaskEntity(
  taskID: whatsYourDOBTaskId,
  title: whatsYourDOBTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 3,
);

TaskEntity whatsYourEducationLevelTask = TaskEntity(
  taskID: whatsYourEducationLevelTaskId,
  title: whatsYourEducationLevelTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 4,
);

TaskEntity whatWasYourProfessionTask = TaskEntity(
  taskID: whatWasYourProfessionTaskId,
  title: whatWasYourProfessionTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 5,
);

TaskEntity whoDoYouLiveWithTask = TaskEntity(
  taskID: whoDoYouLiveWithTaskId,
  title: whoDoYouLiveWithTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 6,
);

TaskEntity doYouExerciseFrequentlyTask = TaskEntity(
  taskID: doYouExerciseFrequentlyTaskId,
  title: doYouExerciseFrequentlyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 7,
);

TaskEntity doYouReadFrequentlyTask = TaskEntity(
  taskID: doYouReadFrequentlyTaskId,
  title: doYouReadFrequentlyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 8,
);

TaskEntity doYouPlayPuzzlesOrVideoGamesFrequentlyTask = TaskEntity(
  taskID: doYouPlayPuzzlesOrVideoGamesFrequentlyTaskId,
  title: doYouPlayPuzzlesOrVideoGamesFrequentlyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 9,
);

TaskEntity doYouHaveAnyDiseasesTask = TaskEntity(
  taskID: doYouHaveAnyDiseasesTaskId,
  title: doYouHaveAnyDiseasesTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 10,
);

TaskEntity payCloseAttentionTask = TaskEntity(
  taskID: payCloseAttentionTaskId,
  title: payCloseAttentionTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 11,
);

TaskEntity subtracting3AndAgainTask = TaskEntity(
  taskID: subtracting3AndAgainTaskId,
  title: subtracting3AndAgainTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 12,
);

TaskEntity whatYearAreWeInTask = TaskEntity(
  taskID: whatYearAreWeInTaskId,
  title: whatYearAreWeInTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 13,
);

TaskEntity whatMonthAreWeInTask = TaskEntity(
  taskID: whatMonthAreWeInTaskId,
  title: whatMonthAreWeInTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 14,
);

TaskEntity whatDayOfTheMonthIsItTask = TaskEntity(
  taskID: whatDayOfTheMonthIsItTaskId,
  title: whatDayOfTheMonthIsItTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 15,
);

TaskEntity whatDayOfTheWeekIsItTask = TaskEntity(
  taskID: whatDayOfTheWeekIsItTaskId,
  title: whatDayOfTheWeekIsItTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 16,
);

TaskEntity howOldAreYouTask = TaskEntity(
  taskID: howOldAreYouTaskId,
  title: howOldAreYouTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 17,
);

TaskEntity whereAreWeNowTask = TaskEntity(
  taskID: whereAreWeNowTaskId,
  title: whereAreWeNowTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 18,
);

TaskEntity currentPresidentOfBrazilTask = TaskEntity(
  taskID: currentPresidentOfBrazilTaskId,
  title: currentPresidentOfBrazilTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 19,
);

TaskEntity formerPresidentOfBrazilTask = TaskEntity(
  taskID: formerPresidentOfBrazilTaskId,
  title: formerPresidentOfBrazilTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 20,
);

TaskEntity repeatWordsAfterListeningFirstTimeTask = TaskEntity(
  taskID: repeatWordsAfterListeningFirstTimeTaskId,
  title: repeatWordsAfterListeningFirstTimeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 21,
);

TaskEntity recallWordsFromListFirstTimeTask = TaskEntity(
  taskID: recallWordsFromListFirstTimeTaskId,
  title: recallWordsFromListFirstTimeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 22,
);

TaskEntity repeatWordsAfterListeningSecondTimeTask = TaskEntity(
  taskID: repeatWordsAfterListeningSecondTimeTaskId,
  title: repeatWordsAfterListeningSecondTimeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 23,
);

TaskEntity recallWordsFromListSecondTimeTask = TaskEntity(
  taskID: recallWordsFromListSecondTimeTaskId,
  title: recallWordsFromListSecondTimeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 24,
);

TaskEntity repeatWordsAfterListeningThirdTimeTask = TaskEntity(
  taskID: repeatWordsAfterListeningThirdTimeTaskId,
  title: repeatWordsAfterListeningThirdTimeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 25,
);

TaskEntity recallWordsFromListThirdTimeTask = TaskEntity(
  taskID: recallWordsFromListThirdTimeTaskId,
  title: recallWordsFromListThirdTimeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 26,
);

TaskEntity whatDidYouDoYesterdayTask = TaskEntity(
  taskID: whatDidYouDoYesterdayTaskId,
  title: whatDidYouDoYesterdayTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 27,
);

TaskEntity favoriteChildhoodGameTask = TaskEntity(
  taskID: favoriteChildhoodGameTaskId,
  title: favoriteChildhoodGameTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 28,
);

TaskEntity retellWordsHeardBeforeTask = TaskEntity(
  taskID: retellWordsHeardBeforeTaskId,
  title: retellWordsHeardBeforeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 29,
);

TaskEntity payCloseAttentionToTheStoryTask = TaskEntity(
  taskID: payCloseAttentionToTheStoryTaskId,
  title: payCloseAttentionToTheStoryTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 30,
);

TaskEntity anasCatStoryTask = TaskEntity(
  taskID: anasCatStoryTaskId,
  title: anasCatStoryTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 31,
);

TaskEntity howManyAnimalsCanYouThinkOfTask = TaskEntity(
  taskID: howManyAnimalsCanYouThinkOfTaskId,
  title: howManyAnimalsCanYouThinkOfTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 32,
);

TaskEntity wordsStartingWithFTask = TaskEntity(
  taskID: wordsStartingWithFTaskId,
  title: wordsStartingWithFTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 33,
);

TaskEntity wordsStartingWithATask = TaskEntity(
  taskID: wordsStartingWithATaskId,
  title: wordsStartingWithATitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 34,
);

TaskEntity wordsStartingWithSTask = TaskEntity(
  taskID: wordsStartingWithSTaskId,
  title: wordsStartingWithSTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 35,
);

TaskEntity describeWhatYouSeeTask = TaskEntity(
  taskID: describeWhatYouSeeTaskId,
  title: describeWhatYouSeeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 36,
);

TaskEntity retellStoryTask = TaskEntity(
  taskID: retellStoryTaskId,
  title: retellStoryTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 37,
);

TaskEntity yesOrNoQuestionsTask = TaskEntity(
  taskID: yesOrNoQuestionsTaskId,
  title: yesOrNoQuestionsTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 38,
);

TaskEntity canYouBatheAloneTask = TaskEntity(
  taskID: canYouBatheAloneTaskId,
  title: canYouBatheAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 39,
);

TaskEntity canYouDressAloneTask = TaskEntity(
  taskID: canYouDressAloneTaskId,
  title: canYouDressAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 40,
);

TaskEntity canYouUseToiletAloneTask = TaskEntity(
  taskID: canYouUseToiletAloneTaskId,
  title: canYouUseToiletAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 41,
);

TaskEntity canYouUsePhoneAloneTask = TaskEntity(
  taskID: canYouUsePhoneAloneTaskId,
  title: canYouUsePhoneAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 42,
);

TaskEntity canYouShopAloneTask = TaskEntity(
  taskID: canYouShopAloneTaskId,
  title: canYouShopAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 43,
);

TaskEntity canYouHandleMoneyAloneTask = TaskEntity(
  taskID: canYouHandleMoneyAloneTaskId,
  title: canYouHandleMoneyAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 44,
);

TaskEntity canYouManageMedicationAloneTask = TaskEntity(
  taskID: canYouManageMedicationAloneTaskId,
  title: canYouManageMedicationAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 45,
);

TaskEntity canYouUseTransportAloneTask = TaskEntity(
  taskID: canYouUseTransportAloneTaskId,
  title: canYouUseTransportAloneTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 46,
);

TaskEntity feelingsInPastTwoWeeksTask = TaskEntity(
  taskID: feelingsInPastTwoWeeksTaskId,
  title: feelingsInPastTwoWeeksTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 47,
);

TaskEntity feelingSadFrequentlyTask = TaskEntity(
  taskID: feelingSadFrequentlyTaskId,
  title: feelingSadFrequentlyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 48,
);

TaskEntity feelingTiredOrLackingEnergyTask = TaskEntity(
  taskID: feelingTiredOrLackingEnergyTaskId,
  title: feelingTiredOrLackingEnergyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 49,
);

TaskEntity troubleSleepingTask = TaskEntity(
  taskID: troubleSleepingTaskId,
  title: troubleSleepingTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 50,
);

TaskEntity preferringToStayHomeTask = TaskEntity(
  taskID: preferringToStayHomeTaskId,
  title: preferringToStayHomeTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 51,
);

TaskEntity feelingUselessOrGuiltyTask = TaskEntity(
  taskID: feelingUselessOrGuiltyTaskId,
  title: feelingUselessOrGuiltyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 52,
);

TaskEntity lostInterestInActivitiesTask = TaskEntity(
  taskID: lostInterestInActivitiesTaskId,
  title: lostInterestInActivitiesTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 53,
);

TaskEntity hopefulAboutFutureTask = TaskEntity(
  taskID: hopefulAboutFutureTaskId,
  title: hopefulAboutFutureTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 54,
);

TaskEntity feelingLifeIsWorthLivingTask = TaskEntity(
    taskID: feelingLifeIsWorthLivingTaskId,
    title: feelingLifeIsWorthLivingTitle,
    moduleID: sociodemographicInfoId,
    taskMode: TaskMode.record,
    timeForCompletion: 40,
    mayRepeatPrompt: true,
    position: 55);

TaskEntity thankingForParticipationTask = TaskEntity(
  taskID: thankingForParticipationTaskId,
  title: thankingForParticipationTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 56,
);

////////////////////////////////////////////

// TASKS VERIFICAÇÃO

TaskEntity aPressaEhInimigaTask = TaskEntity(
  taskID: pressaInimigaId,
  title: pressaInimigaTitle,
  moduleID: testsModuleId,
  taskMode: TaskMode.play,
  position: 1,
);
TaskEntity umPassaroTask = TaskEntity(
  taskID: umPassaroNaMaoId,
  title: umPassaroNaMaoTitle,
  moduleID: testsModuleId,
  taskMode: TaskMode.play,
  position: 2,
);
TaskEntity nemTudoTask = TaskEntity(
  taskID: nemTudoQueReluzId,
  title: nemTudoQueReluzTitle,
  moduleID: testsModuleId,
  taskMode: TaskMode.play,
  position: 3,
);
TaskEntity conteAte5Task = TaskEntity(
    taskID: conteAte5Id,
    moduleID: testsModuleId,
    title: conteAte5Title,
    taskMode: TaskMode.record,
    position: 4);

TaskEntity digaDoisAnimaisTask = TaskEntity(
  taskID: digaDoisAnimaisId,
    moduleID: testsModuleId,
    title: digaDoisAnimaisTitle,
    taskMode: TaskMode.record,
    position: 5);
TaskEntity repitaAFraseTask = TaskEntity(
  taskID: repitaAFraseId,
    moduleID: testsModuleId,
    title: repitaAFraseTitle,
    taskMode: TaskMode.record,
    position: 6);
