import 'package:babi_cakes_mobile/src/utils/general/prefs.dart';
import 'dart:convert' as convert;

class EventView {

  late int id;
  late String title;
  late String message;
  late String image;
  late DateTime dateSend;

  EventView(this.id, this.title, this.message, this.image, this.dateSend);

  EventView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
    dateSend = DateTime.parse(json['dateSend'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['image'] = image;
    data['dateSend'] = dateSend;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("EventView.prefs", json);
  }

  static Future<EventView?> get() async {
    String json = await Prefs.getString("EventView.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map<String, dynamic> map = convert.json.decode(json);

    EventView view = EventView.fromJson(map);

    return view;
  }
}