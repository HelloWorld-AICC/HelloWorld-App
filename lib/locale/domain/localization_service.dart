import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalizationService {
  String getTranslatedText(String key) {
    return key.tr();
  }

  List<String> getTranslatedTexts(List<String> keys) {
    return keys.map((key) => key.tr()).toList();
  }

// String _findValue(dynamic json, String key) {
//   if (json is Map) {
//     for (var k in json.keys) {
//       if (k == key) {
//         return json[k] is String ? json[k].tr() : '';
//       } else if (json[k] is Map) {
//         String result = _findValue(json[k], key);
//         if (result.isNotEmpty) {
//           return result;
//         }
//       }
//     }
//   }
//   return '';
// }
}
