import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

List<AllArrival> allArrivalFromJson(String str) =>
    List<AllArrival>.from(json.decode(str).map((x) => AllArrival.fromJson(x)));

String allArrivalToJson(List<AllArrival> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllArrival {
  AllArrival({
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

  factory AllArrival.fromJson(Map<String, dynamic> json) => AllArrival(
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
        departureTime: json["departure_time"],
        arrivalTime: json["arrival_time"],
        unloadingStartTime: json["unloading_start_time"],
        unloadingEndTime: DateTime.parse(json["unloading_end_time"]),
        departureTimeDepot: json["departure_time_depot"],
        status: json["status"],
        salesOrderId: json["sales_order_id"],
        driver: Driver.fromJson(json["driver"]),
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
        "departure_time": departureTime,
        "arrival_time": arrivalTime,
        "unloading_start_time": unloadingStartTime,
        "unloading_end_time": unloadingEndTime.toIso8601String(),
        "departure_time_depot": departureTimeDepot,
        "status": status,
        "sales_order_id": salesOrderId,
        "driver": driver.toJson(),
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

class ArrivalModel with ChangeNotifier {
  List<AllArrival> _listArrival = [];
  List filteredArrival = new List();
  List<AllArrival> get listArrival {
    return [..._listArrival];
  }

  Future<void> fetchDataArrival() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http.get(
        Uri.encodeFull(urls + '/api/driver/deliveryorder/history'),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<AllArrival> newData = [];
      for (Map i in convertData) {
        newData.add(AllArrival.fromJson(i));
      }
      _listArrival = newData;
      notifyListeners();
    }
  }
  // }
}
