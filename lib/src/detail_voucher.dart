import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/src/all_Voucher.dart';
import 'package:warnakaltim/src/model/detailVoucherModel.dart';
import 'package:http/http.dart' as http;

class DetailVoucher extends StatefulWidget {
  final String id;
  DetailVoucher({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DetailVoucherState createState() => _DetailVoucherState();
}

class _DetailVoucherState extends State<DetailVoucher>
    with SingleTickerProviderStateMixin {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DetailVoucherModel>(context, listen: false)
        .fetchDataDetailVoucher(widget.id);
  }

  @override
  void initState() {
    // this.getdata();
    super.initState();
    // this.kirimdata();

    // WidgetsBinding.instance.addObserver(this);
    _refreshData(context);
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
            'Detail Voucher',
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
                future: Provider.of<DetailVoucherModel>(context, listen: false)
                    .fetchDataDetailVoucher(widget.id),
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
                    return Consumer<DetailVoucherModel>(
                        builder: (ctx, _listVoucherDetail, child) => Center(
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
                                          Image.network('http://rpm.kantordesa.com/uploads/'+
                                            _listVoucherDetail
                                                .listDetailVoucher[0]
                                                .promo
                                                .image,
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
                                        child:
                                            Column(
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
                                            _listVoucherDetail
                                                .listDetailVoucher[0].promo
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
                                            _listVoucherDetail
                                                .listDetailVoucher[0].promo.terms,
                                            style: new TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                        )
                                      )),
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
                                                          _listVoucherDetail
                                                                  .listDetailVoucher[
                                                                      0]
                                                                  .promo
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
                                                        _listVoucherDetail
                                                            .listDetailVoucher[
                                                                0]
                                                            .promo
                                                            .name
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                      ))
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.all(5)),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Ditukar pada ',
                                                      // overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: gold,
                                                          fontSize: 20)),
                                                  Text(
                                                      _listVoucherDetail
                                                          .listDetailVoucher[0]
                                                          .createdAt
                                                          .toString(),
                                                      // overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: gold,
                                                          fontSize: 15))
                                                ],
                                              ))

                                              // Container(
                                              //     width: MediaQuery.of(context)
                                              //             .size
                                              //             .width /
                                              //         3,
                                              //     height: MediaQuery.of(context)
                                              //             .size
                                              //             .height /
                                              //         15,
                                              //     child: Card(
                                              //       shape:
                                              //           RoundedRectangleBorder(
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //                 10),
                                              //         side: BorderSide(
                                              //           color: gold,
                                              //           width: 2.0,
                                              //         ),
                                              //       ),
                                              //       color: Colors.white,
                                              //       child: Center(
                                              //           child: Text('Tukar',
                                              //               style: TextStyle(
                                              //                   color: gold,
                                              //                   fontSize: 20))),
                                              //     ))
                                            ]),
                                      )))
                            ]))));
                  }
                })));
  }
}
