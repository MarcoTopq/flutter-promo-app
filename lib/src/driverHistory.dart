import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:warnakaltim/src/model/notifdoModel.dart';

class DriverHistory extends StatefulWidget {
  final String id;
  DriverHistory({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _DriverHistoryState createState() => _DriverHistoryState();
}

class _DriverHistoryState extends State<DriverHistory>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TextEditingController codeController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this.kirimdata();
  }

  Future<http.Response> kirimdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    };

    http.Response hasil = await http.post(
        Uri.decodeFull("http://rpm.kantordesa.com/api/delivery/code"),
        body: {
          "code": codeController.text,
        },
        headers: headers);
    return Future.value(hasil);
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<NotifDoModel>(context, listen: false)
        .fetchDataNotifdo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double a_width = MediaQuery.of(context).size.width * 0.9;
    double a_height = MediaQuery.of(context).size.width * 0.7;
    var gold = Color.fromRGBO(
      212,
      175,
      55,
      2,
    );
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          // centerTitle: true,
          title: Text(
            "Driver History",
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
        body: RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: Provider.of<NotifDoModel>(context, listen: false)
                    .fetchDataNotifdo(widget.id),
                builder: (ctx, snapshop) {
                  if (snapshop.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshop.error != null) {
                      return Center(
                        child: Text("Error Loading Data"),
                      );
                    }
                    return Consumer<NotifDoModel>(
                        builder: (ctx, _listNotif, child) => Center(
                                child: CustomScrollView(
                              slivers: <Widget>[
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Padding(padding: EdgeInsets.all(5)),
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            Padding(padding: EdgeInsets.all(5)),
                                            Text(
                                              _listNotif
                                                  .listNotifdo[index].time,
                                              style: new TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IntrinsicHeight(
                                                child: VerticalDivider(
                                              endIndent: 20.0,
                                              indent: 0.0,
                                              thickness: 10,
                                              width: 30.0,
                                              color: Colors.white,
                                            )),
                                            Expanded(
                                                child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _listNotif
                                                        .listNotifdo[index].date
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listNotif
                                                        .listNotifdo[index]
                                                        .driver
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listNotif
                                                        .listNotifdo[index]
                                                        .description
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }, childCount: _listNotif.listNotifdo.length))
                              ],
                            )));
                  }
                })));
  }
}
