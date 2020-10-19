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
    this.customer,
    this.customerId,
    this.agenId,
    this.agen,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String salesOrderNumber;
  String customer;
  int customerId;
  int agenId;
  String agen;
  String createdAt;
  String updatedAt;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        id: json["id"],
        salesOrderNumber: json["sales_order_number"],
        customer: json["customer"],
        customerId: json["customer_id"],
        agenId: json["agen_id"],
        agen: json["agen"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sales_order_number": salesOrderNumber,
        "customer": customer,
        "customer_id": customerId,
        "agen_id": agenId,
        "agen": agen,
        "created_at": createdAt,
        "updated_at": updatedAt,
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

    final response = await http.get(Uri.encodeFull(urls + '/api/salesorder'),
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
