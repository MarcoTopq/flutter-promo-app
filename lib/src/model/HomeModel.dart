import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// To parse this JSON data, do
//
//     final homeDetail = homeDetailFromJson(jsonString);

import 'dart:convert';

HomeDetail homeDetailFromJson(String str) => HomeDetail.fromJson(json.decode(str));

String homeDetailToJson(HomeDetail data) => json.encode(data.toJson());

class HomeDetail {
    List<Event> news;
    List<Event> event;
    List<Hot> hot;
    List<Hot> normal;
    Company company;
    Company contact;

    HomeDetail({
        this.news,
        this.event,
        this.hot,
        this.normal,
        this.company,
        this.contact,
    });

    factory HomeDetail.fromJson(Map<String, dynamic> json) => HomeDetail(
        news: List<Event>.from(json["news"].map((x) => Event.fromJson(x))),
        event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
        hot: List<Hot>.from(json["hot"].map((x) => Hot.fromJson(x))),
        normal: List<Hot>.from(json["normal"].map((x) => Hot.fromJson(x))),
        company: Company.fromJson(json["company"]),
        contact: Company.fromJson(json["contact"]),
    );

    Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "event": List<dynamic>.from(event.map((x) => x.toJson())),
        "hot": List<dynamic>.from(hot.map((x) => x.toJson())),
        "normal": List<dynamic>.from(normal.map((x) => x.toJson())),
        "company": company.toJson(),
        "contact": contact.toJson(),
    };
}

class Company {
    int id;
    String name;
    String logo;
    dynamic description;
    String profile;
    String email;
    dynamic phone;
    dynamic website;
    DateTime createdAt;
    DateTime updatedAt;

    Company({
        this.id,
        this.name,
        this.logo,
        this.description,
        this.profile,
        this.email,
        this.phone,
        this.website,
        this.createdAt,
        this.updatedAt,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        description: json["description"],
        profile: json["profile"],
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "description": description,
        "profile": profile,
        "email": email,
        "phone": phone,
        "website": website,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Event {
    int id;
    String title;
    String image;
    String url;
    int view;
    String createdAt;
    String createdBy;
    List<Category> category;

    Event({
        this.id,
        this.title,
        this.image,
        this.url,
        this.view,
        this.createdAt,
        this.createdBy,
        this.category,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
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

class Hot {
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

    Hot({
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

    factory Hot.fromJson(Map<String, dynamic> json) => Hot(
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

class HomeDetailModel with ChangeNotifier {
  List<HomeDetail> _listHomeDetail = [];
  List filteredHomeDetail = new List();
  List<HomeDetail> get listHomeDetail {
    return [..._listHomeDetail];
  }

  Future<void> fetchDataHomeDetail() async {
    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/home'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<HomeDetail> newData = [];

      var data = Map<String, dynamic>.from(convertData);
        newData.add(HomeDetail.fromJson(data));
      _listHomeDetail = newData;

      notifyListeners();
    }
  }
}