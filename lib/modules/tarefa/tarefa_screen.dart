import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../audio_player/audio_player_interface.dart';
import 'tarefa_controller.dart';

class TarefaScreen extends GetView<TarefaController> {
  TarefaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Obx(() => AudioPlayerInterface(audioPath: controller.audioPath.value)),
      ),
    );
  }
}

