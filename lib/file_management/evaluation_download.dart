import 'dart:io';
import 'package:path/path.dart' as path;

Future<String> getDownloadsFolderPath() async {
  final String homeDirectory = Platform.environment['USERPROFILE'] ?? '';
  final String downloadsPath = path.join(homeDirectory, 'Downloads');
  return downloadsPath;
}

Future<void> createDownloadFolder(String evaluatorId, String participantId) async {
  final String downloadsPath = await getDownloadsFolderPath();

  // Ensure IDs are always two digits
  final String folderName = 'A${evaluatorId.padLeft(2, '0')}P${participantId.padLeft(2, '0')}';

  final String folderPath = path.join(downloadsPath, folderName);

  final directory = Directory(folderPath);
  if (!await directory.exists()) {
    await directory.create();
    print('Directory created: $folderPath');
  } else {
    print('Directory already exists: $folderPath');
  }
}
