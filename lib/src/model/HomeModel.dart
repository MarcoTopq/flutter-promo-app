import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Home homeFromJson(String str) => Home.fromJson(json.decode(str));

String homeToJson(Home data) => json.encode(data.toJson());

class Home {
    List<Event> news;
    List<Event> event;
    List<Promo> promo;

    Home({
        this.news,
        this.event,
        this.promo,
    });

    factory Home.fromJson(Map<String, dynamic> json) => Home(
        news: List<Event>.from(json["news"].map((x) => Event.fromJson(x))),
        event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
        promo: List<Promo>.from(json["promo"].map((x) => Promo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "event": List<dynamic>.from(event.map((x) => x.toJson())),
        "promo": List<dynamic>.from(promo.map((x) => x.toJson())),
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

class Promo {
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

    Promo({
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

    factory Promo.fromJson(Map<String, dynamic> json) => Promo(
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

class HomeModel with ChangeNotifier {
  List<Home> _listHome = [];
  List filteredHome = new List();
  List<Home> get listHome {
    return [..._listHome];
  }

  Future<void> fetchDataHome() async {
    final response = await http.get(
        Uri.encodeFull('http://rpm.warnakaltim.com/rpm/public/api/home'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<Home> newData = [];

      var data = Map<String, dynamic>.from(convertData);
        newData.add(Home.fromJson(data));
      _listHome = newData;

      notifyListeners();
    }
  }
}