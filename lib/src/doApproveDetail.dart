import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:warnakaltim/src/model/doApproveDetailModel.dart';

class DoApproveDetailAgen extends StatefulWidget {
  final String id;
  DoApproveDetailAgen({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _DoApproveDetailAgenState createState() => _DoApproveDetailAgenState();
}

class _DoApproveDetailAgenState extends State<DoApproveDetailAgen>
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
    await Provider.of<DoApproveDetailModel>(context, listen: false)
        .fetchDataDoApproveDetail(widget.id);
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
                future:
                    Provider.of<DoApproveDetailModel>(context, listen: false)
                        .fetchDataDoApproveDetail(widget.id),
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
                    return Consumer<DoApproveDetailModel>(
                        builder: (ctx, _listDoApproveDetail, child) => Center(
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
                                        //       _listDoApproveDetail
                                        //           .listDoApproveDetail[index].time,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .deliveryOrderNumber
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .salesOrderId
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .effectiveDateStart
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .effectiveDateEnd
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .product
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
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
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .shippedWith
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .shippedVia
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .noVehicles
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .kmStart
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .kmEnd
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .sgMeter
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .topSeal
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .bottomSeal
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .temperature
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .departureTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .arrivalTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .unloadingStartTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .unloadingEndTime
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .departureTimeDepot
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                    _listDoApproveDetail
                                                        .listDoApproveDetail[
                                                            index]
                                                        .status
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  // Text(
                                                  //   'Customer Name',
                                                  //   style: new TextStyle(
                                                  //     fontSize: 12.0,
                                                  //     color: gold,
                                                  //   ),
                                                  // ),
                                                  // Text(
                                                  //   _listDoApproveDetail
                                                  //       .listDoApproveDetail[
                                                  //           index]
                                                  //       .customer
                                                  //       .name
                                                  //       .toString(),
                                                  //   style: new TextStyle(
                                                  //     fontSize: 16.0,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //     padding:
                                                  //         EdgeInsets.all(2)),
                                                  // Text(
                                                  //   'Member',
                                                  //   style: new TextStyle(
                                                  //     fontSize: 12.0,
                                                  //     color: gold,
                                                  //   ),
                                                  // ),
                                                  // Text(
                                                  //   _listDoApproveDetail
                                                  //       .listDoApproveDetail[
                                                  //           index]
                                                  //       .customer
                                                  //       .member
                                                  //       .toString(),
                                                  //   style: new TextStyle(
                                                  //     fontSize: 16.0,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //     padding:
                                                  //         EdgeInsets.all(2)),
                                                  // Text(
                                                  //   'Customer Address',
                                                  //   style: new TextStyle(
                                                  //     fontSize: 12.0,
                                                  //     color: gold,
                                                  //   ),
                                                  // ),
                                                  // Text(
                                                  //   _listDoApproveDetail
                                                  //       .listDoApproveDetail[
                                                  //           index]
                                                  //       .customer
                                                  //       .address
                                                  //       .toString(),
                                                  //   style: new TextStyle(
                                                  //     fontSize: 16.0,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  // Padding(
                                                  //     padding:
                                                  //         EdgeInsets.all(2)),
                                                  // Text(
                                                  //   'Customer Phone',
                                                  //   style: new TextStyle(
                                                  //     fontSize: 12.0,
                                                  //     color: gold,
                                                  //   ),
                                                  // ),
                                                  // Text(
                                                  //   _listDoApproveDetail
                                                  //       .listDoApproveDetail[
                                                  //           index]
                                                  //       .customer
                                                  //       .phone
                                                  //       .toString(),
                                                  //   style: new TextStyle(
                                                  //     fontSize: 16.0,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
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
                                                  _listDoApproveDetail
                                                              .listDoApproveDetail[
                                                                  index]
                                                              .driver ==
                                                          null
                                                      ? Text(
                                                          ' - ',
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : Text(
                                                          _listDoApproveDetail
                                                              .listDoApproveDetail[
                                                                  index]
                                                              .driver['name']
                                                              .toString(),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                                  _listDoApproveDetail
                                                              .listDoApproveDetail[
                                                                  index]
                                                              .driver ==
                                                          null
                                                      ? Text(
                                                          ' - ',
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : Text(
                                                          _listDoApproveDetail
                                                              .listDoApproveDetail[
                                                                  index]
                                                              .driver['phone']
                                                              .toString(),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
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
                                        childCount: _listDoApproveDetail
                                            .listDoApproveDetail.length))
                              ],
                            )));
                  }
                })));
  }
}
