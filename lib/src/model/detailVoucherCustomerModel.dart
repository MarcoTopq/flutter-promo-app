import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';

DetailCusVoucher detailCusVoucherFromJson(String str) =>
    DetailCusVoucher.fromJson(json.decode(str));

String detailCusVoucherToJson(DetailCusVoucher data) =>
    json.encode(data.toJson());

class DetailCusVoucher {
  DetailCusVoucher({
    this.id,
    this.promoId,
    this.customerId,
    this.createdAt,
    this.promo,
  });

  int id;
  int promoId;
  int customerId;
  String createdAt;
  Promo promo;

  factory DetailCusVoucher.fromJson(Map<String, dynamic> json) =>
      DetailCusVoucher(
        id: json["id"],
        promoId: json["promo_id"],
        customerId: json["customer_id"],
        createdAt: json["created_at"],
        promo: Promo.fromJson(json["promo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "promo_id": promoId,
        "customer_id": customerId,
        "created_at": createdAt,
        "promo": promo.toJson(),
      };
}

class Promo {
  Promo({
    this.id,
    this.title,
    this.image,
    this.description,
    this.terms,
    this.point,
    this.total,
    this.view,
    this.status,
    this.createdAt,
    this.createdBy,
  });

  int id;
  String title;
  String image;
  String description;
  String terms;
  int point;
  int total;
  int view;
  String status;
  String createdAt;
  String createdBy;

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        terms: json["terms"],
        point: json["point"],
        total: json["total"],
        view: json["view"],
        status: json["status"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "description": description,
        "terms": terms,
        "point": point,
        "total": total,
        "view": view,
        "status": status,
        "created_at": createdAt,
        "created_by": createdBy,
      };
}

class DetailVoucherCustomerModel with ChangeNotifier {
  List<DetailCusVoucher> _detailCusVoucher = [];
  List filteredCoupon = new List();
  List<DetailCusVoucher> get detailCusVoucher {
    return [..._detailCusVoucher];
  }

  Future<void> fetchDataDetailVoucerCustomer(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http.get(Uri.encodeFull(urls + '/api/voucher/' + id),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      List<DetailCusVoucher> newData = [];
      var data = Map<String, dynamic>.from(convertData);
      newData.add(DetailCusVoucher.fromJson(data));
      // for (Map i in convertData) {
      //   newData.add(DetailCusVoucher.fromJson(i));
      // }
      _detailCusVoucher = newData;
      notifyListeners();
    }
  }
  // }
}
