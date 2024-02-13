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
    final Size windowSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if (controller.isModuleCompleted.isTrue) {
          return TaskCompletedWidget(
            onNavigateBack: () {
              Get.back();
            },
          );
        } else if (controller.currentTask.value != null) {
          var mode = controller.taskMode.value;
          return Column(
            children: [
              NumericProgressIndicator(
                current: controller.currentTaskIndex.value,
                total: controller.totalTasks.value,
              ),
              SizedBox(height: windowSize.height * 0.1),
              Text(
                "Current Task: ${controller.currentTaskEntity.value?.title ?? 'Unknown'}",
                style: TextStyle(fontSize: 18),
              ),
              Center(
                child: buildInterfaceBasedOnMode(context, mode),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
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
    return Card(
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
                  iconSize: 48,
                  icon: Icon(controller.isPlaying.value
                      ? Icons.stop
                      : Icons.play_arrow),
                  onPressed: () => controller.togglePlay(),
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
                      onPressed: () {
                        // Handle the skip button press
                      },
                    ),
                    EdCheckIconButton(
                      iconData: Icons.check,
                      onPressed: () {
                        controller.onCheckButtonPressed();
                      },
                      isActive: controller.audioPlayed.value,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget buildAudioRecorderInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    final TaskScreenController controller = Get.find<TaskScreenController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20), // Add some spacing if needed
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Close button
                EdCheckIconButton(
                  iconData: Icons.close,
                  onPressed: () {
                    // Stop the recording
                    controller.stopRecording();
                  },
                  isActive: controller.isRecording.value,
                ),
                IconButton(
                  icon: Icon(
                    controller.isRecording.value ? Icons.stop : Icons.mic,
                    size: 115.0,
                    color:
                        controller.isRecording.value ? Colors.red : Colors.blue,
                  ),
                  onPressed: () async {
                    if (controller.isRecording.value) {
                      await controller.stopRecording();
                    } else {
                      await controller.startRecording();
                    }
                  },
                ),
                // Check button (active when not recording)
                EdCheckIconButton(
                  iconData: Icons.check,
                  onPressed: () {
                    controller.onCheckButtonPressed();
                  },
                  isActive: !controller.isRecording.value,
                ),
              ],
            );
          }),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: 300,
              child: MusicVisualizer(
                isPlaying: controller.isRecording.value,
                barCount: 30,
                barWidth: 2,
                activeColor: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class EdCheckIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final bool isActive;

  EdCheckIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor = isActive ? Colors.black : Colors.grey;
    Color iconColor = iconData == Icons.check ? Colors.green : Colors.red;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2.0),
      ),
      child: IconButton(
        icon: Icon(iconData),
        color: iconColor,
        onPressed: isActive ? onPressed : null,
      ),
    );
  }
}

class EdSkipButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  EdSkipButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<TaskScreenController>(); // Ensure the controller is accessible

    return Obx(() => ElevatedButton(
          onPressed: controller.isPlaying.value ? null : onPressed,
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
