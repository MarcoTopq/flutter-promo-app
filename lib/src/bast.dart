import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Bast extends StatefulWidget {
  final String url;
  Bast({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  _BastState createState() => _BastState();
}

class _BastState extends State<Bast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          // centerTitle: true,
          title: Text(
            "Bast",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              // fontWeight: FontWeight.bold,
              // fontFamily: Utils.ubuntuRegularFont),
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        backgroundColor: Colors.grey[850],
        body: Container(
            child: PhotoView(
          imageProvider: NetworkImage(widget.url),
        )));
  }
}
