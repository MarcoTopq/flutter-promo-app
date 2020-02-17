// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  int id;
  String title;
  String image;
  String url;
  String createdAt;
  List<Category> category;

  Welcome({
    this.id,
    this.title,
    this.image,
    this.url,
    this.createdAt,
    this.category,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        url: json["url"],
        createdAt: json["created_at"],
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "url": url,
        "created_at": createdAt,
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

class NewsModel with ChangeNotifier {
  List<Welcome> _listNews = [];
  List filteredNews = new List();
  List<Welcome> get listNews {
    return [..._listNews];
  }

  Future<void> fetchDataNews() async {
    final response = await http.get(
        Uri.encodeFull('http://rpm.warnakaltim.com/rpm/public/api/news'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<Welcome> newData = [];
      for (Map i in convertData) {
        newData.add(Welcome.fromJson(i));
      }
      _listNews = newData;
      notifyListeners();
    }
  }
  // }
}
