import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';

class FileEncryptor {
  static final encrypt.Key key = Key.fromUtf8('12345678912345678912345678912345');
  static final encrypt.IV iv = IV.fromLength(16);

  static Future<void> encryptFile(File file, String destinationPath) async {
    final fileContents = await file.readAsBytes();
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encryptedBytes = encrypter.encryptBytes(fileContents, iv: iv).bytes;
    await File(destinationPath).writeAsBytes(encryptedBytes);
  }

  static Future<void> decryptFile(String encryptedFilePath, String destinationPath) async {
    final fileContents = await File(encryptedFilePath).readAsBytes();
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final decryptedBytes = encrypter.decryptBytes(encrypt.Encrypted(fileContents), iv: iv);
    await File(destinationPath).writeAsBytes(decryptedBytes);
  }

  static Future<String> encryptRecording(String originalPath) async {
    final encryptedFilePath = "$originalPath.enc";
    await encryptFile(File(originalPath), encryptedFilePath);
    await File(originalPath).delete();
    return encryptedFilePath;
  }
}


