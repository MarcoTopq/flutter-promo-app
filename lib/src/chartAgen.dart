import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:warnakaltim/main.dart';

class ChartAgen extends StatefulWidget {
  final String id;
  ChartAgen({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ChartAgenState createState() => _ChartAgenState();
}

class _ChartAgenState extends State<ChartAgen> {
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
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Chart',
          style: new TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      backgroundColor: Colors.grey[850],
      body: new WebviewScaffold(url: urls + '/chart/agen/'+idnya.toString(),
      withJavascript: true,
          //  widget.id,
          ),
    );
  }
}
