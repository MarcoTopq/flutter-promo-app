import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

// To parse this JSON data, do
//
//     final distributorDetail = distributorDetailFromJson(jsonString);

import 'dart:convert';

DistributorDetail distributorDetailFromJson(String str) =>
    DistributorDetail.fromJson(json.decode(str));

String distributorDetailToJson(DistributorDetail data) =>
    json.encode(data.toJson());

class DistributorDetail {
  DistributorDetail({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.role,
  });

  int id;
  String email;
  dynamic emailVerifiedAt;
  int roleId;
  String fcmToken;
  DateTime createdAt;
  DateTime updatedAt;
  Customer customer;
  Role role;

  factory DistributorDetail.fromJson(Map<String, dynamic> json) =>
      DistributorDetail(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        fcmToken: json["fcm_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customer: Customer.fromJson(json["customer"]),
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "fcm_token": fcmToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "customer": customer.toJson(),
        "role": role.toJson(),
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.member,
    this.address,
    this.npwp,
    this.phone,
    this.website,
    this.logo,
    this.userId,
    this.agenId,
    this.reward,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.agen,
  });

  int id;
  String name;
  String member;
  String address;
  String npwp;
  String phone;
  String website;
  String logo;
  int userId;
  int agenId;
  int reward;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;
  Agen agen;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        member: json["member"],
        address: json["address"],
        npwp: json["npwp"],
        phone: json["phone"],
        website: json["website"],
        logo: json["logo"],
        userId: json["user_id"],
        agenId: json["agen_id"],
        reward: json["reward"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        avatar: json["avatar"],
        agen: Agen.fromJson(json["agen"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "member": member,
        "address": address,
        "npwp": npwp,
        "phone": phone,
        "website": website,
        "logo": logo,
        "user_id": userId,
        "agen_id": agenId,
        "reward": reward,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "avatar": avatar,
        "agen": agen.toJson(),
      };
}

class Agen {
  Agen({
    this.id,
    this.name,
    this.address,
    this.npwp,
    this.phone,
    this.website,
    this.logo,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String address;
  String npwp;
  String phone;
  String website;
  String logo;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Agen.fromJson(Map<String, dynamic> json) => Agen(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        npwp: json["npwp"],
        phone: json["phone"],
        website: json["website"],
        logo: json["logo"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "npwp": npwp,
        "phone": phone,
        "website": website,
        "logo": logo,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Role {
  Role({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

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

class DistributorDetailModel with ChangeNotifier {
  List<DistributorDetail> _listDistributorDetail = [];
  List filteredDistributorDetail = new List();
  List<DistributorDetail> get listDistributorDetail {
    return [..._listDistributorDetail];
  }

  Future<void> fetchDataDistributorDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http.get(Uri.encodeFull(urls + '/api/me'), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<DistributorDetail> newData = [];

      var data = Map<String, dynamic>.from(convertData);
      newData.add(DistributorDetail.fromJson(data));
      _listDistributorDetail = newData;

      notifyListeners();
    }
  }
}
