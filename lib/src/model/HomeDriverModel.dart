import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:warnakaltim/main.dart';

// To parse this JSON data, do
//
//     final driverHome = driverHomeFromJson(jsonString);

import 'dart:convert';

DriverHome driverHomeFromJson(String str) =>
    DriverHome.fromJson(json.decode(str));

String driverHomeToJson(DriverHome data) => json.encode(data.toJson());

class DriverHome {
  DriverHome({
    this.user,
    this.readyDeliveryOrder,
  });

  User user;
  List<ReadyDeliveryOrderElement> readyDeliveryOrder;

  factory DriverHome.fromJson(Map<String, dynamic> json) => DriverHome(
        user: User.fromJson(json["user"]),
        readyDeliveryOrder: List<ReadyDeliveryOrderElement>.from(
            json["ready_delivery_order"]
                .map((x) => ReadyDeliveryOrderElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "ready_delivery_order":
            List<dynamic>.from(readyDeliveryOrder.map((x) => x.toJson())),
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
    this.agen,
    this.deliveryOrder,
  });

  int id;
  String name;
  String address;
  String phone;
  String avatar;
  int route;
  int userId;
  int agenId;
  DateTime createdAt;
  DateTime updatedAt;
  Customer agen;
  List<ReadyDeliveryOrderElement> deliveryOrder;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        avatar: json["avatar"],
        route: json["route"],
        userId: json["user_id"],
        agenId: json["agen_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        agen: json["agen"] == null ? null : Customer.fromJson(json["agen"]),
        deliveryOrder: json["delivery_order"] == null
            ? null
            : List<ReadyDeliveryOrderElement>.from(json["delivery_order"]
                .map((x) => ReadyDeliveryOrderElement.fromJson(x))),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "agen": agen == null ? null : agen.toJson(),
        "delivery_order": deliveryOrder == null
            ? null
            : List<dynamic>.from(deliveryOrder.map((x) => x.toJson())),
      };
}

class ReadyDeliveryOrderElement {
  ReadyDeliveryOrderElement({
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
  Customer customer;
  Driver driver;
  String bast;

  factory ReadyDeliveryOrderElement.fromJson(Map<String, dynamic> json) =>
      ReadyDeliveryOrderElement(
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
        customer: Customer.fromJson(json["customer"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        bast: json["bast"],
      );

  Map<String, dynamic> toJson() => {
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
    this.salesOrders,
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
  List<SalesOrder> salesOrders;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        member: json["member"] == null ? null : json["member"],
        address: json["address"],
        npwp: json["npwp"],
        phone: json["phone"],
        website: json["website"],
        logo: json["logo"],
        userId: json["user_id"],
        agenId: json["agen_id"] == null ? null : json["agen_id"],
        reward: json["reward"] == null ? null : json["reward"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        salesOrders: json["sales_orders"] == null
            ? null
            : List<SalesOrder>.from(
                json["sales_orders"].map((x) => SalesOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "member": member == null ? null : member,
        "address": address,
        "npwp": npwp,
        "phone": phone,
        "website": website,
        "logo": logo,
        "user_id": userId,
        "agen_id": agenId == null ? null : agenId,
        "reward": reward == null ? null : reward,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sales_orders": salesOrders == null
            ? null
            : List<dynamic>.from(salesOrders.map((x) => x.toJson())),
      };
}

class SalesOrder {
  SalesOrder({
    this.id,
    this.salesOrderNumber,
    this.agenId,
    this.createdAt,
    this.updatedAt,
    this.deliveryOrders,
  });

  int id;
  String salesOrderNumber;
  int agenId;
  DateTime createdAt;
  DateTime updatedAt;
  List<SalesOrderDeliveryOrder> deliveryOrders;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        id: json["id"],
        salesOrderNumber: json["sales_order_number"],
        agenId: json["agen_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deliveryOrders: json["delivery_orders"] == null
            ? null
            : List<SalesOrderDeliveryOrder>.from(json["delivery_orders"]
                .map((x) => SalesOrderDeliveryOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sales_order_number": salesOrderNumber,
        "agen_id": agenId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delivery_orders": deliveryOrders == null
            ? null
            : List<dynamic>.from(deliveryOrders.map((x) => x.toJson())),
      };
}

class SalesOrderDeliveryOrder {
  SalesOrderDeliveryOrder({
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
    this.bast,
    this.salesOrderId,
    this.customerId,
    this.driverId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String deliveryOrderNumber;
  DateTime effectiveDateStart;
  DateTime effectiveDateEnd;
  String product;
  int quantity;
  String shippedWith;
  int shippedVia;
  String noVehicles;
  int kmStart;
  String kmEnd;
  String sgMeter;
  String topSeal;
  String bottomSeal;
  String temperature;
  DateTime departureTime;
  DateTime arrivalTime;
  dynamic unloadingStartTime;
  dynamic unloadingEndTime;
  dynamic departureTimeDepot;
  int status;
  String bast;
  int salesOrderId;
  int customerId;
  int driverId;
  DateTime createdAt;
  DateTime updatedAt;

  factory SalesOrderDeliveryOrder.fromJson(Map<String, dynamic> json) =>
      SalesOrderDeliveryOrder(
        id: json["id"],
        deliveryOrderNumber: json["delivery_order_number"],
        effectiveDateStart: DateTime.parse(json["effective_date_start"]),
        effectiveDateEnd: DateTime.parse(json["effective_date_end"]),
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
        departureTime: json["departure_time"] == null
            ? null
            : DateTime.parse(json["departure_time"]),
        arrivalTime: json["arrival_time"] == null
            ? null
            : DateTime.parse(json["arrival_time"]),
        unloadingStartTime: json["unloading_start_time"],
        unloadingEndTime: json["unloading_end_time"],
        departureTimeDepot: json["departure_time_depot"],
        status: json["status"],
        bast: json["bast"] == null ? null : json["bast"],
        salesOrderId: json["sales_order_id"],
        customerId: json["customer_id"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_order_number": deliveryOrderNumber,
        "effective_date_start": effectiveDateStart.toIso8601String(),
        "effective_date_end": effectiveDateEnd.toIso8601String(),
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
        "departure_time":
            departureTime == null ? null : departureTime.toIso8601String(),
        "arrival_time":
            arrivalTime == null ? null : arrivalTime.toIso8601String(),
        "unloading_start_time": unloadingStartTime,
        "unloading_end_time": unloadingEndTime,
        "departure_time_depot": departureTimeDepot,
        "status": status,
        "bast": bast == null ? null : bast,
        "sales_order_id": salesOrderId,
        "customer_id": customerId,
        "driver_id": driverId == null ? null : driverId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class User {
  User({
    this.id,
    this.email,
    this.emailVerifiedAt,
    this.roleId,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.role,
  });

  int id;
  String email;
  dynamic emailVerifiedAt;
  int roleId;
  String fcmToken;
  DateTime createdAt;
  DateTime updatedAt;
  Driver driver;
  Role role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        fcmToken: json["fcm_token"],
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
        "fcm_token": fcmToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "driver": driver.toJson(),
        "role": role.toJson(),
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
    final response = await http.get(Uri.encodeFull(urls + '/api/me'), headers: {
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
