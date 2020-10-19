import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:warnakaltim/main.dart';

UserHome userHomeFromJson(String str) => UserHome.fromJson(json.decode(str));

String userHomeToJson(UserHome data) => json.encode(data.toJson());

class UserHome {
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

  User user;
  List<Event> news;
  List<Event> event;
  List<Hot> hot;
  List<Hot> normal;
  List<Video> videos;
  Company company;
  Company contact;

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
  AtedAt createdAt;
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
        createdAt: atedAtValues.map[json["created_at"]],
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
        "created_at": atedAtValues.reverse[createdAt],
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

enum AtedAt { THE_15_OCTOBER_2020, THE_16_OCTOBER_2020 }

final atedAtValues = EnumValues({
  "15 October 2020": AtedAt.THE_15_OCTOBER_2020,
  "16 October 2020": AtedAt.THE_16_OCTOBER_2020
});

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
  AtedAt createdAt;
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
        createdAt: atedAtValues.map[json["created_at"]],
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
        "created_at": atedAtValues.reverse[createdAt],
        "created_by": createdByValues.reverse[createdBy],
      };
}

enum Status { HOT, NORMAL }

final statusValues = EnumValues({"hot": Status.HOT, "normal": Status.NORMAL});

class User {
  User({
    this.id,
    this.email,
    this.roleId,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  int id;
  String email;
  int roleId;
  String fcmToken;
  AtedAt createdAt;
  AtedAt updatedAt;
  Customer customer;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        roleId: json["role_id"],
        fcmToken: json["fcm_token"],
        createdAt: atedAtValues.map[json["created_at"]],
        updatedAt: atedAtValues.map[json["updated_at"]],
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role_id": roleId,
        "fcm_token": fcmToken,
        "created_at": atedAtValues.reverse[createdAt],
        "updated_at": atedAtValues.reverse[updatedAt],
        "customer": customer.toJson(),
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.address,
    this.npwp,
    this.phone,
    this.website,
    this.reward,
    this.logo,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.coupon,
    this.sumDeliveryOrder,
    this.salesOrders,
    this.vouchers,
  });

  int id;
  String name;
  String address;
  String npwp;
  String phone;
  String website;
  int reward;
  String logo;
  int userId;
  AtedAt createdAt;
  AtedAt updatedAt;
  int coupon;
  int sumDeliveryOrder;
  List<SalesOrder> salesOrders;
  List<dynamic> vouchers;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        npwp: json["npwp"],
        phone: json["phone"],
        website: json["website"],
        reward: json["reward"],
        logo: json["logo"],
        userId: json["user_id"],
        createdAt: atedAtValues.map[json["created_at"]],
        updatedAt: atedAtValues.map[json["updated_at"]],
        coupon: json["coupon"],
        sumDeliveryOrder: json["sum_delivery_order"],
        salesOrders: List<SalesOrder>.from(
            json["sales_orders"].map((x) => SalesOrder.fromJson(x))),
        vouchers: List<dynamic>.from(json["vouchers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "address": address,
        "npwp": npwp,
        "phone": phone,
        "website": website,
        "reward": reward,
        "logo": logo,
        "user_id": userId,
        "created_at": atedAtValues.reverse[createdAt],
        "updated_at": atedAtValues.reverse[updatedAt],
        "coupon": coupon,
        "sum_delivery_order": sumDeliveryOrder,
        "sales_orders": List<dynamic>.from(salesOrders.map((x) => x.toJson())),
        "vouchers": List<dynamic>.from(vouchers.map((x) => x)),
      };
}

enum Name { PT_TITU_PERKASA_ENERGI }

final nameValues =
    EnumValues({"PT. Titu Perkasa Energi": Name.PT_TITU_PERKASA_ENERGI});

class SalesOrder {
  SalesOrder({
    this.id,
    this.salesOrderNumber,
    this.customer,
    this.customerId,
    this.agenId,
    this.agen,
    this.createdAt,
    this.updatedAt,
    this.deliveryOrders,
  });

