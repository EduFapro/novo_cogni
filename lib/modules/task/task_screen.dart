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
      body: Center(
        child: mode == TaskMode.play ? buildAudioPlayerInterface(context) : buildAudioRecorderInterface(),
      ),
    );
  }

  Widget buildAudioPlayerInterface(BuildContext context) {
    final Size windowSize = MediaQuery.of(context).size;
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() => Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  iconSize: 48, // Larger icon size
                  icon: Icon(controller.isPlaying.value ? Icons.stop : Icons.play_arrow),
                  onPressed: () => controller.togglePlay(controller.audioPath.value),
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
                    // Handle the check icon button press
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
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
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
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black, // Color for the border
          width: 2.0, // Border width
        ),
      ),
      child: IconButton(
        icon: Icon(Icons.check),
        onPressed: onPressed,
      ),
    );
  }
}

class EdSkipButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  EdSkipButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.white, // Background color
        onPrimary: Colors.black, // Text color
        elevation: 2, // Elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0), // Rounded corners
          side: BorderSide(color: Colors.black), // Border color and width
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding
      ),
    );
  }
}
