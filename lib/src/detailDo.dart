import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_table/json_table.dart';
import 'package:warnakaltim/src/bast.dart';

import 'package:warnakaltim/src/model/detailDoModel.dart';

class DetailDeliveryAgen extends StatefulWidget {
  final String id;
  DetailDeliveryAgen({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _DetailDeliveryAgenState createState() => _DetailDeliveryAgenState();
}

class _DetailDeliveryAgenState extends State<DetailDeliveryAgen>
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
    await Provider.of<DetailDoAgenModel>(context, listen: false)
        .fetchDataDetailDoAgen(widget.id);
  }

  final String jsonSample =
      '[{"equipe1":"PSG","equipe2":"DIJON","type_prono":"1N2"},{"equipe1":"MONACO","equipe2":"REIMS","type_prono":"1N2"},{"equipe1":"TOULOUSE","equipe2":"RENNES","type_prono":"1N2"},{"equipe1":"MONTPELLIER","equipe2":"STRASBOURG","type_prono":"1N2"},{"equipe1":"AMIENS","equipe2":"METZ","type_prono":"1N2"},{"equipe1":"BREST","equipe2":"ANGERS","type_prono":"1N2"},{"equipe1":"LORIENT","equipe2":"CHAMBLY","type_prono":"1N2"}]';
  bool toggle = true;
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
    var json = jsonDecode(jsonSample);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        // centerTitle: true,
        title: Text(
          "Detail Delivery Order",
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
              future: Provider.of<DetailDoAgenModel>(context, listen: false)
                  .fetchDataDetailDoAgen(widget.id),
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
                  return Consumer<DetailDoAgenModel>(
                      builder: (ctx, _listDetaildoAgen, child) => Center(
                              child: CustomScrollView(
                            slivers: <Widget>[
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                return Container(
                                    // color: Colors.white,
                                    padding: EdgeInsets.all(20),
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                              columns: [
                                                DataColumn(
                                                  label: Text('No DO',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                      'Effective Date Start',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                      'Effective Date End',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                // Lets add one more column to show a delete button
                                                DataColumn(
                                                  label: Text('Product',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Quantity',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Shipped With',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Shipped Via',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('No Vehicles',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('KM Start',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('KM End',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('SG Meter',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Top Seal',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Bottom Seal',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Temperature',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Departure Time',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Arrival Time',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                      'Unloading StartTime',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                      'Unloading EndTime',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                      'Departure Time Depot',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                DataColumn(
                                                  label: Text('Bast',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                              rows: _listDetaildoAgen
                                                  .listDetailDoAgen[0]
                                                  .deliveryOrders
                                                  .map(
                                                    (delivery) =>
                                                        DataRow(cells: [
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .deliveryOrderNumber,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        // Add tap in the row and populate the
                                                        // textfields with the corresponding values to update
                                                        onTap: () {
                                                          // _showValues(
                                                          //     delivery);
                                                          // // Set the Selected delivery to Update
                                                          // _selecteddelivery =
                                                          //     delivery;
                                                          // setState(() {
                                                          //   _isUpdating =
                                                          //       true;
                                                          // });
                                                        },
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .deliveryOrderNumber
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .effectiveDateStart
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .effectiveDateEnd
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.product
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.quantity
                                                                .toString()
                                                                .replaceAllMapped(
                                                                    new RegExp(
                                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                    (Match m) =>
                                                                        '${m[1]},')
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.noVehicles
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.kmStart
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.kmEnd
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.sgMeter
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.topSeal
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.bottomSeal
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.temperature
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .departureTime
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery.arrivalTime
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .unloadingStartTime
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .unloadingEndTime
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .departureTimeDepot
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Text(
                                                            delivery
                                                                .departureTimeDepot
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            )),
                                                        onTap: () {},
                                                      ),
                                                      DataCell(
                                                        Image.network(
                                                          delivery.bast
                                                              .toString(),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Bast(
                                                                            url:
                                                                                delivery.bast.toString(),
                                                                          )));
                                                        },
                                                      ),
                                                    ]),
                                                  )
                                                  .toList(),
                                            ))));
                              }, childCount: 1))
                            ],
                          )));
                }
              })),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.grid_on),
      //     onPressed: () {
      //       setState(
      //         () {
      //           toggle = !toggle;
      //         },
      //       );
      //     })
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}