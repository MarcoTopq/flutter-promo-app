import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// To parse this JSON data, do
//
//     final userHome = userHomeFromJson(jsonString);

import 'dart:convert';

UserHome userHomeFromJson(String str) => UserHome.fromJson(json.decode(str));

String userHomeToJson(UserHome data) => json.encode(data.toJson());

class UserHome {
    User user;
    List<Event> news;
    List<Event> event;
    List<Hot> hot;
    List<Hot> normal;
    List<Video> videos;
    Company company;
    Company contact;

    UserHome({
        this.user,
        this.news,
        this.event,
        this.hot,
        this.normal,
        this.videos,
        this.company,
        this.contact,
    });

    factory UserHome.fromJson(Map<String, dynamic> json) => UserHome(
        user: User.fromJson(json["user"]),
        news: List<Event>.from(json["news"].map((x) => Event.fromJson(x))),
        event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
        hot: List<Hot>.from(json["hot"].map((x) => Hot.fromJson(x))),
        normal: List<Hot>.from(json["normal"].map((x) => Hot.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        company: Company.fromJson(json["company"]),
        contact: Company.fromJson(json["contact"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
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
    int id;
    String name;
    dynamic description;
    String profile;
    String email;
    dynamic phone;
    dynamic website;
    DateTime createdAt;
    DateTime updatedAt;
    String profiledownload;

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
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
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

enum CreatedAt { THE_01_MARCH_2020 }

final createdAtValues = EnumValues({
    "01 March 2020": CreatedAt.THE_01_MARCH_2020
});

enum CreatedBy { ADMINISTRATOR }

final createdByValues = EnumValues({
    "administrator": CreatedBy.ADMINISTRATOR
});

class Hot {
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

final statusValues = EnumValues({
    "hot": Status.HOT,
    "normal": Status.NORMAL
});

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
    int reward;
    int coupon;
    int transaction;
    String chart;
    List<Transaction> transactions;
    List<Delivery> delivery;
    List<Coupon> coupons;
    List<Voucher> vouchers;

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
        this.coupon,
        this.transaction,
        this.chart,
        this.transactions,
        this.delivery,
        this.coupons,
        this.vouchers,
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
        coupon: json["coupon"],
        transaction: json["transaction"],
        chart: json["chart"],
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
        delivery: List<Delivery>.from(json["delivery"].map((x) => Delivery.fromJson(x))),
        coupons: List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
        vouchers: List<Voucher>.from(json["vouchers"].map((x) => Voucher.fromJson(x))),
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
        "coupon": coupon,
        "transaction": transaction,
        "chart": chart,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "delivery": List<dynamic>.from(delivery.map((x) => x.toJson())),
        "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
        "vouchers": List<dynamic>.from(vouchers.map((x) => x.toJson())),
    };
}

class Coupon {
    int id;
    String codeCoupon;
    int distributorId;
    DateTime createdAt;
    DateTime updatedAt;

    Coupon({
        this.id,
        this.codeCoupon,
        this.distributorId,
        this.createdAt,
        this.updatedAt,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        codeCoupon: json["code_coupon"],
        distributorId: json["distributor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code_coupon": codeCoupon,
        "distributor_id": distributorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
    Driver driver;

    Delivery({
        this.id,
        this.deliveryAt,
        this.distributorId,
        this.driverId,
        this.createdAt,
        this.updatedAt,
        this.deliveryDate,
        this.driver,
    });

    factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        deliveryAt: DateTime.parse(json["delivery_at"]),
        distributorId: json["distributor_id"],
        driverId: json["driver_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deliveryDate: json["delivery_date"],
        driver: Driver.fromJson(json["driver"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_at": deliveryAt.toIso8601String(),
        "distributor_id": distributorId,
        "driver_id": driverId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delivery_date": deliveryDate,
        "driver": driver.toJson(),
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

    Driver({
        this.id,
        this.name,
        this.address,
        this.phone,
        this.avatar,
        this.userId,
        this.createdAt,
        this.updatedAt,
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
    };
}

class Transaction {
    int id;
    int quantity;
    int total;
    DateTime billingDate;
    int distributorId;
    DateTime createdAt;
    DateTime updatedAt;
    String noSo;
    String date;

    Transaction({
        this.id,
        this.quantity,
        this.total,
        this.billingDate,
        this.distributorId,
        this.createdAt,
        this.updatedAt,
        this.noSo,
        this.date,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        quantity: json["quantity"],
        total: json["total"],
        billingDate: DateTime.parse(json["billing_date"]),
        distributorId: json["distributor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        noSo: json["no_so"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "total": total,
        "billing_date": billingDate.toIso8601String(),
        "distributor_id": distributorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "no_so": noSo,
        "date": date,
    };
}

class Voucher {
    int id;
    dynamic codeVoucher;
    int promoId;
    int distributorId;
    DateTime createdAt;
    DateTime updatedAt;

    Voucher({
        this.id,
        this.codeVoucher,
        this.promoId,
        this.distributorId,
        this.createdAt,
        this.updatedAt,
    });

    factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json["id"],
        codeVoucher: json["code_voucher"],
        promoId: json["promo_id"],
        distributorId: json["distributor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code_voucher": codeVoucher,
        "promo_id": promoId,
        "distributor_id": distributorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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

class Video {
    int id;
    String title;
    String url;
    String image;
    String createdAt;

    Video({
        this.id,
        this.title,
        this.url,
        this.image,
        this.createdAt,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        image: json["image"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "image": image,
        "created_at": createdAt,
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
