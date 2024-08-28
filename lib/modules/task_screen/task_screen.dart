import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constants/enums/task_enums.dart';
import '../../constants/translation/ui_messages.dart';
import '../../constants/translation/ui_strings.dart';
import '../evaluation/evaluation_controller.dart';
import '../widgets/music_visualizer.dart';
import 'countdown_timer.dart';
import 'task_screen_controller.dart';

class TaskScreen extends GetView<TaskScreenController> {
  TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var windowsSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (controller.isModuleCompleted.isTrue) {
                final evalController = Get.find<EvaluationController>();
                evalController.markModuleAsCompleted(
                    controller.moduleInstance.value!.moduleInstanceID!);
              }
              Get.back();
            }),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isModuleCompleted.isTrue) {
                  return TaskCompletedWidget(onNavigateBack: () {
                    final evalController = Get.find<EvaluationController>();
                    evalController.markModuleAsCompleted(
                        controller.moduleInstance.value!.moduleInstanceID!);
                    Get.back();
                  });
                } else if (controller.currentTask.value != null) {
                  var mode = controller.taskMode.value;
                  return Column(
                    children: [
                      if (controller.imagePath.value == 'no_image')
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: (windowsSize.width * 0.30)),
                          child: CustomLinearPercentIndicator(
                            current: controller.currentTaskIndex.value,
                            total: controller.totalTasks.value,
                          ),
                        ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade400,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${controller.currentTaskEntity.value?.title ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              child: CustomIconButton(
                                  iconData: Icons.double_arrow_outlined,
                                  label: "Pular e Próximo",
                                  onPressed: () => controller.skipCurrentTask(),
                                  isActive: true.obs,
                                  displayMessage: "Atividade Pulada"),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Center(
                                child:
                                    buildInterfaceBasedOnMode(context, mode))),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInterfaceBasedOnMode(BuildContext context, TaskMode mode) {
    var message = controller.isRecording.value
        ? "Gravação parada."
        : "Iniciando Gravação";

    final Size windowSize = MediaQuery.of(context).size;
    print(controller.imagePath.value);
    return Container(
      child: Column(
        children: [
          if (controller.imagePath.value == "no_image") Spacer(),
          if (controller.imagePath.value == "no_image" ||
              !controller.audioPlayed.value)
            SizedBox(
              child: Column(
                children: [
                  CountdownTimer(
                    countdownTrigger: controller.countdownTrigger,
                    initialDurationInSeconds:
                        controller.task.value!.timeForCompletion,
                    onTimerComplete: _onTimeCompleted,
                  ),
                  Card(
                    color: Color(0xFFD7D7D7),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            UiStrings.clickOnPlayToListenToTheTask,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    color:
                                        controller.shouldDisablePlayButton.value
                                            ? Colors.redAccent.shade100
                                            : Colors.black54,
                                    disabledColor: Colors.redAccent.shade100,
                                    iconSize: 48,
                                    icon: Icon(controller.isPlaying.value
                                        ? Icons.stop
                                        : Icons.play_arrow),
                                    onPressed:
                                        controller.shouldDisablePlayButton.value
                                            ? null
                                            : () => controller.togglePlay(),
                                  ),
                                  Text(UiStrings.play_audio,
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: windowSize.width * 0.4,
                                    height: 80,
                                    child: MusicVisualizer(
                                      isPlaying: controller.isPlaying.value,
                                      barCount: 30,
                                      barWidth: 3,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (mode == TaskMode.play) buildAudioPlayerInterface(context),
          if (controller.imagePath.value != "no_image")
            Expanded(
                child: Image.asset(
              controller.imagePath.value,
              fit: BoxFit.fill,
            )),
          if (mode == TaskMode.record &&
              controller.imagePath.value == "no_image")
            buildAudioRecorderInterface(context, controller),
          if (controller.imagePath.value == "no_image") Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                if (controller.imagePath.value != 'no_image')
                  Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: controller.hasPlaybackPath.isTrue
                          ? Container(
                              // color: Colors.orange,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      color: controller
                                              .shouldDisablePlayRecentlyButton
                                              .value
                                          ? Colors.redAccent.shade100
                                          : Colors.black54,
                                      disabledColor: Colors.redAccent.shade100,
                                      iconSize: 48,
                                      icon: Icon(
                                          controller.isPlayingPlayback.value
                                              ? Icons.stop
                                              : Icons.play_arrow),
                                      onPressed: controller
                                              .shouldDisablePlayRecentlyButton
                                              .value
                                          ? null
                                          : controller.hasPlaybackPath.value
                                              ? controller
                                                      .isPlayingPlayback.value
                                                  ? () => controller
                                                      .stopRecentlyRecorded()
                                                  : () => controller
                                                      .playRecentlyRecorded()
                                              : null),
                                  Container(
                                    // color: Colors.lightBlue,
                                    width: 350,
                                    child: MusicVisualizer(
                                      isPlaying:
                                          controller.isPlayingPlayback.value,
                                      activeColor: Colors.greenAccent.shade700,
                                      barCount: 20,
                                      barWidth: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      controller.isPlayingPlayback.value
                                          ? controller.remainingTime.value
                                          : controller.recordingDuration.value,
                                      style: TextStyle(
                                        color:
                                            controller.isPlayingPlayback.value
                                                ? Colors.red
                                                : Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    alignment: Alignment.center,
                                    child: CustomIconButton(
                                      iconData: Icons.close,
                                      color: Colors.red,
                                      label: "Excluir",
                                      onPressed: () =>
                                          controller.discardRecording(),
                                      isActive: true.obs,
                                      displayMessage: "Áudio Exlcuido",
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : CustomRecordingButton(controller: controller)),
                Expanded(
                    child: Container(
                  child: CustomIconButton(
                      iconData: Icons.check,
                      label: UiStrings.confirm,
                      onPressed: () => controller.onCheckButtonPressed(),
                      isActive: controller.isCheckButtonEnabled,
                      displayMessage: "Atividade Concluída"),
                )),
              ],
            ),
          ),
          if (controller.imagePath.value == 'no_image')
            SizedBox(
              height: 100,
            ),
        ],
      ),
    );
  }

  Widget buildGeneralInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    return SizedBox(
      width: 880,
      child: Column(
        children: [
          CountdownTimer(
            countdownTrigger: controller.countdownTrigger,
            initialDurationInSeconds: controller.task.value!.timeForCompletion,
            onTimerComplete: _onTimeCompleted,
          ),
          Card(
            color: Color(0xFFD7D7D7),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    UiStrings.clickOnPlayToListenToTheTask,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            color: controller.shouldDisablePlayButton.value
                                ? Colors.redAccent.shade100
                                : Colors.black54,
                            disabledColor: Colors.redAccent.shade100,
                            iconSize: 48,
                            icon: Icon(controller.isPlaying.value
                                ? Icons.stop
                                : Icons.play_arrow),
                            onPressed: controller.shouldDisablePlayButton.value
                                ? null
                                : () => controller.togglePlay(),
                          ),
                          Text(UiStrings.play_audio,
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: windowSize.width * 0.4,
                            height: 80,
                            child: MusicVisualizer(
                              isPlaying: controller.isPlaying.value,
                              barCount: 30,
                              barWidth: 3,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAudioPlayerInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                width: windowSize.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: windowSize.width * 0.2,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget buildAudioRecorderInterface(
      BuildContext context, TaskScreenController controller) {
    final Size windowSize = MediaQuery.of(context).size;
    final recorderInterfaceHeight = windowSize.height * 0.40;
    final TaskScreenController controller = Get.find<TaskScreenController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400.0),
      child: Container(
        height: recorderInterfaceHeight,
        child: Center(
          child: Column(
            children: [
              if (controller.imagePath.value == 'no_image')
                SizedBox(
                  height: 20,
                ),
              if (controller.imagePath.value == 'no_image' &&
                  controller.hasPlaybackPath.isFalse)
                CustomRecordingButton(controller: controller),
              if (controller.imagePath.value == 'no_image')
                SizedBox(
                  height: 20,
                ),
              if (controller.imagePath.value == 'no_image')
                Obx(() => Flexible(
                      flex: 6,
                      child: Container(
                        width: 600,
                        child: SizedBox(
                          height: 100,
                          child: (controller.hasPlaybackPath.isFalse)
                              ? MusicVisualizer(
                                  isPlaying: controller.isRecording.value,
                                  barCount: 30,
                                  barWidth: 2,
                                  activeColor: Colors.red,
                                )
                              : Container(
                                  // color: Colors.orange,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          color: controller
                                                  .shouldDisablePlayRecentlyButton
                                                  .value
                                              ? Colors.redAccent.shade100
                                              : Colors.black54,
                                          disabledColor:
                                              Colors.redAccent.shade100,
                                          iconSize: 48,
                                          icon: Icon(
                                              controller.isPlayingPlayback.value
                                                  ? Icons.stop
                                                  : Icons.play_arrow),
                                          onPressed: controller
                                                  .shouldDisablePlayRecentlyButton
                                                  .value
                                              ? null
                                              : controller.hasPlaybackPath.value
                                                  ? controller.isPlayingPlayback
                                                          .value
                                                      ? () => controller
                                                          .stopRecentlyRecorded()
                                                      : () => controller
                                                          .playRecentlyRecorded()
                                                  : null),
                                      Container(
                                        // color: Colors.lightBlue,
                                        width: 350,
                                        child: MusicVisualizer(
                                          isPlaying: controller
                                              .isPlayingPlayback.value,
                                          activeColor:
                                              Colors.greenAccent.shade700,
                                          barCount: 20,
                                          barWidth: 2,
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          controller.isPlayingPlayback.value
                                              ? controller.remainingTime.value
                                              : controller
                                                  .recordingDuration.value,
                                          style: TextStyle(
                                            color: controller
                                                    .isPlayingPlayback.value
                                                ? Colors.red
                                                : Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 70,
                                        alignment: Alignment.center,
                                        child: CustomIconButton(
                                          iconData: Icons.close,
                                          color: Colors.red,
                                          label: "Excluir",
                                          onPressed: () =>
                                              controller.discardRecording(),
                                          isActive: true.obs,
                                          displayMessage: "Áudio Exlcuido",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }

  void _onTimeCompleted() async {
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/climbing_fast_sound_effect.mp3'));

    if (controller.isRecording.value) {
      await controller.stopRecording();
    }

    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                UiStrings.timeUp,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                UiMessages.taskCompleted,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  audioPlayer.stop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget buildAccordion(BuildContext context) {
    var controller = Get.find<TaskScreenController>();
    return ExpansionTile(
      shape: Border(),
      initiallyExpanded: false,
      title:
          Text("Task Details", style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Evaluator: ${'controller.evaluatorName'}",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text("Participant: ${'controller.participantName'}",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text("Module: ${'controller.moduleName'}",
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onPressed;
  final RxBool isActive;
  String? displayMessage;
  Color? color;

  CustomIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.isActive,
    required this.label,
    this.displayMessage,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(iconData, size: 40),
            color: isActive.value ? color ?? Colors.blue : Colors.grey,
            onPressed: isActive.value
                ? () {
                    Get.closeAllSnackbars();
                    onPressed();
                    displayMessage != null
                        ? Get.snackbar(
                            "Ação",
                            displayMessage!,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.blue,
                            colorText: Colors.white,
                            borderRadius: 20,
                            margin: EdgeInsets.all(15),
                            duration: Duration(milliseconds: 1000),
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                          )
                        : null;
                  }
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(label, style: TextStyle(fontSize: 12)),
          ),
        ],
      );
    });
  }
}

class CustomRecordingButton extends StatelessWidget {
  final TaskScreenController controller;

  CustomRecordingButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var label = controller.isRecording.value ? "Parar" : "Gravar";
      var message = controller.isRecording.value
          ? "Gravação parada."
          : "Iniciando Gravação";

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: controller.isRecordButtonEnabled.value
                  ? (controller.isRecording.value
                      ? Colors.redAccent.shade100
                      : Colors.blue.shade100)
                  : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(
                controller.isRecording.value ? Icons.stop : Icons.mic,
                size: 80,
              ),
              color: controller.isRecordButtonEnabled.value
                  ? (controller.isRecording.value ? Colors.red : Colors.blue)
                  : Colors.grey,
              onPressed: controller.isRecordButtonEnabled.value
                  ? () async {
                      Get.closeAllSnackbars();

                      if (controller.isRecording.value) {
                        await controller.stopRecording();
                      } else {
                        await controller.startRecording();
                      }

                      Get.snackbar("Ação", message,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(milliseconds: 1000));
                    }
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(label, style: TextStyle(fontSize: 16)),
          ),
        ],
      );
    });
  }
}

class NumericProgressIndicator extends StatelessWidget {
  final int current;
  final int total;

  const NumericProgressIndicator({
    Key? key,
    required this.current,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$current / $total',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class TaskCompletedWidget extends StatelessWidget {
  final VoidCallback onNavigateBack;

  const TaskCompletedWidget({
    Key? key,
    required this.onNavigateBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 120,
            color: Colors.green,
          ),
          Text(
            UiMessages.allTasksCompleted,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNavigateBack,
            child: Text(UiStrings.goBack),
          ),
        ],
      ),
    );
  }
}

class CustomLinearPercentIndicator extends StatelessWidget {
  final int current;
  final int total;

  const CustomLinearPercentIndicator({
    Key? key,
    required this.current,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percent = total != 0 ? (current - 1) / total : 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          LinearPercentIndicator(
            lineHeight: 20.0,
            percent: percent,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
            barRadius: const Radius.circular(10),
          ),
          Text(
            '${current - 1}/ $total',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
