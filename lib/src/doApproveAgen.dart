import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:warnakaltim/main.dart';
import 'package:warnakaltim/src/agenHome.dart';
import 'package:warnakaltim/src/deliveryDetail.dart';
import 'package:warnakaltim/src/doApproveDetail.dart';
import 'package:warnakaltim/src/driverHistory.dart';
import 'package:warnakaltim/src/model/HomeUserModel.dart';
import 'package:warnakaltim/src/model/doApproveModel.dart';
import 'package:warnakaltim/src/spring_button.dart';
import 'package:warnakaltim/src/userHome.dart';
import 'package:warnakaltim/src/widget.dart';
import 'package:http/http.dart' as http;

class DoApproveAgen extends StatefulWidget {
  final String url;
  DoApproveAgen({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _DoApproveAgenState createState() => _DoApproveAgenState();
}

class _DoApproveAgenState extends State<DoApproveAgen> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DoApproveModel>(context, listen: false)
        .fetchDataDoApprove();
  }

  @override
  void initState() {
    // this.getdata();
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    _refreshData(context);
  }

  Future<http.Response> accepted(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    http.Response hasil = await http.get(
        Uri.decodeFull(urls + "/api/agen/deliveryorder/approve/" + id),
        // body: {
        //   "email": emailController.text,
        //   "password": passwordController.text,
        //   "fcm_token": "1212123"
        // },
        headers: {
          "Accept": "application/JSON",
          "Authorization": 'Bearer ' + token
        });
    print(hasil.body);
    return Future.value(hasil);
  }

  void _increment() {
    setState(() {
      badges--;
    });
  }

  @override
  Widget build(BuildContext context) {
    double b_width = MediaQuery.of(context).size.width * 0.5;
    double b_height = MediaQuery.of(context).size.width * 0.4;

    double a_width = MediaQuery.of(context).size.width * 0.6;
    double a_height = MediaQuery.of(context).size.width * 0.5;

    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.height * 0.3;

    double d_width = MediaQuery.of(context).size.width * 0.3;
    double d_height = MediaQuery.of(context).size.height * 0.3;

    double e_width = MediaQuery.of(context).size.width * 0.3;
    double e_height = MediaQuery.of(context).size.height / 8;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'Delivery Order',
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        backgroundColor: Colors.grey[850],
        body: RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: Provider.of<DoApproveModel>(context, listen: false)
                    .fetchDataDoApprove(),
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
                    return Consumer<DoApproveModel>(
                        builder: (ctx, _listDelivery, child) => Center(
                                // child: Stack(children: <Widget>[
                                child: CustomScrollView(slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.all(20),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: gold,
                                              width: 2.0,
                                            ),
                                          ),
                                          color: Colors.black12,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Row(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: [
                                              //     // Padding(padding: EdgeInsets.all(5)),
                                              // Icon(
                                              //   Icons.check_circle,
                                              //   color: Colors.green,
                                              //   size: 20,
                                              // ),
                                              //     Padding(padding: EdgeInsets.all(5)),
                                              //     Text(
                                              //       _listDelivery
                                              //           .listDoApprove[index]
                                              //           .deliveryOrderNumber,
                                              //       style: new TextStyle(
                                              //         fontSize: 16.0,
                                              //         color: Colors.white,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              Row(
                                                children: [
                                                  // IntrinsicHeight(
                                                  //     child: VerticalDivider(
                                                  //   endIndent: 20.0,
                                                  //   indent: 0.0,
                                                  //   thickness: 10,
                                                  //   width: 30.0,
                                                  //   color: Colors.white,
                                                  // )),
                                                  Expanded(
                                                      child: ListTile(
                                                    leading: Icon(
                                                      Icons.add_circle,
                                                      color: gold,
                                                      size: 40,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'No DO : ' +
                                                              _listDelivery
                                                                  .listDoApprove[
                                                                      index]
                                                                  .deliveryOrderNumber
                                                                  .toString(),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'No SO : ' +
                                                              _listDelivery
                                                                  .listDoApprove[
                                                                      index]
                                                                  .salesOrderId
                                                                  .toString(),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          _listDelivery
                                                              .listDoApprove[
                                                                  index]
                                                              .product
                                                              .toString(),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          _listDelivery
                                                              .listDoApprove[
                                                                  index]
                                                              .quantity
                                                              .toString()
                                                              .replaceAllMapped(
                                                                  new RegExp(
                                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                  (Match m) =>
                                                                      '${m[1]},'),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          _listDelivery
                                                              .listDoApprove[
                                                                  index]
                                                              .status
                                                              .toString(),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          height: 60,
                                                          child: SpringButton(
                                                              SpringButtonType
                                                                  .OnlyScale,
                                                              roundedRectButton(
                                                                  "Detail",
                                                                  signInGradients,
                                                                  false),
                                                              onTapDown:
                                                                  (_) async {
                                                            setState(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => DoApproveDetailAgen(
                                                                          id: _listDelivery
                                                                              .listDoApprove[index]
                                                                              .id
                                                                              .toString())));
                                                            });
                                                          }),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          height: 60,
                                                          child: SpringButton(
                                                              SpringButtonType
                                                                  .OnlyScale,
                                                              roundedRectButton(
                                                                  "Approve",
                                                                  signInGradients,
                                                                  false),
                                                              onTap: () async {
                                                            await accepted(
                                                                _listDelivery
                                                                    .listDoApprove[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                            setState(() {
                                                              // badges--;
                                                              _increment();
                                                              Toast.show(
                                                                  "Approve Berhasil",
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Homepage()));
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              DoApproveAgen()));
                                                            });
                                                          }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ));
                                  },
                                  childCount:
                                      _listDelivery.listDoApprove.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
