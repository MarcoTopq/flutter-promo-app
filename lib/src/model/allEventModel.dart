
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<AllEventDetail> allEventDetailFromJson(String str) => List<AllEventDetail>.from(json.decode(str).map((x) => AllEventDetail.fromJson(x)));

String allEventDetailToJson(List<AllEventDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllEventDetail {
    int id;
    String title;
    String image;
    String url;
    int view;
    String createdAt;
    String createdBy;
    List<Category> category;

    AllEventDetail({
        this.id,
        this.title,
        this.image,
        this.url,
        this.view,
        this.createdAt,
        this.createdBy,
        this.category,
    });

    factory AllEventDetail.fromJson(Map<String, dynamic> json) => AllEventDetail(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        url: json["url"],
        view: json["view"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "url": url,
        "view": view,
        "created_at": createdAt,
        "created_by": createdBy,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
    };
}

class Category {
    int id;
    String name;

    Category({
        this.id,
        this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class EventModel with ChangeNotifier {
  List<AllEventDetail> _listEvent = [];
  List filteredEvent = new List();
  List<AllEventDetail> get listEvent {
    return [..._listEvent];
  }

  Future<void> fetchDataEvent() async {
    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/event'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<AllEventDetail> newData = [];
      for (Map i in convertData) {
        newData.add(AllEventDetail.fromJson(i));
      }
      _listEvent = newData;
      notifyListeners();
    }
  }

}
