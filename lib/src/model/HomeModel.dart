import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:warnakaltim/main.dart';

HomeDetail homeDetailFromJson(String str) =>
    HomeDetail.fromJson(json.decode(str));

String homeDetailToJson(HomeDetail data) => json.encode(data.toJson());

class HomeDetail {
  HomeDetail({
    this.news,
    this.event,
    this.hot,
    this.normal,
    this.videos,
    this.company,
    this.contact,
  });

  List<Event> news;
  List<Event> event;
  List<Hot> hot;
  List<Hot> normal;
  List<Video> videos;
  Company company;
  Company contact;

  factory HomeDetail.fromJson(Map<String, dynamic> json) => HomeDetail(
        news: List<Event>.from(json["news"].map((x) => Event.fromJson(x))),
        event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
        hot: List<Hot>.from(json["hot"].map((x) => Hot.fromJson(x))),
        normal: List<Hot>.from(json["normal"].map((x) => Hot.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        company: Company.fromJson(json["company"]),
        contact: Company.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "event": List<dynamic>.from(event.map((x) => x.toJson())),
        "hot": List<dynamic>.from(hot.map((x) => x.toJson())),
        "normal": List<dynamic>.from(normal.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "company": company.toJson(),
        "contact": contact.toJson(),
      };
}

class Company {
  Company({
    this.id,
    this.name,
    this.description,
    this.profile,
    this.email,
    this.phone,
    this.website,
    this.createdAt,
    this.updatedAt,
    this.profiledownload,
  });

  int id;
  String name;
  dynamic description;
  String profile;
  String email;
  String phone;
  String website;
  DateTime createdAt;
  DateTime updatedAt;
  String profiledownload;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        profile: json["profile"],
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profiledownload: json["profiledownload"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "profile": profile,
        "email": email,
        "phone": phone,
        "website": website,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "profiledownload": profiledownload,
      };
}

class Event {
  Event({
    this.id,
    this.title,
    this.image,
    this.url,
    this.view,
    this.start,
    this.end,
    this.createdAt,
    this.createdBy,
    this.category,
  });

  int id;
  String title;
  String image;
  String url;
  int view;
  String start;
  String end;
  CreatedAt createdAt;
  CreatedBy createdBy;
  List<Category> category;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        url: json["url"],
        view: json["view"],
        start: json["start"] == null ? null : json["start"],
        end: json["end"] == null ? null : json["end"],
        createdAt: createdAtValues.map[json["created_at"]],
        createdBy: createdByValues.map[json["created_by"]],
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "url": url,
        "view": view,
        "start": start == null ? null : start,
        "end": end == null ? null : end,
        "created_at": createdAtValues.reverse[createdAt],
        "created_by": createdByValues.reverse[createdBy],
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum CreatedAt { THE_15_OCTOBER_2020 }

final createdAtValues =
    EnumValues({"15 October 2020": CreatedAt.THE_15_OCTOBER_2020});

enum CreatedBy { ADMINISTRATOR }

final createdByValues = EnumValues({"Administrator": CreatedBy.ADMINISTRATOR});

class Hot {
  Hot({
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

  int id;
  String title;
  String image;
  String description;
  String terms;
  int point;
  int total;
  int view;
  Status status;
  CreatedAt createdAt;
  CreatedBy createdBy;

  factory Hot.fromJson(Map<String, dynamic> json) => Hot(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        terms: json["terms"],
        point: json["point"],
        total: json["total"],
        view: json["view"],
        status: statusValues.map[json["status"]],
        createdAt: createdAtValues.map[json["created_at"]],
        createdBy: createdByValues.map[json["created_by"]],
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
        "status": statusValues.reverse[status],
        "created_at": createdAtValues.reverse[createdAt],
        "created_by": createdByValues.reverse[createdBy],
      };
}

enum Status { HOT, NORMAL }

final statusValues = EnumValues({"hot": Status.HOT, "normal": Status.NORMAL});

class Video {
  Video({
    this.id,
    this.title,
    this.image,
    this.url,
    this.createdAt,
  });

  int id;
  String title;
  String image;
  String url;
  CreatedAt createdAt;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        url: json["url"],
        createdAt: createdAtValues.map[json["created_at"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "url": url,
        "created_at": createdAtValues.reverse[createdAt],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class HomeDetailModel with ChangeNotifier {
  List<HomeDetail> _listHomeDetail = [];
  List filteredHomeDetail = new List();
  List<HomeDetail> get listHomeDetail {
    return [..._listHomeDetail];
  }

  Future<void> fetchDataHomeDetail() async {
    final response = await http.get(Uri.encodeFull(urls + '/api/home'),
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
