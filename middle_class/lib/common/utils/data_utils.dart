import 'package:middle_class/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return '$smIp/$value';
  }

  static listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }
}
