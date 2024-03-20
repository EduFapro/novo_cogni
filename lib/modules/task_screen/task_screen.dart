import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';

import 'package:novo_cogni/modules/task_screen/task_screen_controller.dart';

import '../../constants/enums/task_enums.dart';
import '../widgets/music_visualizer.dart';

class TaskScreen extends GetView<TaskScreenController> {
  TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isModuleCompleted.isTrue) {
                return TaskCompletedWidget(onNavigateBack: () => Get.back());
              } else if (controller.currentTask.value != null) {
                var mode = controller.taskMode.value;
                return Column(
                  children: [
                    NumericProgressIndicator(
                      current: controller.currentTaskIndex.value,
                      total: controller.totalTasks.value,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      "Current Task: ${controller.currentTaskEntity.value?.title ?? 'Unknown'}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Center(child: buildInterfaceBasedOnMode(context, mode)),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: buildAccordion(context)),
          )
        ],
      ),
    );
  }

  Widget buildInterfaceBasedOnMode(BuildContext context, TaskMode mode) {
    switch (mode) {
      case TaskMode.play:
        return Column(
          children: [
            buildGeneralInterface(context),
            buildAudioPlayerInterface(context),
          ],
        );
      case TaskMode.record:
        return Column(
          children: [
            buildGeneralInterface(context),
            buildAudioRecorderInterface(context),
          ],
        );
      default:
        return Container();
    }
  }

  Widget buildGeneralInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    print("TRUEEE: ${controller.shouldDisablePlayButton}");
    return SizedBox(
      width: 880,
      child: Column(
        children: [
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: TaskDeadlineBanner(
          //     deadlineText:
          //         "Tempo Limite da Tarefa: ${controller.currentTaskEntity.value?.timeForCompletion ?? 'Indefinido'}",
          //   ),
          // ),
          // CountdownTimer(
          //   countdownTrigger: controller.countdownTrigger,
          //   initialDurationInSeconds: 4,
          //   onTimerComplete: _onTimeCompleted,
          // ),
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

                      IconButton(
                        color: controller.shouldDisablePlayButton.value
                            ? Colors.redAccent
                            : Colors.black54,

                        disabledColor: Colors.redAccent,
                        iconSize: 48,
                        icon: Icon(controller.isPlaying.value ? Icons.stop : Icons.play_arrow),
                        onPressed: controller.shouldDisablePlayButton.value ? null : () => controller.togglePlay(),
                      ),



                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: windowSize.width * 0.4,
                            height: 80,
                            child: MusicVisualizer(
                              isPlaying: controller.isPlaying.value,
                              barCount: 30, // Example: 30 bars
                              barWidth: 3, // Example: Each bar is 3 pixels wide
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
                    EdSkipButton(
                      text: 'Skip',
                    ),
                    EdCheckIconButton(
                      iconData: Icons.check,
                      onPressed: () {
                        controller.onCheckButtonPressed();
                      },
                      isActive: controller
                          .isCheckButtonEnabled, // Pass the RxBool directly
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget buildAudioRecorderInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    final recorderInterfaceHeight = windowSize.height * 0.40;
    final TaskScreenController controller = Get.find<TaskScreenController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400.0),
      child: Container(
        height: recorderInterfaceHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20,),
            Flexible(
              flex: 5,
              child: Container(
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EdCheckIconButton(
                        iconData: Icons.close,
                        onPressed: () {
                          controller.stopRecording();
                        },
                        isActive: true.obs,
                      ),

                      // This Container wraps the middle button and gives it a bigger size
                      Container(
                        decoration: BoxDecoration(
                            color: controller.isRecordButtonEnabled.value
                                ? (controller.isRecording.value ? Colors.redAccent.shade100 : Colors.blue.shade100)
                                : Colors.grey.shade400, // Grey color for disabled state
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: IconButton(
                          icon: Icon(
                            controller.isRecording.value ? Icons.stop : Icons.mic,
                            size: 80, // Adjust the size of the icon if necessary
                          ),
                          color: controller.isRecordButtonEnabled.value
                              ? (controller.isRecording.value ? Colors.red : Colors.blue)
                              : Colors.grey, // Grey icon for disabled state
                          onPressed: controller.isRecordButtonEnabled.value ? () async {
                            if (controller.isRecording.value) {
                              await controller.stopRecording();
                            } else {
                              await controller.startRecording();
                            }
                          } : null, // Disable the button if isRecordButtonEnabled is false
                        ),
                      ),


                      EdCheckIconButton(
                        iconData: Icons.check,
                        onPressed: () {
                          controller.onCheckButtonPressed();
                        },
                        isActive: controller.isCheckButtonEnabled,
                      ),
                    ],
                  );
                }),
              ),
            ),
            Flexible(
              flex: 6,
              child: Container(
                width: 300,
                child: SizedBox(
                  height: 200,
                  child: MusicVisualizer(
                    isPlaying: controller.isRecording.value,
                    barCount: 30,
                    barWidth: 2,
                    activeColor: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTimeCompleted() async {
    // Play time up sound
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/climbing_fast_sound_effect.mp3'));

    // Show time up dialog
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Time Up!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'You have completed the time for this task.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                  audioPlayer.stop(); // Stop the sound if needed
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Disables popup to close by tapping outside
    );
  }

  Widget buildAccordion(BuildContext context) {
    var controller = Get.find<TaskScreenController>();
    return ExpansionTile(
      shape: Border(),
      initiallyExpanded: false,
      // Set to true if you want the accordion to be expanded initially
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

class EdCheckIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final RxBool isActive;

  EdCheckIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Obx here to listen to changes in isActive
    return Obx(() {
      Color borderColor = isActive.value ? Colors.black : Colors.grey;
      Color iconColor = iconData == Icons.check ? Colors.green : Colors.red;

      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 2.0),
        ),
        child: IconButton(
          icon: Icon(iconData),
          color: iconColor,
          onPressed: isActive.value ? onPressed : null,
        ),
      );
    });
  }
}

class EdSkipButton extends StatelessWidget {
  final String text;

  EdSkipButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskScreenController>();

    return Obx(() => ElevatedButton(
          onPressed: controller.launchNextTaskWithoutCompletingCurrent,
          child: Text(text),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor:
                controller.isPlaying.value ? Colors.grey : Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(
                  color:
                      controller.isPlaying.value ? Colors.grey : Colors.black),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        ));
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
            'All tasks completed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onNavigateBack,
            child: Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
