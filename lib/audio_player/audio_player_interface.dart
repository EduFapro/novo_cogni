import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'audio_player_controller.dart';

class AudioPlayerInterface extends StatelessWidget {
  final String audioPath;

  AudioPlayerInterface({Key? key, required this.audioPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioPlayerController controller = Get.find<AudioPlayerController>();

    return Obx(() => FloatingActionButton(
      onPressed: () => controller.togglePlay(audioPath),
      child: Icon(controller.isPlaying.value ? Icons.stop : Icons.play_arrow),
      backgroundColor: Colors.blue,
    ));
  }
}

