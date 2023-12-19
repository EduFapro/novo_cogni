import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/enums/tarefa_enums.dart';
import '../../audio_player/audio_player_interface.dart';
import '../../audio_player/audio_recorder_interface.dart';
import 'tarefa_controller.dart';

class TarefaScreen extends GetView<TarefaController> {
  final TarefaMode mode;

  TarefaScreen({Key? key, this.mode = TarefaMode.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: mode == TarefaMode.play
            ? AudioPlayerInterface(audioPath: controller.audioPath.value)
            : AudioRecorderInterface(
          onStop: (path) {
            controller.audioPath.value = path;
          },
        ),
      ),
    );
  }
}
