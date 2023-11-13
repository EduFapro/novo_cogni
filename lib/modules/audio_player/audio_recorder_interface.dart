import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';

import 'audio_recorder_controller.dart';

class AudioRecorderInterface extends StatefulWidget {
  final void Function(String path) onStop;
  final bool isRecording;

  const AudioRecorderInterface(
      {Key? key, required this.onStop, this.isRecording = false})
      : super(key: key);

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
    print(
        'Building AudioRecorderInterface with state: ${controller.recordState.value}');
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (controller.recordState.value == RecordState.stop)
                _buildRecordControl(),
              if (controller.recordState.value != RecordState.stop) ...[
                _buildPauseControl(),
                const SizedBox(width: 20),
                _buildStopControl(),
              ],
              const SizedBox(width: 20),
              _buildText(),
              if (controller.amplitude.value != null) ...[
                const SizedBox(height: 40),
                Text('Current: ${controller.amplitude.value?.current ?? 0.0}'),
                Text('Max: ${controller.amplitude.value?.max ?? 0.0}'),
              ],
            ],
          ))
    ]);
  }

  Widget _buildRecordControl() {
    final theme = Theme.of(context);
    return _buildControlButton(
      icon: Icons.mic,
      color: theme.primaryColor,
      onPressed: controller.start,
    );
  }

  Widget _buildControlButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onPressed}) {
    return ClipOval(
      child: Material(
        color: color.withOpacity(0.1),
        child: InkWell(
          child: SizedBox(
              width: 56, height: 56, child: Icon(icon, color: color, size: 30)),
          onTap: onPressed,
        ),
      ),
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
            (controller.recordState != RecordState.stop)
                ? controller.stop()
                : controller.start();
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
            (controller.recordState == RecordState.pause)
                ? controller.resume()
                : controller.pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (controller.recordState.value != RecordState.stop) {
      return _buildTimer();
    }

    return const Text("Waiting to record");
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(controller.recordDuration.value ~/ 60);
    final String seconds = _formatNumber(controller.recordDuration.value % 60);

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

  Widget _buildPauseControl() {
    IconData icon;
    VoidCallback onPressed;

    if (controller.recordState.value == RecordState.record) {
      icon = Icons.pause;
      onPressed = controller.pause;
    } else {
      icon = Icons.play_arrow;
      onPressed = controller.resume;
    }

    return _buildControlButton(
      icon: icon,
      color: Colors.red,
      onPressed: onPressed,
    );
  }

  Widget _buildStopControl() {
    return _buildControlButton(
      icon: Icons.stop,
      color: Colors.red,
      onPressed: controller.stop,
    );
  }
}
