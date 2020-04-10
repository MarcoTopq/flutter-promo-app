import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<DeliveryHistory> deliveryHistoryFromJson(String str) => List<DeliveryHistory>.from(json.decode(str).map((x) => DeliveryHistory.fromJson(x)));

String deliveryHistoryToJson(List<DeliveryHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryHistory {
    int id;
    DateTime deliveryAt;
    int distributorId;
    int driverId;
    DateTime createdAt;
    DateTime updatedAt;
    String deliveryDate;
    Driver driver;

    DeliveryHistory({
        this.id,
        this.deliveryAt,
        this.distributorId,
        this.driverId,
        this.createdAt,
        this.updatedAt,
        this.deliveryDate,
        this.driver,
    });

    factory DeliveryHistory.fromJson(Map<String, dynamic> json) => DeliveryHistory(
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

class DeliveryHistoryModel with ChangeNotifier {
  List<DeliveryHistory> _listDeliveryHistory = [];
  List filteredDeliveryHistory = new List();
  List<DeliveryHistory> get listDeliveryHistory {
    return [..._listDeliveryHistory];
  }

  Future<void> fetchDataDeliveryHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http
        .get(Uri.encodeFull('http://rpm.kantordesa.com/api/delivery/history'), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<DeliveryHistory> newData = [];
      for (Map i in convertData) {
        newData.add(DeliveryHistory.fromJson(i));
      }
      _listDeliveryHistory = newData;
      notifyListeners();
    }
  }
  // }
}
