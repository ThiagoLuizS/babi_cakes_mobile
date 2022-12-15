import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';

class GlobalService {

  static saveWelcome() {
    Prefs.setString("Welcome.prefs", "true");
  }

  static Future<bool> getWelcome() async {
    String json = await Prefs.getString("Welcome.prefs");

    if (json.isEmpty) {
      return false;
    }

    return json == "true";
  }
}