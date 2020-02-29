
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<AllNewsDetail> allNewsDetailFromJson(String str) => List<AllNewsDetail>.from(json.decode(str).map((x) => AllNewsDetail.fromJson(x)));

String allNewsDetailToJson(List<AllNewsDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllNewsDetail {
    int id;
    String title;
    String image;
    String url;
    int view;
    String createdAt;
    String createdBy;
    List<Category> category;

    AllNewsDetail({
        this.id,
        this.title,
        this.image,
        this.url,
        this.view,
        this.createdAt,
        this.createdBy,
        this.category,
    });

    factory AllNewsDetail.fromJson(Map<String, dynamic> json) => AllNewsDetail(
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

class NewsModel with ChangeNotifier {
  List<AllNewsDetail> _listNews = [];
  List filteredNews = new List();
  List<AllNewsDetail> get listNews {
    return [..._listNews];
  }

  Future<void> fetchDataNews() async {
    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/news'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<AllNewsDetail> newData = [];
      for (Map i in convertData) {
        newData.add(AllNewsDetail.fromJson(i));
      }
      _listNews = newData;
      notifyListeners();
    }
  }
  // }
}
