import 'dart:convert';

extension ResponseToJson on String {
  List<T> responseToJsonList<T>() {
    final list = jsonDecode(const Utf8Decoder().convert(codeUnits));

    assert(list is List<dynamic>, 'Json is not of List type');

    return list.cast<T>().toList();
  }

   List<T> responseToUtf8JsonList<T>() {
    final list = jsonDecode(const Utf8Decoder().convert(codeUnits));

    assert(list is List<dynamic>, 'Json is not of List type');

    return list.cast<T>().toList();
  }
}

extension Utf8JsonDecode on String {
  dynamic jsonDecodeUtf8() {
    return jsonDecode(const Utf8Decoder().convert(codeUnits));
  }
}