import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:warnakaltim/main.dart';

// To parse this JSON data, do
//
//     final detailDoAgen = detailDoAgenFromJson(jsonString);

import 'dart:convert';

DetailDoAgen detailDoAgenFromJson(String str) =>
    DetailDoAgen.fromJson(json.decode(str));

String detailDoAgenToJson(DetailDoAgen data) => json.encode(data.toJson());

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
  DetailDoAgen salesOrder;
  Customer customer;
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
        salesOrder: DetailDoAgen.fromJson(json["sales_order"]),
        customer: Customer.fromJson(json["customer"]),
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

class DetailDoAgen {
  DetailDoAgen({
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
  String createdAt;
  String updatedAt;
  List<DeliveryOrder> deliveryOrders;

  factory DetailDoAgen.fromJson(Map<String, dynamic> json) => DetailDoAgen(
        id: json["id"],
        salesOrderNumber: json["sales_order_number"],
        agenId: json["agen_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deliveryOrders: json["delivery_orders"] == null
            ? null
            : List<DeliveryOrder>.from(
                json["delivery_orders"].map((x) => DeliveryOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sales_order_number": salesOrderNumber,
        "agen_id": agenId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "delivery_orders": deliveryOrders == null
            ? null
            : List<dynamic>.from(deliveryOrders.map((x) => x.toJson())),
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

class DetailDoAgenModel with ChangeNotifier {
  List<DetailDoAgen> _listDetailDoAgen = [];
  List filteredDetailDoAgen = new List();
  List<DetailDoAgen> get listDetailDoAgen {
    return [..._listDetailDoAgen];
  }

  Future<void> fetchDataDetailDoAgen(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http
        .get(Uri.encodeFull(urls + '/api/agen/salesorder/' + id), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<DetailDoAgen> newData = [];
      var data = Map<String, dynamic>.from(convertData);
      newData.add(DetailDoAgen.fromJson(data));

      _listDetailDoAgen = newData;
      notifyListeners();
    }
  }
  // }
}