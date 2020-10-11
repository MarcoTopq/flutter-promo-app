import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:warnakaltim/main.dart';

DriverHome driverHomeFromJson(String str) =>
    DriverHome.fromJson(json.decode(str));

String driverHomeToJson(DriverHome data) => json.encode(data.toJson());

class DriverHome {
  DriverHome({
    this.user,
  });

  User user;

  factory DriverHome.fromJson(Map<String, dynamic> json) => DriverHome(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.email,
    this.roleId,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.agen,
    this.readyDeliveryOrder,
    this.deliveryOrders,
  });

  int id;
  String email;
  int roleId;
  String fcmToken;
  String createdAt;
  String updatedAt;
  Driver driver;
  Agen agen;
  List<DeliveryOrder> readyDeliveryOrder;
  List<DeliveryOrder> deliveryOrders;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        roleId: json["role_id"],
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        driver: Driver.fromJson(json["driver"]),
        agen: Agen.fromJson(json["agen"]),
        readyDeliveryOrder: List<DeliveryOrder>.from(
            json["ready_delivery_order"].map((x) => DeliveryOrder.fromJson(x))),
        deliveryOrders: List<DeliveryOrder>.from(
            json["delivery_orders"].map((x) => DeliveryOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role_id": roleId,
        "fcm_token": fcmToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "driver": driver.toJson(),
        "agen": agen.toJson(),
        "ready_delivery_order":
            List<dynamic>.from(readyDeliveryOrder.map((x) => x.toJson())),
        "delivery_orders":
            List<dynamic>.from(deliveryOrders.map((x) => x.toJson())),
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
    this.member,
    this.agenId,
    this.reward,
  });

  int id;
  String name;
  String address;
  String npwp;
  String phone;
  String website;
  String logo;
  int userId;
  String createdAt;
  String updatedAt;
  String member;
  int agenId;
  int reward;

  factory Agen.fromJson(Map<String, dynamic> json) => Agen(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        npwp: json["npwp"],
        phone: json["phone"],
        website: json["website"],
        logo: json["logo"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        member: json["member"] == null ? null : json["member"],
        agenId: json["agen_id"] == null ? null : json["agen_id"],
        reward: json["reward"] == null ? null : json["reward"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "member": member == null ? null : member,
        "agen_id": agenId == null ? null : agenId,
        "reward": reward == null ? null : reward,
      };
}

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
    this.salesOrder,
    this.customer,
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
  dynamic unloadingEndTime;
  dynamic departureTimeDepot;
  String status;
  SalesOrder salesOrder;
  Agen customer;
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
        unloadingEndTime: json["unloading_end_time"],
        departureTimeDepot: json["departure_time_depot"],
        status: json["status"],
        salesOrder: SalesOrder.fromJson(json["sales_order"]),
        customer: Agen.fromJson(json["customer"]),
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
        "unloading_end_time": unloadingEndTime,
        "departure_time_depot": departureTimeDepot,
        "status": status,
        "sales_order": salesOrder.toJson(),
        "customer": customer.toJson(),
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
  String createdAt;
  String updatedAt;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        avatar: json["avatar"],
        route: json["route"],
        userId: json["user_id"],
        agenId: json["agen_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class SalesOrder {
  SalesOrder({
    this.id,
    this.salesOrderNumber,
    this.agenId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String salesOrderNumber;
  int agenId;
  DateTime createdAt;
  DateTime updatedAt;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        id: json["id"],
        salesOrderNumber: json["sales_order_number"],
        agenId: json["agen_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sales_order_number": salesOrderNumber,
        "agen_id": agenId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class DriverHomeModel with ChangeNotifier {
  List<DriverHome> _listHomeDetail = [];
  List filteredHomeDetail = new List();
  List<DriverHome> get listHomeDetail {
    return [..._listHomeDetail];
  }

  Future<void> fetchDataDriverHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    print(token);
    final response = await http.get(Uri.encodeFull(urls + '/api/user/home'),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<DriverHome> newData = [];

      var data = Map<String, dynamic>.from(convertData);
      newData.add(DriverHome.fromJson(data));
      _listHomeDetail = newData;

      notifyListeners();
    }
  }
}
