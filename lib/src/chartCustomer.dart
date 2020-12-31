import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:warnakaltim/main.dart';

class ChartCustomer extends StatefulWidget {
  final String id;
  ChartCustomer({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ChartCustomerState createState() => _ChartCustomerState();
}

class _ChartCustomerState extends State<ChartCustomer> {
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
      body: new WebviewScaffold(
        url: urls + '/chart/customer/' + idnya.toString(),
        withJavascript: true,
        // widget.id,
      ),
    );
  }
}