  int id;
  String salesOrderNumber;
  Name customer;
  int customerId;
  int agenId;
  Agen agen;
  AtedAt createdAt;
  AtedAt updatedAt;
  List<DeliveryOrder> deliveryOrders;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        id: json["id"],
        salesOrderNumber: json["sales_order_number"],
        customer: nameValues.map[json["customer"]],
        customerId: json["customer_id"],
        agenId: json["agen_id"],
        agen: agenValues.map[json["agen"]],
        createdAt: atedAtValues.map[json["created_at"]],
        updatedAt: atedAtValues.map[json["updated_at"]],
        deliveryOrders: List<DeliveryOrder>.from(
            json["delivery_orders"].map((x) => DeliveryOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sales_order_number": salesOrderNumber,
        "customer": nameValues.reverse[customer],
        "customer_id": customerId,
        "agen_id": agenId,
        "agen": agenValues.reverse[agen],
        "created_at": atedAtValues.reverse[createdAt],
        "updated_at": atedAtValues.reverse[updatedAt],
        "delivery_orders":
            List<dynamic>.from(deliveryOrders.map((x) => x.toJson())),
      };
}

enum Agen { PT_TITU_PERKASA_ENERGI, PT_SUMBER_HARAPAN_MULIA }

final agenValues = EnumValues({
  "PT. Sumber Harapan Mulia": Agen.PT_SUMBER_HARAPAN_MULIA,
  "PT. TITU PERKASA ENERGI": Agen.PT_TITU_PERKASA_ENERGI
});

class DeliveryOrder {
  DeliveryOrder({
    this.id,
    this.deliveryOrderNumber,
    this.effectiveDateStart,
    this.effectiveDateEnd,
    this.product,
    this.quantity,
    this.shippedWith,
    this.shippedVia,
    this.noVehicles,
    this.kmStart,
    this.kmEnd,
    this.sgMeter,
    this.topSeal,
    this.bottomSeal,
    this.temperature,
    this.departureTime,
    this.arrivalTime,
    this.unloadingStartTime,
    this.unloadingEndTime,
    this.departureTimeDepot,
    this.status,
    this.salesOrderId,
    this.driver,
    this.bast,
  });

  int id;
  String deliveryOrderNumber;
  String effectiveDateStart;
  String effectiveDateEnd;
  String product;
  int quantity;
  String shippedWith;
  String shippedVia;
  String noVehicles;
  int kmStart;
  String kmEnd;
  String sgMeter;
  String topSeal;
  String bottomSeal;
  String temperature;
  String departureTime;
  String arrivalTime;
  dynamic unloadingStartTime;
  DateTime unloadingEndTime;
  dynamic departureTimeDepot;
  String status;
  int salesOrderId;
  Driver driver;
  String bast;

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) => DeliveryOrder(
        id: json["id"],
        deliveryOrderNumber: json["delivery_order_number"],
        effectiveDateStart: json["effective_date_start"],
        effectiveDateEnd: json["effective_date_end"],
        product: json["product"],
        quantity: json["quantity"],
        shippedWith: json["shipped_with"],
        shippedVia: json["shipped_via"],
        noVehicles: json["no_vehicles"],
        kmStart: json["km_start"],
        kmEnd: json["km_end"],
        sgMeter: json["sg_meter"],
        topSeal: json["top_seal"],
        bottomSeal: json["bottom_seal"],
        temperature: json["temperature"],
        departureTime:
            json["departure_time"] == null ? null : json["departure_time"],
        arrivalTime: json["arrival_time"] == null ? null : json["arrival_time"],
        unloadingStartTime: json["unloading_start_time"],
        unloadingEndTime: json["unloading_end_time"] == null
            ? null
            : DateTime.parse(json["unloading_end_time"]),
        departureTimeDepot: json["departure_time_depot"],
        status: json["status"],
        salesOrderId: json["sales_order_id"],
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        bast: json["bast"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_order_number": deliveryOrderNumber,
        "effective_date_start": effectiveDateStart,
        "effective_date_end": effectiveDateEnd,
        "product": product,
        "quantity": quantity,
        "shipped_with": shippedWith,
        "shipped_via": shippedVia,
        "no_vehicles": noVehicles,
        "km_start": kmStart,
        "km_end": kmEnd,
        "sg_meter": sgMeter,
        "top_seal": topSeal,
        "bottom_seal": bottomSeal,
        "temperature": temperature,
        "departure_time": departureTime == null ? null : departureTime,
        "arrival_time": arrivalTime == null ? null : arrivalTime,
        "unloading_start_time": unloadingStartTime,
        "unloading_end_time": unloadingEndTime == null
            ? null
            : unloadingEndTime.toIso8601String(),
        "departure_time_depot": departureTimeDepot,
        "status": status,
        "sales_order_id": salesOrderId,
        "driver": driver == null ? null : driver.toJson(),
        "bast": bast,
      };
}

class Driver {
  Driver({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.avatar,
    this.route,
    this.userId,
    this.agenId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String address;
  String phone;
  String avatar;
  int route;
  int userId;
  int agenId;
  AtedAt createdAt;
  AtedAt updatedAt;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        avatar: json["avatar"],
        route: json["route"],
        userId: json["user_id"],
        agenId: json["agen_id"],
        createdAt: atedAtValues.map[json["created_at"]],
        updatedAt: atedAtValues.map[json["updated_at"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "avatar": avatar,
        "route": route,
        "user_id": userId,
        "agen_id": agenId,
        "created_at": atedAtValues.reverse[createdAt],
        "updated_at": atedAtValues.reverse[updatedAt],
      };
}

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
  AtedAt createdAt;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        url: json["url"],
        createdAt: atedAtValues.map[json["created_at"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "url": url,
        "created_at": atedAtValues.reverse[createdAt],
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
    final response = await http.get(Uri.encodeFull(urls + '/api/user/home'),
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
