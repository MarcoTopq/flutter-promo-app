import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


DistributorDetail distributorDetailFromJson(String str) => DistributorDetail.fromJson(json.decode(str));

String distributorDetailToJson(DistributorDetail data) => json.encode(data.toJson());

class DistributorDetail {
    int id;
    String email;
    dynamic emailVerifiedAt;
    int roleId;
    DateTime createdAt;
    DateTime updatedAt;
    Employee employee;
    Role role;

    DistributorDetail({
        this.id,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.employee,
        this.role,
    });

    factory DistributorDetail.fromJson(Map<String, dynamic> json) => DistributorDetail(
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


class DistributorDetailModel with ChangeNotifier {
  List<DistributorDetail> _listDistributorDetail = [];
  List filteredDistributorDetail = new List();
  List<DistributorDetail> get listDistributorDetail {
    return [..._listDistributorDetail];
  }

  Future<void> fetchDataDistributorDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http
        .get(Uri.encodeFull('http://rpm.kantordesa.com/api/me'), headers: {
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
