import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<AllPromoClass> allPromoClassFromJson(String str) => List<AllPromoClass>.from(json.decode(str).map((x) => AllPromoClass.fromJson(x)));

String allPromoClassToJson(List<AllPromoClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPromoClass {
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

    AllPromoClass({
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

    factory AllPromoClass.fromJson(Map<String, dynamic> json) => AllPromoClass(
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

class AllPromoModel with ChangeNotifier {
  List<AllPromoClass> _listAllPromo = [];
  List filteredAllPromo = new List();
  List<AllPromoClass> get listAllPromo {
    return [..._listAllPromo];
  }

  Future<void> fetchDataAllPromo() async {
    final response = await http.get(
        Uri.encodeFull('http://rpm.warnakaltim.com/rpm/public/api/promo'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<AllPromoClass> newData = [];

      // var data = Map<String, dynamic>.from(convertData);
      //   newData.add(AllPromoClass.fromJson(data));

      for (Map i in convertData) {
        newData.add(AllPromoClass.fromJson(i));
      }
      _listAllPromo = newData;

      notifyListeners();
    }
  }
}