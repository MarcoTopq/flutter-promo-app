import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<AllChartDetail> allChartDetailFromJson(String str) =>
    List<AllChartDetail>.from(
        json.decode(str).map((x) => AllChartDetail.fromJson(x)));

String allChartDetailToJson(List<AllChartDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllChartDetail {
  int id;
  int quantity;
  int total;
  DateTime billingDate;
  int distributorId;
  DateTime createdAt;
  DateTime updatedAt;
  String noSo;
  String date;

  AllChartDetail({
    this.id,
    this.quantity,
    this.total,
    this.billingDate,
    this.distributorId,
    this.createdAt,
    this.updatedAt,
    this.noSo,
    this.date,
  });

  factory AllChartDetail.fromJson(Map<String, dynamic> json) => AllChartDetail(
        id: json["id"],
        quantity: json["quantity"],
        total: json["total"],
        billingDate: DateTime.parse(json["billing_date"]),
        distributorId: json["distributor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        noSo: json["no_so"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "total": total,
        "billing_date": billingDate.toIso8601String(),
        "distributor_id": distributorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "no_so": noSo,
        "date": date,
      };
}

class ChartModel with ChangeNotifier {
  List<AllChartDetail> _listChart = [];
  List filteredChart = new List();
  List<AllChartDetail> get listChart {
    return [..._listChart];
  }

  Future<void> fetchDataChart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/transaction'),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<AllChartDetail> newData = [];
      for (Map i in convertData) {
        newData.add(AllChartDetail.fromJson(i));
      }
      _listChart = newData;
      notifyListeners();
    }
  }
  // }
}
