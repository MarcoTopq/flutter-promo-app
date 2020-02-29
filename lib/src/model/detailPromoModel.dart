import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

DetailPromoClass detailPromoClassFromJson(String str) => DetailPromoClass.fromJson(json.decode(str));

String detailPromoClassToJson(DetailPromoClass data) => json.encode(data.toJson());

class DetailPromoClass {
    int id;
    String title;
    String image;
    String description;
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
        this.point,
        this.total,
        this.view,
        this.status,
        this.createdAt,
        this.createdBy,
    });

    factory DetailPromoClass.fromJson(Map<String, dynamic> json) => DetailPromoClass(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
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
    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/promo/'+id),
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