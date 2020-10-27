import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/model/HomeUserModel.dart';
import 'package:warnakaltim/src/model/distributorModel.dart';
import 'package:warnakaltim/src/spring_button.dart';
import 'package:warnakaltim/src/updateProfile.dart';
import 'package:warnakaltim/src/widget.dart';

class PersonDetail extends StatefulWidget {
  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<UserHomeModel>(context, listen: false)
        .fetchDataUserHome();
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
            'Contact Person',
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
                future: Provider.of<UserHomeModel>(context, listen: false)
                    .fetchDataUserHome(),
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
                    return Consumer<UserHomeModel>(
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
                                                .customer
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
                                        _listDistributorDetail.listHomeDetail[0]
                                            .user.customer.name
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
                                    Padding(padding: EdgeInsets.all(20)),
                                    ListTile(
                                      leading: Icon(
                                        Icons.mail,
                                        color: gold,
                                        size: 50,
                                      ),
                                      title: Text(
                                        'Email',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail.listHomeDetail[0]
                                                    .user.email ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listHomeDetail[0].user.email,
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
                                                    .user.customer.phone
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listHomeDetail[0]
                                                .user
                                                .customer
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
                                    Padding(padding: EdgeInsets.all(20)),
                                    ListTile(
                                      leading: Icon(
                                        Icons.desktop_windows,
                                        color: gold,
                                        size: 50,
                                      ),
                                      title: Text(
                                        'member',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail.listHomeDetail[0]
                                                    .user.customer.member
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listHomeDetail[0]
                                                .user
                                                .customer
                                                .member
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
                                                    .user.customer.address
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listHomeDetail[0]
                                                .user
                                                .customer
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
                                    Padding(padding: EdgeInsets.all(20)),
                                    Container(
                                      // width: 120,
                                      // height: 60,
                                      child: SpringButton(
                                          SpringButtonType.OnlyScale,
                                          roundedRectButton(
                                              "Update Email & Password",
                                              signInGradients,
                                              false), onTapDown: (_) async {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => UpdateProfile(
                                                      email:
                                                          _listDistributorDetail
                                                              .listHomeDetail[0]
                                                              .user
                                                              .email)));
                                        });
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            )));
                  }
                })));
  }
}
