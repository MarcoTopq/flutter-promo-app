import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
            'All Arrival',
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
                                                      _listArrival
                                                          .listArrival[index]
                                                          .deliveryDate
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      _listArrival
                                                          .listArrival[index]
                                                          .distributor
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      _listArrival
                                                          .listArrival[index]
                                                          .distributor
                                                          .address
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      _listArrival
                                                          .listArrival[index]
                                                          .distributor
                                                          .phone
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ))));
                                  },
                                  childCount: _listArrival.listArrival.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
