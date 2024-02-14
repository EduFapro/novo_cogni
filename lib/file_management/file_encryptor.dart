import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;

class FileEncryptor {
  final encrypt.Key key;
  final encrypt.IV iv;

  FileEncryptor(this.key, this.iv);

  Future<void> encryptFile(File file, String destinationPath) async {
    final fileContents = await file.readAsBytes();
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encryptedBytes = encrypter.encryptBytes(fileContents, iv: iv).bytes;
    await File(destinationPath).writeAsBytes(encryptedBytes);
  }

  Future<void> decryptFile(String encryptedFilePath, String destinationPath) async {
    final fileContents = await File(encryptedFilePath).readAsBytes();
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decryptedBytes = encrypter.decryptBytes(encrypt.Encrypted(fileContents), iv: iv);
    await File(destinationPath).writeAsBytes(decryptedBytes);
  }
}
