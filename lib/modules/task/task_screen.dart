import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/enums/task_enums.dart';
import 'package:novo_cogni/modules/task/task_controller.dart';

class TaskScreen extends GetView<TaskController> {
  final TaskMode mode;

  TaskScreen({Key? key, this.mode = TaskMode.play}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(controller.taskName),
          Center(
            child: mode == TaskMode.play
                ? buildAudioPlayerInterface(context)
                : buildAudioRecorderInterface(),
          ),
        ],
      ),
    );
  }

  Widget buildAudioPlayerInterface(BuildContext context) {
    final Size windowSize = MediaQuery
        .of(context)
        .size;
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() =>
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      iconSize: 48,
                      icon: Icon(controller.isPlaying.value ? Icons.stop : Icons
                          .play_arrow),
                      onPressed: () =>
                          controller.togglePlay(controller.audioPath.value),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: windowSize.width * 0.7,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: CustomPaint(
                            painter: WaveformPainter(),
                          ),
                        ),
                      ),
                    ),
                    EdCheckIconButton(
                      onPressed: () {
                        controller.onCheckButtonPressed();
                      },
                    )
                  ],
                ),
                EdSkipButton(
                  text: 'Pular',
                  onPressed: () {
                    // Handle the skip button press
                  },
                )
              ],
            )),
      ),
    );
  }

  Widget buildAudioRecorderInterface() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return IconButton(
            icon: Icon(
              controller.isRecording.value ? Icons.stop : Icons.mic,
              size: 56.0,
              color: controller.isRecording.value ? Colors.red : Colors.blue,
            ),
            onPressed: () async {
              if (controller.isRecording.value) {
                await controller.stopRecording();
              } else {
                await controller.startRecording();
              }
            },
          );
        }),
      ],
    );
  }
}

class WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5; // Slightly thicker line for better visibility
    // Draw a simple line for now
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class EdCheckIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  EdCheckIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return Obx(() =>
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: controller.audioPlayed.value ? Colors.black : Colors.grey,
              width: 2.0,
            ),
          ),
          child: IconButton(
            icon: Icon(Icons.check),
            onPressed: controller.audioPlayed.value ? onPressed : null,
          ),
        ));
  }
}


class EdSkipButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  EdSkipButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<
        TaskController>(); // Ensure the controller is accessible

    return Obx(() =>
        ElevatedButton(
          onPressed: controller.isPlaying.value ? null : onPressed,
          child: Text(text),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: controller.isPlaying.value ? Colors.grey : Colors
                .white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(
                  color: controller.isPlaying.value ? Colors.grey : Colors
                      .black),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        ));
  }
}

