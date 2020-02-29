import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<AllPromoHotClass> allPromoHotClassFromJson(String str) => List<AllPromoHotClass>.from(json.decode(str).map((x) => AllPromoHotClass.fromJson(x)));

String allPromoHotClassToJson(List<AllPromoHotClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPromoHotClass {
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

    AllPromoHotClass({
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

    factory AllPromoHotClass.fromJson(Map<String, dynamic> json) => AllPromoHotClass(
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

class AllHotPromoModel with ChangeNotifier {
  List<AllPromoHotClass> _listAllHotPromo = [];
  List filteredAllPromo = new List();
  List<AllPromoHotClass> get listAllHotPromo {
    return [..._listAllHotPromo];
  }

  Future<void> fetchDataAllHotPromo() async {
    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/promo/hot'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<AllPromoHotClass> newData = [];

      // var data = Map<String, dynamic>.from(convertData);
      //   newData.add(AllPromoHotClass.fromJson(data));

      for (Map i in convertData) {
        newData.add(AllPromoHotClass.fromJson(i));
      }
      _listAllHotPromo = newData;

      notifyListeners();
    }
  }
}