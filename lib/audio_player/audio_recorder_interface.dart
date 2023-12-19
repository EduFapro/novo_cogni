import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'audio_recorder_controller.dart';
import 'dart:io'; // Import dart:io to get access to system paths

class AudioRecorderInterface extends StatelessWidget {
  final void Function(String path) onStop;

  AudioRecorderInterface({Key? key, required this.onStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioRecorderController controller = Get.put(AudioRecorderController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            // Define the path where the recording will be saved
            String path = await _getRecordingPath();
            await controller.startRecording(path);
          },
          child: Text('Record'),
        ),
        ElevatedButton(
          onPressed: () async {
            await controller.pauseRecording();
          },
          child: Text('Pause'),
        ),
        ElevatedButton(
          onPressed: () async {
            String? path = await controller.stopRecording();
            if (path != null) onStop(path);
          },
          child: Text('Stop'),
        ),
      ],
    );
  }

  // Helper method to generate a path for the recording
  Future<String> _getRecordingPath() async {
    // You can use the path_provider package to get a suitable directory
    // For example, using the application's documents directory:
    final directory = await getApplicationDocumentsDirectory();
    String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.aac';
    return '${directory.path}/$fileName';
  }
}
