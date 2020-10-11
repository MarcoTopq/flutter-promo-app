import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:warnakaltim/src/model/detailDeliveryModel.dart';

class DetailDelivery extends StatefulWidget {
  final String id;
  DetailDelivery({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _DetailDeliveryState createState() => _DetailDeliveryState();
}

class _DetailDeliveryState extends State<DetailDelivery>
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
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DetailDoModel>(context, listen: false)
        .fetchDataDetailDo(widget.id);
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
            "Detail Delivery",
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
                future: Provider.of<DetailDoModel>(context, listen: false)
                    .fetchDataDetailDo(widget.id),
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
                    return Consumer<DetailDoModel>(
                        builder: (ctx, _listDetaildo, child) => Center(
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
                                        // Row(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   children: [
                                        //     // Padding(padding: EdgeInsets.all(5)),
                                        //     Icon(
                                        //       Icons.check_circle,
                                        //       color: Colors.green,
                                        //       size: 20,
                                        //     ),
                                        //     Padding(padding: EdgeInsets.all(5)),
                                        //     Text(
                                        //       _listDetaildo
                                        //           .listDetailDo[index].time,
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
                                              // leading: Icon(
                                              //   Icons.add_circle,
                                              //   color: gold,
                                              //   size: 40,
                                              // ),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'No DO ',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .deliveryOrderNumber
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'NO SO',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .salesOrder
                                                        .salesOrderNumber
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Effective Date Start ',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .effectiveDateStart
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Effective Date End',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .effectiveDateEnd
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Product',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .product
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Quantity',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
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
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Shipped With',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .shippedWith
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Shipped Via',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .shippedVia
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'No Vehicles',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .noVehicles
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'KM Start',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .kmStart
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'KM End',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .kmEnd
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'SG Meter',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .sgMeter
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Top Seal',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .topSeal
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Bottom Seal',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .bottomSeal
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Temperature',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .temperature
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Departure Time',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .departureTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Arrival Time',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .arrivalTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Unloading StartTime',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .unloadingStartTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Unloading EndTime',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .unloadingEndTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Departure Time Depot',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .departureTimeDepot
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Status',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .status
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Customer Name',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .customer
                                                        .name
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Member',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .customer
                                                        .member
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Customer Address',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .customer
                                                        .address
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Customer Phone',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .customer
                                                        .phone
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Driver Name',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .driver
                                                        .name
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Driver Phone',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetaildo
                                                        .listDetailDo[index]
                                                        .driver
                                                        .phone
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
                                },
                                        childCount:
                                            _listDetaildo.listDetailDo.length))
                              ],
                            )));
                  }
                })));
  }
}
