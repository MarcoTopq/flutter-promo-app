import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

UserHome userHomeFromJson(String str) => UserHome.fromJson(json.decode(str));

String userHomeToJson(UserHome data) => json.encode(data.toJson());

class UserHome {
  User user;
  List<Event> news;
  List<Event> event;
  List<Hot> hot;
  List<Hot> normal;
  Company company;
  Company contact;

  UserHome({
    this.user,
    this.news,
    this.event,
    this.hot,
    this.normal,
    this.company,
    this.contact,
  });

  factory UserHome.fromJson(Map<String, dynamic> json) => UserHome(
        user: User.fromJson(json["user"]),
        news: List<Event>.from(json["news"].map((x) => Event.fromJson(x))),
        event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
        hot: List<Hot>.from(json["hot"].map((x) => Hot.fromJson(x))),
        normal: List<Hot>.from(json["normal"].map((x) => Hot.fromJson(x))),
        company: Company.fromJson(json["company"]),
        contact: Company.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
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
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
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

class User {
  int id;
  String email;
  dynamic emailVerifiedAt;
  int roleId;
  DateTime createdAt;
  DateTime updatedAt;
  Employee employee;
  Role role;

  User({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.employee,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        employee: Employee.fromJson(json["employee"]),
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "employee": employee.toJson(),
        "role": role.toJson(),
      };
}

class Employee {
  int id;
  String name;
  String address;
  String phone;
  String avatar;
  int userId;
  String type;
  int distributorId;
  DateTime createdAt;
  DateTime updatedAt;
  Distributor distributor;

  Employee({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.avatar,
    this.userId,
    this.type,
    this.distributorId,
    this.createdAt,
    this.updatedAt,
    this.distributor,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        avatar: json["avatar"],
        userId: json["user_id"],
        type: json["type"],
        distributorId: json["distributor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        distributor: Distributor.fromJson(json["distributor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "avatar": avatar,
        "user_id": userId,
        "type": type,
        "distributor_id": distributorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "distributor": distributor.toJson(),
      };
}

class Distributor {
  int id;
  String name;
  String member;
  String address;
  String phone;
  String email;
  String website;
  String logo;
  DateTime createdAt;
  DateTime updatedAt;
  int loyalty;
  int reward;
  int coupon;
  int transaction;

  Distributor({
    this.id,
    this.name,
    this.member,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.loyalty,
    this.reward,
    this.coupon,
    this.transaction,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
        id: json["id"],
        name: json["name"],
        member: json["member"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        website: json["website"],
        logo: json["logo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        loyalty: json["loyalty"],
        reward: json["reward"],
        coupon: json["coupon"],
        transaction: json["transaction"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "member": member,
        "address": address,
        "phone": phone,
        "email": email,
        "website": website,
        "logo": logo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "loyalty": loyalty,
        "reward": reward,
        "coupon": coupon,
        "transaction": transaction,
      };
}

class Role {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Role({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserHomeModel with ChangeNotifier {
  List<UserHome> _listHomeDetail = [];
  List filteredHomeDetail = new List();
  List<UserHome> get listHomeDetail {
    return [..._listHomeDetail];
  }

  Future<void> fetchDataUserHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/user/home'),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<UserHome> newData = [];

      var data = Map<String, dynamic>.from(convertData);
      newData.add(UserHome.fromJson(data));
      _listHomeDetail = newData;

      notifyListeners();
    }
  }
}
