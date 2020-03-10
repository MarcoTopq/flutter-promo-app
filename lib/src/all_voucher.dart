import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/detail_voucher.dart';
import 'package:warnakaltim/src/model/voucherModel.dart';

class VoucherUser extends StatefulWidget {
  @override
  _VoucherUserState createState() => _VoucherUserState();
}

class _VoucherUserState extends State<VoucherUser> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<VoucherDetailModel>(context, listen: false)
        .fetchDatVoucherDetail();
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
            'Voucher History',
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
                future: Provider.of<VoucherDetailModel>(context, listen: false)
                    .fetchDatVoucherDetail(),
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
                    return Consumer<VoucherDetailModel>(
                        builder: (ctx, _listVoucher, child) => Center(
                              // child: Stack(children: <Widget>[
                              child: ListView.builder(
                                  itemCount: _listVoucher.listAllVoucher.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // children: <Widget>[
                                    // Padding(padding: EdgeInsets.all(10)),
                                    // Container(
                                    //     child: ListTile(
                                    //   leading: Icon(
                                    //     Icons.monetization_on,
                                    //     color: gold,
                                    //     size: 30,
                                    //   ),
                                    //   title: Text(
                                    //     '1500 Poin',
                                    //     // textAlign: TextAlign.center,
                                    //     style: new TextStyle(
                                    //       fontSize: 20.0,
                                    //       color: gold,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ));
                                    // Padding(padding: EdgeInsets.all(20)),
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailVoucher(
                                                        id: _listVoucher
                                                            .listAllVoucher[0]
                                                            .promo.id
                                                            .toString()),
                                              ));
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            width: 200,
                                            height: 400,
                                            // color: Colors.red,
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  // side: BorderSide(
                                                  //   color: Colors.white,
                                                  //   width: 5.0,
                                                  // ),
                                                ),
                                                color: Colors.white,
                                                child: Stack(
                                                  // fit: StackFit.loose,
                                                  children: <Widget>[
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Image.network(
                                                          'http://rpm.kantordesa.com/uploads/' +
                                                              _listVoucher
                                                                  .listAllVoucher[
                                                                      index]
                                                                  .promo
                                                                  .image
                                                                  .toString(),
                                                          width: 400,
                                                          // height: 300,
                                                          fit: BoxFit.cover,
                                                        )),
                                                    Positioned(
                                                        bottom: -10.0,
                                                        left: 0.0,
                                                        right: 0.0,
                                                        child: Container(
                                                            // width: 3500,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            decoration:
                                                                new BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  new BorderRadius
                                                                      .only(
                                                                topLeft:
                                                                    const Radius
                                                                            .circular(
                                                                        60.0),
                                                                topRight:
                                                                    const Radius
                                                                            .circular(
                                                                        10.0),
                                                                bottomLeft:
                                                                    const Radius
                                                                            .circular(
                                                                        10.0),
                                                                bottomRight:
                                                                    const Radius
                                                                            .circular(
                                                                        10.0),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5)),
                                                                Expanded(
                                                                    child:
                                                                        Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                        _listVoucher.listAllVoucher[index].promo.point.toString() +
                                                                            ' Point',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        style: TextStyle(
                                                                            color:
                                                                                gold,
                                                                            fontSize:
                                                                                25)),
                                                                    Text(
                                                                        _listVoucher
                                                                            .listAllVoucher[
                                                                                index]
                                                                            .promo
                                                                            .name,
                                                                        style: TextStyle(
                                                                            color:
                                                                                gold,
                                                                            fontSize:
                                                                                15))
                                                                  ],
                                                                )),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10)),
                                                                Container(
                                                                    width: 100,
                                                                    height: 50,
                                                                    child: Card(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          side:
                                                                              BorderSide(
                                                                            color:
                                                                                gold,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                        ),
                                                                        color: Colors
                                                                            .white,
                                                                        child: Center(
                                                                            child:
                                                                                Text('Detail', style: TextStyle(color: gold, fontSize: 20))))),
                                                              ],
                                                            ))),
                                                  ],
                                                ))));
                                  }),
                            ));
                  }
                })));
  }
}
