class AudioRecorderView extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorderView({Key? key, required this.onStop}) : super(key: key);

  @override
  State<AudioRecorderView> createState() => _AudioRecorderViewState();
}

class _AudioRecorderViewState extends State<AudioRecorderView> {
  late AudioRecorderController controller;

  @override
  void initState() {
    super.initState();
    controller = AudioRecorderController();
  }

  @override
  Widget build(BuildContext context) {
    // Build UI using controller's state and methods
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

// UI helper methods like _buildRecordStopControl, _buildPauseResumeControl, etc.
}
