import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:warnakaltim/src/bast.dart';
import 'package:warnakaltim/src/model/allArrivalModel.dart';

class AllArrivalDetail extends StatefulWidget {
  final String url;
  AllArrivalDetail({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _AllArrivalDetailState createState() => _AllArrivalDetailState();
}

class _AllArrivalDetailState extends State<AllArrivalDetail> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<ArrivalModel>(context, listen: false).fetchDataArrival();
  }

  @override
  void initState() {
    // this.getdata();
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    _refreshData(context);
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
            'History',
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
                future: Provider.of<ArrivalModel>(context, listen: false)
                    .fetchDataArrival(),
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
                    return Consumer<ArrivalModel>(
                        builder: (ctx, _listArrival, child) => Center(
                                // child: Stack(children: <Widget>[
                                child: CustomScrollView(slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // MyHeader(
                                          //   image: "assets/icons/world.svg",
                                          //   textTop: "COVID-19",
                                          //   textBottom: "Spread",
                                          //   iconleft: true,
                                          //   offset: offset,
                                          // ),
                                          Padding(padding: EdgeInsets.all(20)),
                                          Center(
                                            child: Text(
                                              'History',
                                              style: TextStyle(
                                                color: gold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(20)),

                                          Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    // width: 3500,
                                                    padding: EdgeInsets.all(20),
                                                    color: Colors.grey[700],
                                                    child: DataTable(
                                                      sortColumnIndex: 0,
                                                      sortAscending: true,
                                                      columns: [
                                                        DataColumn(
                                                          label: Text(
                                                            'No DO',
                                                            style: TextStyle(
                                                              color: gold,
                                                              fontSize: 18.0,
                                                            ),
                                                          ),
                                                          numeric: false,
                                                          tooltip: "No DO",
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            'Produk',
                                                            style: TextStyle(
                                                              color: gold,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          numeric: true,
                                                          tooltip: "Date Start",
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            'Kwantitas',
                                                            style: TextStyle(
                                                              color: gold,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          numeric: true,
                                                          tooltip: "Date End",
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            'Dikirim Dengan',
                                                            style: TextStyle(
                                                              color: gold,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          numeric: true,
                                                          tooltip: "Product",
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            'Dikirim Lewat',
                                                            style: TextStyle(
                                                              color: gold,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          numeric: true,
                                                          tooltip: "Quantity",
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            'No Kendaraan',
                                                            style: TextStyle(
                                                              color: gold,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          numeric: true,
                                                          tooltip:
                                                              "Shipped With",
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            'Bast      ',
                                                            style: TextStyle(
                                                              color: gold,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          numeric: true,
                                                          tooltip:
                                                              "Shipped Via",
                                                        ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'No Vehicles',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "No Vehicles",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'KM Start',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip: "KM Start",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'KM End',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip: "KM End",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'SG Meter',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip: "SG Meter",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Top Seal',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip: "Top Seal",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Bottom Seal',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "Bottom Seal",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Temperature',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "Temperature",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Departure Time',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "Departure Time",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Arrival Time',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "Arrival Time",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Unloading Start Time',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "Unloading Start Time",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Unloading End Time',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "Unloading End Time",
                                                        // ),
                                                        // DataColumn(
                                                        //   label: Text(
                                                        //     'Departure Time Depot',
                                                        //     style: TextStyle(
                                                        //       color: gold,
                                                        //       fontSize: 16.0,
                                                        //     ),
                                                        //   ),
                                                        //   numeric: true,
                                                        //   tooltip:
                                                        //       "Departure Time Depot",
                                                        // ),
                                                      ],
                                                      rows:
                                                          _listArrival
                                                              .listArrival
                                                              .map(
                                                                (country) =>
                                                                    DataRow(
                                                                  cells: [
                                                                    DataCell(
                                                                      Container(
                                                                        width:
                                                                            200,
                                                                        child:
                                                                            Text(
                                                                          country
                                                                              .deliveryOrderNumber,
                                                                          softWrap:
                                                                              true,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataCell(
                                                                      Container(
                                                                        width:
                                                                            100.0,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            country.product.toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataCell(
                                                                      Container(
                                                                        width:
                                                                            100.0,
                                                                        child: Center(
                                                                            child: Text(
                                                                          country
                                                                              .quantity
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    DataCell(
                                                                      Container(
                                                                        width:
                                                                            100.0,
                                                                        child: Center(
                                                                            child: Text(
                                                                          country
                                                                              .shippedWith
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    DataCell(
                                                                      Container(
                                                                        width:
                                                                            100.0,
                                                                        child: Center(
                                                                            child: Text(
                                                                          country
                                                                              .shippedVia
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    DataCell(
                                                                      Container(
                                                                        width:
                                                                            100.0,
                                                                        child: Center(
                                                                            child: Text(
                                                                          country
                                                                              .noVehicles
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    DataCell(
                                                                      Center(
                                                                          child: Container(
                                                                              padding: EdgeInsets.only(left: 25),
                                                                              width: 100.0,
                                                                              child: Image.network(
                                                                                country.bast.toString(),
                                                                                // width: 100,
                                                                              ))),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => Bast(
                                                                                      url: country.bast.toString(),
                                                                                    )));
                                                                      },
                                                                    ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .noVehicles
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .kmStart
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .kmEnd
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .sgMeter
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .topSeal
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .bottomSeal
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .temperature
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .departureTime
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .arrivalTime
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .unloadingStartTime
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .unloadingEndTime
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                    // DataCell(
                                                                    //   Center(
                                                                    //     child:
                                                                    //         Text(
                                                                    //       country
                                                                    //           .departureTimeDepot
                                                                    //           .toString(),
                                                                    //       style:
                                                                    //           TextStyle(fontWeight: FontWeight.bold),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                              )
                                                              .toList(),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          // SizedBox(height: 500),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount: 1,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
