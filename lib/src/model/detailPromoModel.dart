import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:warnakaltim/main.dart';

DetailPromoClass detailPromoClassFromJson(String str) =>
    DetailPromoClass.fromJson(json.decode(str));

String detailPromoClassToJson(DetailPromoClass data) =>
    json.encode(data.toJson());

class DetailPromoClass {
  int id;
  String title;
  String image;
  String description;
  String terms;
  int point;
  int total;
  int view;
  String status;
  String createdAt;
  String createdBy;

  DetailPromoClass({
    this.id,
    this.title,
    this.image,
    this.description,
    this.terms,
    this.point,
    this.total,
    this.view,
    this.status,
    this.createdAt,
    this.createdBy,
  });

  factory DetailPromoClass.fromJson(Map<String, dynamic> json) =>
      DetailPromoClass(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        terms: json["terms"],
        point: json["point"],
        total: json["total"],
        view: json["view"],
        status: json["status"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "terms": terms,
        "point": point,
        "total": total,
        "view": view,
        "status": status,
        "created_at": createdAt,
        "created_by": createdBy,
      };
}

class DetailPromoModel with ChangeNotifier {
  List<DetailPromoClass> _listDetailPromo = [];
  List filteredDetailPromo = new List();
  List<DetailPromoClass> get listDetailPromo {
    return [..._listDetailPromo];
  }

  Future<void> fetchDataDetailPromo(String id) async {
    final response = await http.get(Uri.encodeFull(urls + '/api/promo/' + id),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<DetailPromoClass> newData = [];

      var data = Map<String, dynamic>.from(convertData);
      newData.add(DetailPromoClass.fromJson(data));
      _listDetailPromo = newData;

      notifyListeners();
    }
  }
}
