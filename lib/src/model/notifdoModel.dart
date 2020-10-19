import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:warnakaltim/main.dart';

List<NotifDo> notifDoFromJson(String str) =>
    List<NotifDo>.from(json.decode(str).map((x) => NotifDo.fromJson(x)));

String notifDoToJson(List<NotifDo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotifDo {
  NotifDo({
    this.id,
    this.time,
    this.date,
    this.description,
    this.driver,
    this.estimate,
  });

  int id;
  String time;
  String date;
  String description;
  String driver;
  int estimate;

  factory NotifDo.fromJson(Map<String, dynamic> json) => NotifDo(
        id: json["id"],
        time: json["time"],
        date: json["date"],
        description: json["description"],
        driver: json["driver"] == null ? null : json["driver"],
        estimate: json["estimate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "date": date,
        "description": description,
        "driver": driver == null ? null : driver,
        "estimate": estimate,
      };
}

class NotifDoModel with ChangeNotifier {
  List<NotifDo> _listNotifdo = [];
  List filteredNotifdo = new List();
  List<NotifDo> get listNotifdo {
    return [..._listNotifdo];
  }

  Future<void> fetchDataNotifdo(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http
        .get(Uri.encodeFull(urls + '/api/notif/deliveryorder/' + id), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<NotifDo> newData = [];
      for (Map i in convertData) {
        newData.add(NotifDo.fromJson(i));
      }
      _listNotifdo = newData;
      notifyListeners();
    }
  }
  // }
}
