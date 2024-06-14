import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

abstract interface class Crypteable {
  String decrypt(String str);
  String encrypt(String str);
}

abstract class CrypteableImpl implements Crypteable {
  EncryptionData? _encryptionData;
  CrypteableImpl();
  void _getEncrypter() {
    if (_encryptionData != null) return;
    const key = '12345678912345678912345678912345';
    const iv = '1234567812345678';
    final a = Encrypter(AES(Key(Uint8List.fromList(key.codeUnits))));
    _encryptionData =
        EncryptionData(iv: IV(Uint8List.fromList(iv.codeUnits)), encrypter: a);
  }

  IV get _iv => _encryptionData!.iv;
  Encrypter get _encrypter => _encryptionData!.encrypter;
  @override
  String encrypt(String str) {
    _getEncrypter();
    final encrypted = _encrypter.encrypt(str, iv: _iv);
    return encrypted.base64;
  }

  @override
  String decrypt(String str) {
    _getEncrypter();
    final decrypted = _encrypter.decrypt64(str, iv: _iv);
    return decrypted;
  }
}

class EncryptionData {
  final IV iv;
  final Encrypter encrypter;
  EncryptionData({
    required this.iv,
    required this.encrypter,
  });
}
