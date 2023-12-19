import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/tarefa/tarefa_controller.dart';
import 'package:record/record.dart';
import '../audio_player/audio_recorder_interface.dart';

class TarefaScreen extends StatelessWidget {
  final bool isRecordingMode;

  TarefaScreen({Key? key, this.isRecordingMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TarefaController tarefaController = Get.find();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isRecordingMode ? _buildRecordingInterface(tarefaController) : _buildPlaybackInterface(tarefaController),
      ),
    );
  }

  Widget _buildRecordingInterface(TarefaController controller) {
    // Return the interface for recording audio
    return Obx(() {
      return AudioRecorderInterface(
        onStop: (path) {
          // Handle the stop event
        },
        isRecording: controller.audioRecorderController.recordState.value == RecordState.record,
      );
    });
  }

  Widget _buildPlaybackInterface(TarefaController controller) {
    // Return the interface for playing audio
    return Text("Audio playback interface goes here");
  }
}
