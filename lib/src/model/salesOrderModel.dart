import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

List<SalesOrder> salesOrderFromJson(String str) =>
    List<SalesOrder>.from(json.decode(str).map((x) => SalesOrder.fromJson(x)));

String salesOrderToJson(List<SalesOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

class SalesOrderModel with ChangeNotifier {
  List<SalesOrder> _listSalesOrder = [];
  List filteredSalesOrder = new List();
  List<SalesOrder> get listSalesOrder {
    return [..._listSalesOrder];
  }

  Future<void> fetchDataSalesOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http.get(
        Uri.encodeFull('https://rpm.bpkadkaltim.com/api/agen/salesorder'),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<SalesOrder> newData = [];
      for (Map i in convertData) {
        newData.add(SalesOrder.fromJson(i));
      }
      _listSalesOrder = newData;
      notifyListeners();
    }
  }
  // }
}
