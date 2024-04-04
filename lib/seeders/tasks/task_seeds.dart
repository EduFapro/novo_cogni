library task_seeds;

import '../../app/task/task_entity.dart';
import '../../constants/enums/task_enums.dart';
import '../modules/modules_seeds.dart';

part "task_seeds_list.dart";

part "task_seeds_constants.dart";


// sociodemographicInfo - 1
TaskEntity helloHowAreYouTask = TaskEntity(
  taskID: helloHowAreYouTaskId,
  title: helloHowAreYouTaskTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 1,
);
// sociodemographicInfo - 2
TaskEntity whatsYourNameTask = TaskEntity(
    taskID: whatsYourNameTaskId,
    title: whatsYourNameTaskTitle,
    moduleID: sociodemographicInfoId,
    taskMode: TaskMode.record,
    timeForCompletion: 40,
    mayRepeatPrompt: true,
    position: 2);
// sociodemographicInfo - 3
TaskEntity whatsYourDOBTask = TaskEntity(
  taskID: whatsYourDOBTaskId,
  title: whatsYourDOBTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 3,
);
// sociodemographicInfo - 4
TaskEntity whatsYourEducationLevelTask = TaskEntity(
  taskID: whatsYourEducationLevelTaskId,
  title: whatsYourEducationLevelTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 4,
);
// sociodemographicInfo - 5
TaskEntity whatWasYourProfessionTask = TaskEntity(
  taskID: whatWasYourProfessionTaskId,
  title: whatWasYourProfessionTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 5,
);
// sociodemographicInfo - 6
TaskEntity whoDoYouLiveWithTask = TaskEntity(
  taskID: whoDoYouLiveWithTaskId,
  title: whoDoYouLiveWithTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 6,
);
// sociodemographicInfo - 7
TaskEntity doYouExerciseFrequentlyTask = TaskEntity(
  taskID: doYouExerciseFrequentlyTaskId,
  title: doYouExerciseFrequentlyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 7,
);
// sociodemographicInfo - 8
TaskEntity doYouReadFrequentlyTask = TaskEntity(
  taskID: doYouReadFrequentlyTaskId,
  title: doYouReadFrequentlyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 8,
);
// sociodemographicInfo - 9
TaskEntity doYouPlayPuzzlesOrVideoGamesFrequentlyTask = TaskEntity(
  taskID: doYouPlayPuzzlesOrVideoGamesFrequentlyTaskId,
  title: doYouPlayPuzzlesOrVideoGamesFrequentlyTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 9,
);
// sociodemographicInfo - 10
TaskEntity doYouHaveAnyDiseasesTask = TaskEntity(
  taskID: doYouHaveAnyDiseasesTaskId,
  title: doYouHaveAnyDiseasesTitle,
  moduleID: sociodemographicInfoId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 10,
);
// cognitiveFunctions - 1
TaskEntity payCloseAttentionTask = TaskEntity(
  taskID: payCloseAttentionTaskId,
  title: payCloseAttentionTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 1,
);
// cognitiveFunctions - 2
TaskEntity subtracting3AndAgainTask = TaskEntity(
  taskID: subtracting3AndAgainTaskId,
  title: subtracting3AndAgainTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 2,
);
// cognitiveFunctions - 3
TaskEntity whatYearAreWeInTask = TaskEntity(
  taskID: whatYearAreWeInTaskId,
  title: whatYearAreWeInTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 3,
);
// cognitiveFunctions - 4
TaskEntity whatMonthAreWeInTask = TaskEntity(
  taskID: whatMonthAreWeInTaskId,
  title: whatMonthAreWeInTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 4,
);
// cognitiveFunctions - 5
TaskEntity whatDayOfTheMonthIsItTask = TaskEntity(
  taskID: whatDayOfTheMonthIsItTaskId,
  title: whatDayOfTheMonthIsItTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 5,
);
// cognitiveFunctions - 6
TaskEntity whatDayOfTheWeekIsItTask = TaskEntity(
  taskID: whatDayOfTheWeekIsItTaskId,
  title: whatDayOfTheWeekIsItTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 6,
);
// cognitiveFunctions - 7
TaskEntity howOldAreYouTask = TaskEntity(
  taskID: howOldAreYouTaskId,
  title: howOldAreYouTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 7,
);
// cognitiveFunctions - 8
TaskEntity whereAreWeNowTask = TaskEntity(
  taskID: whereAreWeNowTaskId,
  title: whereAreWeNowTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 8,
);
// cognitiveFunctions - 9
TaskEntity currentPresidentOfBrazilTask = TaskEntity(
  taskID: currentPresidentOfBrazilTaskId,
  title: currentPresidentOfBrazilTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 9,
);
// cognitiveFunctions - 10
TaskEntity formerPresidentOfBrazilTask = TaskEntity(
  taskID: formerPresidentOfBrazilTaskId,
  title: formerPresidentOfBrazilTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 10,
);
// cognitiveFunctions - 11
TaskEntity repeatWordsAfterListeningFirstTimeTask = TaskEntity(
  taskID: repeatWordsAfterListeningFirstTimeTaskId,
  title: repeatWordsAfterListeningFirstTimeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 11,
);
// cognitiveFunctions - 12
TaskEntity recallWordsFromListFirstTimeTask = TaskEntity(
  taskID: recallWordsFromListFirstTimeTaskId,
  title: recallWordsFromListFirstTimeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 12,
);
// cognitiveFunctions - 13
TaskEntity repeatWordsAfterListeningSecondTimeTask = TaskEntity(
  taskID: repeatWordsAfterListeningSecondTimeTaskId,
  title: repeatWordsAfterListeningSecondTimeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 13,
);
// cognitiveFunctions - 14
TaskEntity recallWordsFromListSecondTimeTask = TaskEntity(
  taskID: recallWordsFromListSecondTimeTaskId,
  title: recallWordsFromListSecondTimeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 14,
);
// cognitiveFunctions - 15
TaskEntity repeatWordsAfterListeningThirdTimeTask = TaskEntity(
  taskID: repeatWordsAfterListeningThirdTimeTaskId,
  title: repeatWordsAfterListeningThirdTimeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 15,
);
// cognitiveFunctions - 16
TaskEntity recallWordsFromListThirdTimeTask = TaskEntity(
  taskID: recallWordsFromListThirdTimeTaskId,
  title: recallWordsFromListThirdTimeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 16,
);
// cognitiveFunctions - 17
TaskEntity whatDidYouDoYesterdayTask = TaskEntity(
  taskID: whatDidYouDoYesterdayTaskId,
  title: whatDidYouDoYesterdayTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 17,
);
// cognitiveFunctions - 18
TaskEntity favoriteChildhoodGameTask = TaskEntity(
  taskID: favoriteChildhoodGameTaskId,
  title: favoriteChildhoodGameTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 18,
);
// cognitiveFunctions - 19
TaskEntity retellWordsHeardBeforeTask = TaskEntity(
  taskID: retellWordsHeardBeforeTaskId,
  title: retellWordsHeardBeforeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 19,
);
// cognitiveFunctions - 20
TaskEntity payCloseAttentionToTheStoryTask = TaskEntity(
  taskID: payCloseAttentionToTheStoryTaskId,
  title: payCloseAttentionToTheStoryTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 20,
);
// cognitiveFunctions - 21
TaskEntity anasCatStoryTask = TaskEntity(
  taskID: anasCatStoryTaskId,
  title: anasCatStoryTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: false,
  position: 21,
);
// cognitiveFunctions - 22
TaskEntity howManyAnimalsCanYouThinkOfTask = TaskEntity(
  taskID: howManyAnimalsCanYouThinkOfTaskId,
  title: howManyAnimalsCanYouThinkOfTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 22,
);
// cognitiveFunctions - 23
TaskEntity wordsStartingWithFTask = TaskEntity(
  taskID: wordsStartingWithFTaskId,
  title: wordsStartingWithFTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 23,
);
// cognitiveFunctions - 24
TaskEntity wordsStartingWithATask = TaskEntity(
  taskID: wordsStartingWithATaskId,
  title: wordsStartingWithATitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 24,
);
// cognitiveFunctions - 25
TaskEntity wordsStartingWithSTask = TaskEntity(
  taskID: wordsStartingWithSTaskId,
  title: wordsStartingWithSTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 25,
);
// cognitiveFunctions - 26
TaskEntity describeWhatYouSeeTask = TaskEntity(
  taskID: describeWhatYouSeeTaskId,
  title: describeWhatYouSeeTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 26,
);
// cognitiveFunctions - 27
TaskEntity retellStoryTask = TaskEntity(
  taskID: retellStoryTaskId,
  title: retellStoryTitle,
  moduleID: cognitiveFunctionsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 27,
);
// functionality - 1
TaskEntity yesOrNoQuestionsTask = TaskEntity(
  taskID: yesOrNoQuestionsTaskId,
  title: yesOrNoQuestionsTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 1,
);
// functionality - 2
TaskEntity canYouBatheAloneTask = TaskEntity(
  taskID: canYouBatheAloneTaskId,
  title: canYouBatheAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 2,
);
// functionality - 3
TaskEntity canYouDressAloneTask = TaskEntity(
  taskID: canYouDressAloneTaskId,
  title: canYouDressAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 3,
);
// functionality - 4
TaskEntity canYouUseToiletAloneTask = TaskEntity(
  taskID: canYouUseToiletAloneTaskId,
  title: canYouUseToiletAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 4,
);
// functionality - 5
TaskEntity canYouUsePhoneAloneTask = TaskEntity(
  taskID: canYouUsePhoneAloneTaskId,
  title: canYouUsePhoneAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 5,
);
// functionality - 6
TaskEntity canYouShopAloneTask = TaskEntity(
  taskID: canYouShopAloneTaskId,
  title: canYouShopAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 6,
);
// functionality - 7
TaskEntity canYouHandleMoneyAloneTask = TaskEntity(
  taskID: canYouHandleMoneyAloneTaskId,
  title: canYouHandleMoneyAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 7,
);
// functionality - 8
TaskEntity canYouManageMedicationAloneTask = TaskEntity(
  taskID: canYouManageMedicationAloneTaskId,
  title: canYouManageMedicationAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 8,
);
// functionality - 9
TaskEntity canYouUseTransportAloneTask = TaskEntity(
  taskID: canYouUseTransportAloneTaskId,
  title: canYouUseTransportAloneTitle,
  moduleID: functionalityId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 9,
);
// depressionSymptoms - 1
TaskEntity feelingsInPastTwoWeeksTask = TaskEntity(
  taskID: feelingsInPastTwoWeeksTaskId,
  title: feelingsInPastTwoWeeksTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 1,
);
// depressionSymptoms - 2
TaskEntity feelingSadFrequentlyTask = TaskEntity(
  taskID: feelingSadFrequentlyTaskId,
  title: feelingSadFrequentlyTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 2,
);
// depressionSymptoms - 3
TaskEntity feelingTiredOrLackingEnergyTask = TaskEntity(
  taskID: feelingTiredOrLackingEnergyTaskId,
  title: feelingTiredOrLackingEnergyTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 3,
);
// depressionSymptoms - 4
TaskEntity troubleSleepingTask = TaskEntity(
  taskID: troubleSleepingTaskId,
  title: troubleSleepingTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 4,
);
// depressionSymptoms - 5
TaskEntity preferringToStayHomeTask = TaskEntity(
  taskID: preferringToStayHomeTaskId,
  title: preferringToStayHomeTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 5,
);
// depressionSymptoms - 6
TaskEntity feelingUselessOrGuiltyTask = TaskEntity(
  taskID: feelingUselessOrGuiltyTaskId,
  title: feelingUselessOrGuiltyTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 6,
);
// depressionSymptoms - 7
TaskEntity lostInterestInActivitiesTask = TaskEntity(
  taskID: lostInterestInActivitiesTaskId,
  title: lostInterestInActivitiesTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 7,
);
// depressionSymptoms - 8
TaskEntity hopefulAboutFutureTask = TaskEntity(
  taskID: hopefulAboutFutureTaskId,
  title: hopefulAboutFutureTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.record,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 8,
);
// depressionSymptoms - 9
TaskEntity feelingLifeIsWorthLivingTask = TaskEntity(
    taskID: feelingLifeIsWorthLivingTaskId,
    title: feelingLifeIsWorthLivingTitle,
    moduleID: depressionSymptomsId,
    taskMode: TaskMode.record,
    timeForCompletion: 40,
    mayRepeatPrompt: true,
    position: 9,
);
// depressionSymptoms - 10
TaskEntity thankingForParticipationTask = TaskEntity(
  taskID: thankingForParticipationTaskId,
  title: thankingForParticipationTitle,
  moduleID: depressionSymptomsId,
  taskMode: TaskMode.play,
  timeForCompletion: 40,
  mayRepeatPrompt: true,
  position: 10,
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
