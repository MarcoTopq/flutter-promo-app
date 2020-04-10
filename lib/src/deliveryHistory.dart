import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:warnakaltim/src/model/deliveryHistoryModel.dart';

class DeliveryHistoryDetail extends StatefulWidget {
  final String url;
  DeliveryHistoryDetail({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _DeliveryHistoryDetailState createState() => _DeliveryHistoryDetailState();
}

class _DeliveryHistoryDetailState extends State<DeliveryHistoryDetail> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DeliveryHistoryModel>(context, listen: false).fetchDataDeliveryHistory();
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
            'Delivery History',
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
                future: Provider.of<DeliveryHistoryModel>(context, listen: false)
                    .fetchDataDeliveryHistory(),
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
                    return Consumer<DeliveryHistoryModel>(
                        builder: (ctx, _listDelivery, child) => Center(
                                // child: Stack(children: <Widget>[
                                child: CustomScrollView(slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.all(10),
                                        width: b_width,
                                        height: b_height,
                                        child: Card(
                                            color: Colors.blue.withOpacity(0.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              side: BorderSide(
                                                color: gold,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "Destination",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      _listDelivery
                                                          .listDeliveryHistory[index]
                                                          .deliveryDate
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      _listDelivery
                                                          .listDeliveryHistory[index]
                                                          .driver
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      _listDelivery
                                                          .listDeliveryHistory[index]
                                                          .driver
                                                          .address
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      _listDelivery
                                                          .listDeliveryHistory[index]
                                                          .driver
                                                          .phone
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ))));
                                  },
                                  childCount: _listDelivery.listDeliveryHistory.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
