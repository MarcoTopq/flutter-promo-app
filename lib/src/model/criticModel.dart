import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

// To parse this JSON data, do
//
//     final criticDetail = criticDetailFromJson(jsonString);

import 'dart:convert';

List<CriticDetail> criticDetailFromJson(String str) => List<CriticDetail>.from(json.decode(str).map((x) => CriticDetail.fromJson(x)));

String criticDetailToJson(List<CriticDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CriticDetail {
    CriticDetail({
        this.id,
        this.criticsSuggestion,
        this.service,
        this.rating,
        this.deliveryOrderNumber,
    });

    int id;
    dynamic criticsSuggestion;
    dynamic service;
    int rating;
    String deliveryOrderNumber;

    factory CriticDetail.fromJson(Map<String, dynamic> json) => CriticDetail(
        id: json["id"],
        criticsSuggestion: json["critics_suggestion"],
        service: json["service"],
        rating: json["rating"],
        deliveryOrderNumber: json["delivery_order_number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "critics_suggestion": criticsSuggestion,
        "service": service,
        "rating": rating,
        "delivery_order_number": deliveryOrderNumber,
    };
}


class CriticDetailModel with ChangeNotifier {
  List<CriticDetail> _listCritic = [];
  List filteredCritic = new List();
  List<CriticDetail> get listCritic {
    return [..._listCritic];
  }

  Future<void> fetchDataCritic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http
        .get(Uri.encodeFull(urls + '/api/agen/critics'), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<CriticDetail> newData = [];
      for (Map i in convertData) {
        newData.add(CriticDetail.fromJson(i));
      }
      _listCritic = newData;
      notifyListeners();
    }
  }
  // }
}
