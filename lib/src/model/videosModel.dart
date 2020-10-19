import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:warnakaltim/main.dart';

// To parse this JSON data, do
//
//     final allVideosDetail = allVideosDetailFromJson(jsonString);

import 'dart:convert';

List<AllVideosDetail> allVideosDetailFromJson(String str) =>
    List<AllVideosDetail>.from(
        json.decode(str).map((x) => AllVideosDetail.fromJson(x)));

String allVideosDetailToJson(List<AllVideosDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllVideosDetail {
  AllVideosDetail({
    this.id,
    this.title,
    this.image,
    this.url,
    this.createdAt,
  });

  int id;
  String title;
  String image;
  String url;
  String createdAt;

  factory AllVideosDetail.fromJson(Map<String, dynamic> json) =>
      AllVideosDetail(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        url: json["url"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "url": url,
        "created_at": createdAt,
      };
}

class VideosModel with ChangeNotifier {
  List<AllVideosDetail> _listVideos = [];
  List filteredVideos = new List();
  List<AllVideosDetail> get listVideos {
    return [..._listVideos];
  }

  Future<void> fetchDataVideos() async {
    final response = await http.get(Uri.encodeFull(urls + '/api/videos'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<AllVideosDetail> newData = [];
      for (Map i in convertData) {
        newData.add(AllVideosDetail.fromJson(i));
      }
      _listVideos = newData;
      notifyListeners();
    }
  }
  // }
}
