import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/model/HomeAgenModel.dart';
import 'package:warnakaltim/src/model/HomeUserModel.dart';
import 'package:warnakaltim/src/model/distributorModel.dart';

class AgenDetail extends StatefulWidget {
  @override
  _AgenDetailState createState() => _AgenDetailState();
}

class _AgenDetailState extends State<AgenDetail> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<AgenHomeModel>(context, listen: false)
        .fetchDataAgenHome();
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
            'Contact Agen',
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
                future: Provider.of<AgenHomeModel>(context, listen: false)
                    .fetchDataAgenHome(),
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
                    return Consumer<AgenHomeModel>(
                        builder: (ctx, _listDistributorDetail, child) => Center(
                                child: ListView(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(20)),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.network(
                                            _listDistributorDetail
                                                .listHomeDetail[0]
                                                .user
                                                .agen
                                                .logo,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          )),
                                    ),
                                    Padding(padding: EdgeInsets.all(20)),
                                    ListTile(
                                      leading: Icon(
                                        Icons.person,
                                        color: gold,
                                        size: 50,
                                      ),
                                      title: Text(
                                        'Name',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail
                                            .listHomeDetail[0].user.agen.name
                                            .toString(),
                                        style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      endIndent: 70.0,
                                      indent: 70.0,
                                      height: 1.0,
                                      color: gold,
                                    ),
                                    // Padding(padding: EdgeInsets.all(20)),
                                    // ListTile(
                                    //   leading: Icon(
                                    //     Icons.mail,
                                    //     color: gold,
                                    //     size: 50,
                                    //   ),
                                    //   title: Text(
                                    //     'Email',
                                    //     style: new TextStyle(
                                    //       fontSize: 15.0,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    //   subtitle: Text(
                                    //     _listDistributorDetail.listHomeDetail[0]
                                    //                 .user.agen.phone ==
                                    //             "null"
                                    //         ? " - "
                                    //         : _listDistributorDetail
                                    //             .listHomeDetail[0]
                                    //             .user
                                    //             .agen
                                    //             .phone,
                                    //     style: new TextStyle(
                                    //       fontSize: 20.0,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    // ),
                                    // Divider(
                                    //   endIndent: 70.0,
                                    //   indent: 70.0,
                                    //   height: 1.0,
                                    //   color: gold,
                                    // ),
                                    Padding(padding: EdgeInsets.all(20)),
                                    ListTile(
                                      leading: Icon(
                                        Icons.phone,
                                        color: gold,
                                        size: 50,
                                      ),
                                      title: Text(
                                        'Phone',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail.listHomeDetail[0]
                                                    .user.agen.phone
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listHomeDetail[0]
                                                .user
                                                .agen
                                                .phone
                                                .toString(),
                                        style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      endIndent: 70.0,
                                      indent: 70.0,
                                      height: 1.0,
                                      color: gold,
                                    ),
                                    // Padding(padding: EdgeInsets.all(20)),
                                    // ListTile(
                                    //   leading: Icon(
                                    //     Icons.desktop_windows,
                                    //     color: gold,
                                    //     size: 50,
                                    //   ),
                                    //   title: Text(
                                    //     'member',
                                    //     style: new TextStyle(
                                    //       fontSize: 15.0,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    //   subtitle: Text(
                                    //     _listDistributorDetail.listHomeDetail[0]
                                    //                 .user.agen.member
                                    //                 .toString() ==
                                    //             "null"
                                    //         ? " - "
                                    //         : _listDistributorDetail
                                    //             .listHomeDetail[0]
                                    //             .user
                                    //             .agen
                                    //             .member
                                    //             .toString(),
                                    //     style: new TextStyle(
                                    //       fontSize: 20.0,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    // ),
                                    // Divider(
                                    //   endIndent: 70.0,
                                    //   indent: 70.0,
                                    //   height: 1.0,
                                    //   color: gold,
                                    // ),
                                    Padding(padding: EdgeInsets.all(20)),
                                    ListTile(
                                      leading: Icon(
                                        Icons.map,
                                        color: gold,
                                        size: 50,
                                      ),
                                      title: Text(
                                        'Address',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail.listHomeDetail[0]
                                                    .user.agen.address
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listHomeDetail[0]
                                                .user
                                                .agen
                                                .address
                                                .toString(),
                                        style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      endIndent: 70.0,
                                      indent: 70.0,
                                      height: 1.0,
                                      color: gold,
                                    ),
                                  ],
                                ),
                              ],
                            )));
                  }
                })));
  }
}
