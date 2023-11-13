import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;

import '../../utils/file_management/audio_management.dart';

class AudioRecorderController extends GetxController {
  final AudioRecorder _audioRecorder = AudioRecorder();
  var recordDuration = 0.obs;
  var recordState = RecordState.stop.obs;
  var amplitude = Rxn<Amplitude>();
  Timer? timer;
  StreamSubscription<RecordState>? recordSub;
  StreamSubscription<Amplitude>? amplitudeSub;

  AudioRecorderController() {
    recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      updateRecordState(recordState);
    });

    amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => amplitude.value = amp);
  }


  Future<void> start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const config = RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        );

        final dirPath = await getTemporaryDirectoryPath(); // Use a temporary directory
        final path = p.join(
          dirPath,
          'audio_${DateTime.now().millisecondsSinceEpoch}.aac',
        );

        await _audioRecorder.start(config, path: path);
        recordDuration.value = 0;
        startTimer();
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> stop() async {
    try {
      final path = await _audioRecorder.stop();
      timer?.cancel();
      recordDuration.value = 0;
      if (path != null) {
        final fileName = p.basename(path);
        final file = File(path);
        final data = await file.readAsBytes();
        await saveAudioFile(ByteData.view(data.buffer), fileName);
        await file.delete(); // Optionally delete the file from the temporary directory
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
    recordState.value = state; // Use .value to assign to Rx<RecordState>
    update(); // This should work as your class extends GetxController
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      recordDuration.value++; // Use .value to update RxInt
      update(); // Notify listeners
    });
  }


  void dispose() {
    timer?.cancel();
    recordSub?.cancel();
    amplitudeSub?.cancel();
    _audioRecorder.dispose();
  }
}
