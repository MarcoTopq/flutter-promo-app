import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<AllArrival> allArrivalFromJson(String str) => List<AllArrival>.from(json.decode(str).map((x) => AllArrival.fromJson(x)));

String allArrivalToJson(List<AllArrival> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllArrival {
    int id;
    DateTime deliveryAt;
    int distributorId;
    int driverId;
    DateTime createdAt;
    DateTime updatedAt;
    String deliveryDate;
    Distributor distributor;

    AllArrival({
        this.id,
        this.deliveryAt,
        this.distributorId,
        this.driverId,
        this.createdAt,
        this.updatedAt,
        this.deliveryDate,
        this.distributor,
    });

    factory AllArrival.fromJson(Map<String, dynamic> json) => AllArrival(
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

class ArrivalModel with ChangeNotifier {
  List<AllArrival> _listArrival = [];
  List filteredArrival = new List();
  List<AllArrival> get listArrival {
    return [..._listArrival];
  }

  Future<void> fetchDataArrival() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http
        .get(Uri.encodeFull('http://rpm.kantordesa.com/api/driver/history'), headers: {
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
