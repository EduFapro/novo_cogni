import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;

class AudioRecorderController {
  final AudioRecorder _audioRecorder = AudioRecorder();
  int recordDuration = 0;
  RecordState recordState = RecordState.stop;
  Amplitude? amplitude;
  Timer? timer;
  StreamSubscription<RecordState>? recordSub;
  StreamSubscription<Amplitude>? amplitudeSub;

  AudioRecorderController() {
    recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      updateRecordState(recordState);
    });

    amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => amplitude = amp);
  }

  Future<void> start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // Define the recording configuration
        const config = RecordConfig(
          encoder: AudioEncoder.aacLc, // You can choose the encoder as per your requirement
          bitRate: 128000, // Example bitrate
          sampleRate: 44100, // Example sample rate
        );

        // Define the file path for the recording
        final dir = await getApplicationDocumentsDirectory();
        final path = p.join(
          dir.path,
          'audio_${DateTime.now().millisecondsSinceEpoch}.aac', // File extension based on encoder
        );

        // Start recording
        await _audioRecorder.start(config, path: path);

        // Reset and start the timer
        recordDuration = 0;
        startTimer();
      }
    } catch (e) {
      // Handle exceptions
      print('Error starting recording: $e');
    }
  }


  Future<void> stop() async {
    try {
      final path = await _audioRecorder.stop();
      timer?.cancel();
      recordDuration = 0;
      if (path != null) {
        // Do something with the path, e.g., notify listeners
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }


  Future<void> pause() async {
    try {
      await _audioRecorder.pause();
      timer?.cancel();
    } catch (e) {
      print('Error pausing recording: $e');
    }
  }


  Future<void> resume() async {
    try {
      await _audioRecorder.resume();
      startTimer();
    } catch (e) {
      print('Error resuming recording: $e');
    }
  }


  void updateRecordState(RecordState state) {
    recordState = state;
    // Notify listeners if needed, e.g., using a callback or a state management solution
  }


  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      recordDuration++;
      // Update UI or notify listeners about the timer update
    });
  }


  void dispose() {
    timer?.cancel();
    recordSub?.cancel();
    amplitudeSub?.cancel();
    _audioRecorder.dispose();
  }
}
