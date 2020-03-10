import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:warnakaltim/src/model/DistributorDetailModel.dart';
import 'package:warnakaltim/src/model/distributorModel.dart';

class PersonDetail extends StatefulWidget {

  @override
  _PersonDetailState createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DistributorDetailModel>(context, listen: false)
        .fetchDataDistributorDetail();
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
                future: Provider.of<DistributorDetailModel>(context, listen: false)
                    .fetchDataDistributorDetail(),
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
                    return Consumer<DistributorDetailModel>(
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
                                                .listDistributorDetail[0].employee.avatar,
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
                                        'Nama',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail
                                            .listDistributorDetail[0].employee.name,
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
                                        _listDistributorDetail.listDistributorDetail[0]
                                                    .email ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listDistributorDetail[0].email,
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
                                        'Ponsel',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail
                                                    .listDistributorDetail[0].employee.phone
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listDistributorDetail[0].employee.phone
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
                                        'Type',
                                        style: new TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _listDistributorDetail.listDistributorDetail[0]
                                                    .employee.type
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listDistributorDetail[0].employee.type
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
                                        _listDistributorDetail.listDistributorDetail[0]
                                                    .employee.address
                                                    .toString() ==
                                                "null"
                                            ? " - "
                                            : _listDistributorDetail
                                                .listDistributorDetail[0].employee.address
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
