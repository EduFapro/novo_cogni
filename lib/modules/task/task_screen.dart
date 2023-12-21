import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/app/enums/task_enums.dart';
import 'package:novo_cogni/modules/task/task_controller.dart';
import '../../audio_player/audio_player_interface.dart';
import '../../audio_player/audio_recorder_interface.dart';

class TaskScreen extends GetView<TaskController> {
  final TaskMode mode;

  TaskScreen({Key? key, this.mode = TaskMode.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: mode == TaskMode.play
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
