import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

List<VoucherDetail> voucherDetailFromJson(String str) =>
    List<VoucherDetail>.from(
        json.decode(str).map((x) => VoucherDetail.fromJson(x)));

String voucherDetailToJson(List<VoucherDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VoucherDetail {
  int id;
  dynamic codeVoucher;
  int promoId;
  int distributorId;
  DateTime createdAt;
  DateTime updatedAt;
  Promo promo;

  VoucherDetail({
    this.id,
    this.codeVoucher,
    this.promoId,
    this.distributorId,
    this.createdAt,
    this.updatedAt,
    this.promo,
  });

  factory VoucherDetail.fromJson(Map<String, dynamic> json) => VoucherDetail(
        id: json["id"],
        codeVoucher: json["code_voucher"],
        promoId: json["promo_id"],
        distributorId: json["distributor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        promo: Promo.fromJson(json["promo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code_voucher": codeVoucher,
        "promo_id": promoId,
        "distributor_id": distributorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "promo": promo.toJson(),
      };
}

class Promo {
  int id;
  String name;
  String description;
  String image;
  String slug;
  int point;
  int total;
  String status;
  int view;
  int createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  String terms;

  Promo({
    this.id,
    this.name,
    this.description,
    this.image,
    this.slug,
    this.point,
    this.total,
    this.status,
    this.view,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.terms,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        slug: json["slug"],
        point: json["point"],
        total: json["total"],
        status: json["status"],
        view: json["view"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        terms: json["terms"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "slug": slug,
        "point": point,
        "total": total,
        "status": status,
        "view": view,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "terms": terms,
      };
}

class VoucherDetailModel with ChangeNotifier {
  List<VoucherDetail> _listAllVoucher = [];
  List filteredAllPromo = new List();
  List<VoucherDetail> get listAllVoucher {
    return [..._listAllVoucher];
  }

  Future<void> fetchDatVoucherDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    final response = await http
        .get(Uri.encodeFull('http://rpm.kantordesa.com/api/voucher'), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<VoucherDetail> newData = [];

      // var data = Map<String, dynamic>.from(convertData);
      //   newData.add(VoucherDetail.fromJson(data));

      for (Map i in convertData) {
        newData.add(VoucherDetail.fromJson(i));
      }
      _listAllVoucher = newData;

      notifyListeners();
    }
  }
}
