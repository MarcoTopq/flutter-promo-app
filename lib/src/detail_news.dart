import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailNews extends StatefulWidget {
  final String url;
  DetailNews({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
     @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'Detail News',
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        backgroundColor: Colors.grey[850],
        body: new WebviewScaffold(
        url: widget. url,
      ),        
    );
  }
}
