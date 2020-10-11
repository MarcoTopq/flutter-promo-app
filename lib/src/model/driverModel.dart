import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

DriverPerson driverPersonFromJson(String str) =>
    DriverPerson.fromJson(json.decode(str));

String driverPersonToJson(DriverPerson data) => json.encode(data.toJson());

class DriverPerson {
  int id;
  String email;
  dynamic emailVerifiedAt;
  int roleId;
  DateTime createdAt;
  DateTime updatedAt;
  Driver driver;
  Role role;

  DriverPerson({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.role,
  });

  factory DriverPerson.fromJson(Map<String, dynamic> json) => DriverPerson(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        driver: Driver.fromJson(json["driver"]),
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "driver": driver.toJson(),
        "role": role.toJson(),
      };
}

class Driver {
  int id;
  String name;
  String address;
  String phone;
  String avatar;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Delivery> delivery;

  Driver({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.avatar,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.delivery,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        avatar: json["avatar"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        delivery: List<Delivery>.from(
            json["delivery"].map((x) => Delivery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "avatar": avatar,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delivery": List<dynamic>.from(delivery.map((x) => x.toJson())),
      };
}

class Delivery {
  int id;
  DateTime deliveryAt;
  int distributorId;
  int driverId;
  DateTime createdAt;
  DateTime updatedAt;
  String deliveryDate;
  Distributor distributor;

  Delivery({
    this.id,
    this.deliveryAt,
    this.distributorId,
    this.driverId,
    this.createdAt,
    this.updatedAt,
    this.deliveryDate,
    this.distributor,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        deliveryAt: DateTime.parse(json["delivery_at"]),
        distributorId: json["distributor_id"],
        driverId: json["driver_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deliveryDate: json["delivery_date"],
        distributor: Distributor.fromJson(json["distributor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_at": deliveryAt.toIso8601String(),
        "distributor_id": distributorId,
        "driver_id": driverId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delivery_date": deliveryDate,
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
  int reward;

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
    this.reward,
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
        reward: json["reward"],
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
        "reward": reward,
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

class DriverPersonModel with ChangeNotifier {
  List<DriverPerson> _listDriverPerson = [];
  List filteredDriverPerson = new List();
  List<DriverPerson> get listDriverPerson {
    return [..._listDriverPerson];
  }

  Future<void> fetchDataDriverPerson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http.get(Uri.encodeFull(urls + '/api/me'), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<DriverPerson> newData = [];

      var data = Map<String, dynamic>.from(convertData);
      newData.add(DriverPerson.fromJson(data));
      _listDriverPerson = newData;

      notifyListeners();
    }
  }
}
