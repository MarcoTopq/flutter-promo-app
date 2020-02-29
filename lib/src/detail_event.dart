import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailEvent extends StatefulWidget {
  final String url;
  DetailEvent({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
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
            'Detail Event',
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
