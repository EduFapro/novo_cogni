import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../app/record_file/recording_file_entity.dart';

Future<String> renameAndSaveRecording({
  required String originalPath,
  required int evaluatorId,
  required int participantId,
  required int taskInstanceId,
  required Function(RecordingFileEntity) saveRecordingCallback,
}) async {
  final dateString = DateFormat('ddMMyyyy').format(DateTime.now());
  final formattedFileName = 'A${evaluatorId.toString().padLeft(2, '0')}_P${participantId.toString().padLeft(2, '0')}_T${taskInstanceId}_$dateString.aac';
  final newPath = path.join(path.dirname(originalPath), formattedFileName);
  final newFilePath = path.normalize(newPath);

  await File(originalPath).rename(newFilePath);

  final recording = RecordingFileEntity(
    taskInstanceId: taskInstanceId,
    filePath: newFilePath,
  );

  await saveRecordingCallback(recording);
  return newFilePath;
}


Future<String> getApplicationDocumentsPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String> getTemporaryDirectoryPath() async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

Future<String> saveAudioFile(ByteData data, String tempFileName, int evaluatorId,
    int participantId, int taskInstanceId) async {
  print('saveAudioFile called with tempFileName: $tempFileName');
  final String dirPath = await getApplicationDocumentsPath();
  final Directory mySubDir = Directory('$dirPath/Cognivoice');

  if (!await mySubDir.exists()) {
    await mySubDir.create(recursive: true);
  }

  final String formattedEvaluatorId = evaluatorId.toString().padLeft(2, '0');
  final String formattedParticipantId = participantId.toString().padLeft(2, '0');

  // Use DateFormat to format the date
  final String recordingDate = DateFormat('ddMMyyyy').format(DateTime.now());
  final String fileName = 'A${formattedEvaluatorId}_P${formattedParticipantId}_AT${taskInstanceId}_$recordingDate.aac';

  final String filePath = path.join(mySubDir.path, fileName);
  final File file = File(filePath);

  print('Saving audio file at: $filePath');
  await file.writeAsBytes(data.buffer.asUint8List());

  // Optional: delete the temporary file
  final File tempFile = File(path.join(mySubDir.path, tempFileName));
  if (await tempFile.exists()) {
    await tempFile.delete();
  }

  return filePath;
}

Future<String> getSecureStoragePath() async {
  final userDirectory = Platform.environment['USERPROFILE'] ?? '';
  final secureDir = Directory('$userDirectory\\.MySecureAppData');

  if (!await secureDir.exists()) {
    await secureDir.create();
  }

  return secureDir.path;
}
