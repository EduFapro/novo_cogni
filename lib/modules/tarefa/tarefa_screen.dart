import 'package:flutter/material.dart';
import '../audio_player/audio_recorder_interface.dart';

class TarefaScreen extends StatefulWidget {
  const TarefaScreen({Key? key}) : super(key: key);

  @override
  State<TarefaScreen> createState() => _TarefaScreenState();
}

class _TarefaScreenState extends State<TarefaScreen> {
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AudioRecorderInterface(
          onStop: (path) {
            setState(() {
              audioPath = path;
              // Here you can decide what to do with the recorded audio path
              // For example, save it, upload it, or prepare it for playback
            });
          },
        ),
      ),
    );
  }
}
