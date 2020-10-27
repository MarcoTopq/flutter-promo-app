import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

List<AllCouponDetail> allCouponDetailFromJson(String str) =>
    List<AllCouponDetail>.from(
        json.decode(str).map((x) => AllCouponDetail.fromJson(x)));

String allCouponDetailToJson(List<AllCouponDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCouponDetail {
  AllCouponDetail({
    this.id,
    this.codeCoupon,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String codeCoupon;
  String createdAt;
  String updatedAt;

  factory AllCouponDetail.fromJson(Map<String, dynamic> json) =>
      AllCouponDetail(
        id: json["id"],
        codeCoupon: json["code_coupon"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code_coupon": codeCoupon,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CouponModel with ChangeNotifier {
  List<AllCouponDetail> _listCoupon = [];
  List filteredCoupon = new List();
  List<AllCouponDetail> get listCoupon {
    return [..._listCoupon];
  }

  Future<void> fetchDataCoupon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http.get(Uri.encodeFull(urls + '/api/coupon'),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<AllCouponDetail> newData = [];
      for (Map i in convertData) {
        newData.add(AllCouponDetail.fromJson(i));
      }
      _listCoupon = newData;
      notifyListeners();
    }
  }
  // }
}
