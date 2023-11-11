import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'audio_recorder_controller.dart';

class AudioRecorderInterface extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorderInterface({Key? key, required this.onStop}) : super(key: key);

  @override
  State<AudioRecorderInterface> createState() => _AudioRecorderInterfaceState();
}

class _AudioRecorderInterfaceState extends State<AudioRecorderInterface> {
  late AudioRecorderController controller;

  @override
  void initState() {
    super.initState();
    controller = AudioRecorderController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildRecordStopControl(),
            const SizedBox(width: 20),
            _buildPauseResumeControl(),
            const SizedBox(width: 20),
            _buildText(),
          ],
        ),
        if (controller.amplitude != null) ...[
          const SizedBox(height: 40),
          Text('Current: ${controller.amplitude?.current ?? 0.0}'),
          Text('Max: ${controller.amplitude?.max ?? 0.0}'),
        ],
      ],
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (controller.recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (controller.recordState != RecordState.stop) ? controller.stop() : controller.start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (controller.recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (controller.recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (controller.recordState == RecordState.pause) ? controller.resume() : controller.pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (controller.recordState != RecordState.stop) {
      return _buildTimer();
    }

    return const Text("Waiting to record");
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(controller.recordDuration ~/ 60);
    final String seconds = _formatNumber(controller.recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
