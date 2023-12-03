import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/tarefa/tarefa_controller.dart';
import 'package:record/record.dart';
import '../audio_player/audio_recorder_interface.dart';

class TarefaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TarefaController tarefaController = Get.find();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Obx(() {
          return AudioRecorderInterface(
            onStop: (path) {
              // Handle the stop event
            },
            isRecording: tarefaController.audioRecorderController.recordState.value == RecordState.record,
            // Pass other necessary data
          );
        }),
      ),
    );
  }
}
