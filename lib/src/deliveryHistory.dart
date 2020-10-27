import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:warnakaltim/src/deliveryDetail.dart';
import 'package:warnakaltim/src/driverHistory.dart';
import 'package:warnakaltim/src/model/deliveryHistoryModel.dart';
import 'package:warnakaltim/src/rating.dart';
import 'package:warnakaltim/src/spring_button.dart';
import 'package:warnakaltim/src/widget.dart';

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
    await Provider.of<DeliveryHistoryModel>(context, listen: false)
        .fetchDataDeliveryHistory();
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
                future:
                    Provider.of<DeliveryHistoryModel>(context, listen: false)
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, top: 5, bottom: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
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
                                                                    .listDeliveryHistory[
                                                                        index]
                                                                    .deliveryOrderNumber
                                                                    .toString(),
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            'No SO : ' +
                                                                _listDelivery
                                                                    .listDeliveryHistory[
                                                                        index]
                                                                    .salesOrderId
                                                                    .toString(),
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            _listDelivery
                                                                .listDeliveryHistory[
                                                                    index]
                                                                .product
                                                                .toString(),
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            _listDelivery
                                                                .listDeliveryHistory[
                                                                    index]
                                                                .quantity
                                                                .toString()
                                                                .replaceAllMapped(
                                                                    new RegExp(
                                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                    (Match m) =>
                                                                        '${m[1]},'),
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            _listDelivery
                                                                .listDeliveryHistory[
                                                                    index]
                                                                .status
                                                                .toString(),
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                    Column(
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
                                                              onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => DetailDelivery(
                                                                        id: _listDelivery
                                                                            .listDeliveryHistory[index]
                                                                            .id
                                                                            .toString())));
                                                          }),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          height: 60,
                                                          child: SpringButton(
                                                              SpringButtonType
                                                                  .OnlyScale,
                                                              roundedRectButton(
                                                                  "History",
                                                                  signInGradients,
                                                                  false),
                                                              onTapDown:
                                                                  (_) async {
                                                            setState(() {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => DriverHistory(
                                                                          id: _listDelivery
                                                                              .listDeliveryHistory[index]
                                                                              .id
                                                                              .toString())));
                                                            });
                                                          }),
                                                        ),
                                                        _listDelivery
                                                                    .listDeliveryHistory[
                                                                        index]
                                                                    .arrivalTime ==
                                                                null
                                                            ? Container()
                                                            : Container(
                                                                width: 120,
                                                                height: 60,
                                                                child: SpringButton(
                                                                    SpringButtonType
                                                                        .OnlyScale,
                                                                    roundedRectButton(
                                                                        "Rate",
                                                                        signInGradients,
                                                                        false),
                                                                    onTapDown:
                                                                        (_) async {
                                                                  setState(() {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Rating(id: _listDelivery.listDeliveryHistory[index].id.toString())));
                                                                  });
                                                                }),
                                                              ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                  childCount:
                                      _listDelivery.listDeliveryHistory.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
