import 'dart:convert';

import 'package:middle_class/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return '$smIp/$value';
  }

  static listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);
    return encoded;
  }

  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }
}
