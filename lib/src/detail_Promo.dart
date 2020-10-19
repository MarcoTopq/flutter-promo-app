import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/main.dart';
import 'package:warnakaltim/src/all_promo.dart';
import 'package:warnakaltim/src/detail_voucher.dart';
import 'package:warnakaltim/src/model/detailPromoModel.dart';
import 'package:http/http.dart' as http;

class DetailPromo extends StatefulWidget {
  final String id;
  DetailPromo({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DetailPromoState createState() => _DetailPromoState();
}

class _DetailPromoState extends State<DetailPromo>
    with SingleTickerProviderStateMixin {
  String promoId;
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DetailPromoModel>(context, listen: false)
        .fetchDataDetailPromo(widget.id);
  }

  @override
  void initState() {
    // this.getdata();
    super.initState();
    // this.kirimdata();

    // WidgetsBinding.instance.addObserver(this);
    _refreshData(context);
  }

  Future<http.Response> kirimdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    };
    http.Response hasil =
        await http.post(Uri.decodeFull(urls + "/api/promo/take"),
            body: {
              "promo_id": promoId,
            },
            headers: headers);
    print('Berhasillllllllllllllllllllllllllllll');

    return Future.value(hasil);
  }

  void _showDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Penukaran Promo " + title + " telah Berhasi !!!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AllPromo()),
                );
              },
            ),
          ],
        );
      },
    );
  }

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
            'Detail Promo',
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
                future: Provider.of<DetailPromoModel>(context, listen: false)
                    .fetchDataDetailPromo(widget.id),
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
                    return Consumer<DetailPromoModel>(
                        builder: (ctx, _listPromoDetail, child) => Center(
                                child: Container(
                                    child: Stack(children: <Widget>[
                              ListView(
                                children: <Widget>[
                                  Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: gold,
                                          width: 2.0,
                                        ),
                                      ),
                                      color: Colors.white12,
                                      child: Column(
                                        children: <Widget>[
                                          Image.network(
                                            _listPromoDetail
                                                .listDetailPromo[0].image,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.3,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      )),
                                  // Expanded(
                                  //     flex: 1,
                                  //     child:
                                  SingleChildScrollView(
                                      // scrollDirection: Axis.vertical,
                                      child: Container(
                                          height: 2000,
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'KETERANGAN',
                                                style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(10)),
                                              Text(
                                                _listPromoDetail
                                                    .listDetailPromo[0]
                                                    .description,
                                                style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                'PERSYARATAN',
                                                style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(10)),
                                              Text(
                                                _listPromoDetail
                                                    .listDetailPromo[0].terms,
                                                style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ))),
                                ],
                              ),
                              Positioned(
                                  bottom: -10.0,
                                  left: 0.0,
                                  child: Container(
                                      width: 500,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: gold,
                                            width: 2.0,
                                          ),
                                        ),
                                        color: Colors.white,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                  padding: EdgeInsets.all(10)),
                                              Container(
                                                  width: 200,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                          _listPromoDetail
                                                                  .listDetailPromo[
                                                                      0]
                                                                  .point
                                                                  .toString() +
                                                              ' Point',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: gold,
                                                              fontSize: 30)),
                                                      Expanded(
                                                          child: Text(
                                                        _listPromoDetail
                                                            .listDetailPromo[0]
                                                            .title
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                      ))
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.all(5)),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      15,
                                                  child: InkWell(
                                                      onTap: () async {
                                                        promoId =
                                                            _listPromoDetail
                                                                .listDetailPromo[
                                                                    0]
                                                                .id
                                                                .toString();
                                                        kirimdata().then(
                                                            (value) async {
                                                          if (value
                                                                  .statusCode ==
                                                              200) {
                                                            print(
                                                                'hahahahahaahah');
                                                            final responseJson =
                                                                json.decode(
                                                                    value.body);

                                                            await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        "Penukaran Promo "
                                                                        " telah Berhasil !!!"),
                                                                    actions: <
                                                                        Widget>[
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "Ok"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .pop(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => DetailVoucher()),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: new Text(
                                                                        "Penukaran Promo "
                                                                        "Gagal !!!"),
                                                                    actions: <
                                                                        Widget>[
                                                                      new FlatButton(
                                                                        child: new Text(
                                                                            "Ok"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .pop(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => DetailVoucher()),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                  // Navigator.pushReplacement(
                                                                  //     context,
                                                                  //     MaterialPageRoute(
                                                                  //         builder: (context) => DetailPromo(
                                                                  //             id: _listPromoDetail
                                                                  //                 .listDetailPromo[0]
                                                                  //                 .id
                                                                  //                 .toString())));
                                                                });
                                                          }
                                                        });
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          side: BorderSide(
                                                            color: gold,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        color: Colors.white,
                                                        child: Center(
                                                            child: Text('Tukar',
                                                                style: TextStyle(
                                                                    color: gold,
                                                                    fontSize:
                                                                        20))),
                                                      )))
                                            ]),
                                      )))
                            ]))));
                  }
                })));
  }
}
