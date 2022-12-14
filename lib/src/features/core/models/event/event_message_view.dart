import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';
import 'dart:convert' as convert;

class EventMessageView {

  late String title;
  late String description;


  EventMessageView(this.title, this.description);

  EventMessageView.fromJson(Map<String, dynamic> json) {
    title = json['titulo'];
    description = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = title;
    data['descricao'] = description;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("EventMessageView.prefs", json);
  }

  static Future<EventMessageView?> get() async {
    String json = await Prefs.getString("EventMessageView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    EventMessageView view = EventMessageView.fromJson(map);

    return view;
  }

  static void clear() {
    Prefs.setString("EventMessageView.prefs", "");
  }
}