import 'dart:convert';

import 'package:xxtea/xxtea.dart';

class _XXTeaEncoder extends Converter<Map<String, dynamic>, String> {
  final String key;

  _XXTeaEncoder(this.key);

  @override
  String convert(Map<String, dynamic> input) =>
      xxtea.encryptToString(json.encode(input), key)!;
}

class _XXTeaDecoder extends Converter<String, Map<String, dynamic>> {
  final String key;

  _XXTeaDecoder(this.key);

  @override
  Map<String, dynamic> convert(String input) {
    var result = json.decode(xxtea.decryptToString(input, key)!);
    if (result is Map) {
      return result.cast<String, dynamic>();
    }
    throw FormatException('invalid input $input');
  }
}

/// Simple encryption codec using xxtea
/// It requires a password to encrypt/decrypt the data
class _XXTeaCodec extends Codec<Map<String, dynamic>, String> {
  late _XXTeaEncoder _encoder;
  late _XXTeaDecoder _decoder;

  /// A non null [password] to use for the encryption/decryption
  _XXTeaCodec(String password) {
    _encoder = _XXTeaEncoder(password);
    _decoder = _XXTeaDecoder(password);
  }

  @override
  Converter<String, Map<String, dynamic>> get decoder => _decoder;

  @override
  Converter<Map<String, dynamic>, String> get encoder => _encoder;
}