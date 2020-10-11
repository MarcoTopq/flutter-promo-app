import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/deliveryDetail.dart';
import 'package:warnakaltim/src/detailDo.dart';
import 'package:warnakaltim/src/model/salesOrderModel.dart';
import 'package:warnakaltim/src/spring_button.dart';
import 'package:warnakaltim/src/widget.dart';

class SalesOrderDetail extends StatefulWidget {
  final String url;
  SalesOrderDetail({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _SalesOrderDetailState createState() => _SalesOrderDetailState();
}

class _SalesOrderDetailState extends State<SalesOrderDetail> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<SalesOrderModel>(context, listen: false)
        .fetchDataSalesOrder();
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
            'Sales Order',
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
                future: Provider.of<SalesOrderModel>(context, listen: false)
                    .fetchDataSalesOrder(),
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
                    return Consumer<SalesOrderModel>(
                        builder: (ctx, _listSalesOrder, child) => Center(
                                // child: Stack(children: <Widget>[
                                child: CustomScrollView(slivers: <Widget>[
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
                                          // Icon(
                                          //   Icons.check_circle,
                                          //   color: Colors.green,
                                          //   size: 20,
                                          // ),
                                          //     Padding(padding: EdgeInsets.all(5)),
                                          //     Text(
                                          //       _listSalesOrder
                                          //           .listSalesOrder[index]
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
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'No SO : ' +
                                                          _listSalesOrder
                                                              .listSalesOrder[
                                                                  index]
                                                              .salesOrderNumber
                                                              .toString(),
                                                      style: new TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                              _listSalesOrder.listSalesOrder
                                                          .length >
                                                      1
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          height: 60,
                                                          child: SpringButton(
                                                              SpringButtonType
                                                                  .OnlyScale,
                                                              roundedRectButton(
                                                                  "Detail DO",
                                                                  signInGradients,
                                                                  false),
                                                              onTapDown:
                                                                  (_) async {
                                                            setState(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => DetailDeliveryAgen(
                                                                          id: _listSalesOrder
                                                                              .listSalesOrder[index]
                                                                              .id
                                                                              .toString())));
                                                            });
                                                          }),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount:
                                      _listSalesOrder.listSalesOrder.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
