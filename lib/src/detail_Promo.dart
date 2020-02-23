import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/model/detailPromoModel.dart';

class DetailPromo extends StatefulWidget {
  final String id;
  DetailPromo({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _DetailPromoState createState() => _DetailPromoState();
}

class _DetailPromoState extends State<DetailPromo> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DetailPromoModel>(context, listen: false)
        .fetchDataDetailPromo(widget.id);
  }

  @override
  void initState() {
    // this.getdata();
    super.initState();
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
                                            _listPromoDetail.listDetailPromo[0].image,
                                            height: MediaQuery.of(context).size.height * 0.3,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      )),
                                  // Expanded(
                                  //     flex: 1,
                                  //     child:
                                  SingleChildScrollView(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            _listPromoDetail.listDetailPromo[0].description,
                                            style: new TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ))),
                                ],
                              ),
                              Positioned(
                                  bottom: -10.0,
                                  left: 0.0,
                                  child: Container(
                                      width: 500,
                                      height: MediaQuery.of(context).size.height / 6,
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(_listPromoDetail.listDetailPromo[0].point.toString() +'Poin',
                                                      style: TextStyle(
                                                          color: gold,
                                                          fontSize: 30)),
                                                  Text(_listPromoDetail.listDetailPromo[0].title.toString())
                                                ],
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(50)),
                                              Container(
                                                  width: MediaQuery.of(context).size.width / 3,
                                                  height: MediaQuery.of(context).size.height / 15,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                                fontSize: 20))),
                                                  ))
                                            ]),
                                      )))
                            ]))));
                  }
                })));
  }
}
