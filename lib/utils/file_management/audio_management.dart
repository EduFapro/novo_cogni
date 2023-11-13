import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<String> getApplicationDocumentsPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String> getTemporaryDirectoryPath() async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

Future<void> saveAudioFile(ByteData data, String fileName) async {
  final String dirPath = await getSecureStoragePath();
  final mySubDir = Directory('$dirPath/MyAudioFiles');
  if (!await mySubDir.exists()) {
    await mySubDir.create(recursive: true);
  }
  final filePath = p.join(mySubDir.path, fileName);
  final file = File(filePath);
  await file.writeAsBytes(data.buffer.asUint8List());
}

Future<String> getSecureStoragePath() async {
  final userDirectory = Platform.environment['USERPROFILE'] ?? '';
  final secureDir = Directory('$userDirectory\\.MySecureAppData'); // Using a dot to make it hidden

  if (!await secureDir.exists()) {
    await secureDir.create();
  }

  return secureDir.path;
}

