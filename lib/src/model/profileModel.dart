import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

ProfileDetail profileDetailFromJson(String str) =>
    ProfileDetail.fromJson(json.decode(str));

String profileDetailToJson(ProfileDetail data) => json.encode(data.toJson());

class ProfileDetail {
  int id;
  String name;
  String logo;
  dynamic description;
  String profile;
  String email;
  dynamic phone;
  dynamic website;
  DateTime createdAt;
  DateTime updatedAt;

  ProfileDetail({
    this.id,
    this.name,
    this.logo,
    this.description,
    this.profile,
    this.email,
    this.phone,
    this.website,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileDetail.fromJson(Map<String, dynamic> json) => ProfileDetail(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        description: json["description"],
        profile: json["profile"],
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "description": description,
        "profileDetail": profile,
        "email": email,
        "phone": phone,
        "website": website,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ProfileDetailModel with ChangeNotifier {
  List<ProfileDetail> _listProfileDetail = [];
  List filteredProfileDetail = new List();
  List<ProfileDetail> get listProfileDetail {
    return [..._listProfileDetail];
  }

  Future<void> fetchDataProfileDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http.get(
        Uri.encodeFull('http://rpm.kantordesa.com/api/company/profile'),
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer' + token
        });
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<ProfileDetail> newData = [];

      var data = Map<String, dynamic>.from(convertData);
      newData.add(ProfileDetail.fromJson(data));
      _listProfileDetail = newData;

      notifyListeners();
    }
  }
}
