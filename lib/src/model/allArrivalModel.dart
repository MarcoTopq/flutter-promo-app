import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

// To parse this JSON data, do
//
//     final allArrival = allArrivalFromJson(jsonString);

import 'dart:convert';

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

  factory AllArrival.fromJson(Map<String, dynamic> json) => AllArrival(
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
        departureTime: DateTime.parse(json["departure_time"]),
        arrivalTime: DateTime.parse(json["arrival_time"]),
        unloadingStartTime: json["unloading_start_time"],
        unloadingEndTime: json["unloading_end_time"],
        departureTimeDepot: json["departure_time_depot"],
        status: json["status"],
        bast: json["bast"],
        salesOrderId: json["sales_order_id"],
        customerId: json["customer_id"],
        driverId: json["driver_id"],
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
        "departure_time": departureTime.toIso8601String(),
        "arrival_time": arrivalTime.toIso8601String(),
        "unloading_start_time": unloadingStartTime,
        "unloading_end_time": unloadingEndTime,
        "departure_time_depot": departureTimeDepot,
        "status": status,
        "bast": bast,
        "sales_order_id": salesOrderId,
        "customer_id": customerId,
        "driver_id": driverId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
