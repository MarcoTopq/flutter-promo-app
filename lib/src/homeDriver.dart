import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toast/toast.dart';
import 'package:warnakaltim/src/all_arrival.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warnakaltim/main.dart';
import 'package:warnakaltim/src/company.dart';
import 'package:warnakaltim/src/login.dart';
import 'package:warnakaltim/src/model/HomeDriverModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:warnakaltim/src/model/driverModel.dart';
import 'package:warnakaltim/src/profileDriver.dart';
import 'package:warnakaltim/src/spring_button.dart';
import 'package:warnakaltim/src/widget.dart';

class DriverHomeDetail extends StatefulWidget {
  // final email;
  // final token;
  // DriverHomeDetail({
  //   Key key,
  //   this.email,
  //   this.token,
  // }) : super(key: key);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

Future<http.Response> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.get('Token');

  http.Response hasil =
      await http.post(Uri.decodeFull(urls + "/api/logout"), body: {
    // "email": emailController.text,
    // "old_password": oldpasswordController.text,
    // "new_password": passwordController.text
  }, headers: {
    "Accept": "application/JSON",
    "Authorization": 'Bearer ' + token
  });
  print(hasil.statusCode);
  return Future.value(hasil);
}

class _DriverHomeState extends State<DriverHomeDetail> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DriverHomeModel>(context, listen: false)
        .fetchDataDriverHome();
  }

  var releaseTime = TimeOfDay.now(); // 3:00pm
  String id;
  bool accept;
  var file;
  var data;
  var prf;

  Future<void> _getToken() async {
    setState(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prf = prefs;
      data = prefs.get('Idnya');
    });
  }

  @override
  void initState() {
    super.initState();
    accept = false;
    _getToken();
    // WidgetsBinding.instance.addObserver(this);
    // _refreshData(context);
  }

  final GlobalKey<ScaffoldState> _driverKey = new GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    print('dapat' + email.toString());
    print('dapat' + token.toString());

    double b_width = MediaQuery.of(context).size.width * 0.5;
    double b_height = MediaQuery.of(context).size.width * 0.4;

    double a_width = MediaQuery.of(context).size.width * 0.6;
    double a_height = MediaQuery.of(context).size.height* 0.5;

    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.height * 0.3;

    double d_width = MediaQuery.of(context).size.width * 0.3;
    double d_height = MediaQuery.of(context).size.height * 0.3;

    double e_width = MediaQuery.of(context).size.width * 0.3;
    double e_height = MediaQuery.of(context).size.height / 8;

    var gold = Color.fromRGBO(
      212,
      175,
      55,
      2,
    );

    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<http.Response> accepted(String id) async {
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        "Accept": "application/JSON",
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };

      http.Response hasil =
          await http.get(Uri.decodeFull(urls + "/api/driver/accept/" + id),
              // body: {
              //   "email": emailController.text,
              //   "password": passwordController.text,
              //   "fcm_token": "1212123"
              // },
              headers: headers);
      if (hasil.statusCode.toString() == '200') {
        // files = null;
        // posisi = null;
        Toast.show("Accepted succeed", context,
            duration: 10, gravity: Toast.BOTTOM);

        // await Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => DriverHomeDetail()));
      } else {
        print('Upload gagal ' + hasil.statusCode.toString());

        Toast.show("Accepted Failed ", context,
            duration: 10, gravity: Toast.BOTTOM);
      }
      return Future.value(hasil);
    }

    Future<http.Response> kirimdata(File file, String id) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.get('Token');

      print(files);
      print(file);
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        "Accept": "application/JSON",
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var mimeTypeData =
          lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]).split('/');
      var request =
          http.MultipartRequest("POST", Uri.parse(urls + "/api/driver/finish"))
            ..fields['delivery_order_id'] = id
            ..files.add(await http.MultipartFile.fromPath('bast', file.path,
                contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
      request.headers.addAll(headers);
      print(request.files);
      print(request.fields);
      // request.files.add(files);
      var response = await request.send();
      var res;
      print('Upload FIle berhasil ' + response.statusCode.toString());
      await response.stream
          .transform(utf8.decoder)
          .listen((value) => setState(() {
                    res = value.toString();
                  })
              // print(value);
              );
      print(res);
      if (response.statusCode.toString() == '200') {
        files = null;
        posisi = null;
        prefs.remove('Idnya');
        prefs.remove('deliveryOrderNumber');
        prefs.remove('salesOrderId');
        prefs.remove('noVehicles');
        prefs.remove('effectiveDateStart');
        prefs.remove('effectiveDateEnd');
        prefs.remove('product');
        prefs.remove('quantity');

        Toast.show("Upload Berhasil", context,
            duration: 10, gravity: Toast.BOTTOM);

        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DriverHomeDetail()));
      } else {
        print('Upload gagal ' + response.statusCode.toString());

        Toast.show("Upload Gagal ", context,
            duration: 10, gravity: Toast.BOTTOM);
      }
      // return Future<http.Response>(response.headers);
    }

    Future<void> _showMyDialog(
        String idxnya,
        String deliveryOrderNumber,
        String salesOrderId,
        String noVehicles,
        String effectiveDateStart,
        String effectiveDateEnd,
        String product,
        String quantity,
        index) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.green[900],
                width: 5.0,
              ),
            ),
            title: Icon(
              Icons.directions_car,
              size: 120,
              color: Colors.green[900],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Pengiriman ' + product,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),

                  Text(
                    'Apakah anda menerima pesanan pengiriman ini ?',
                  ),
                  // Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.lightBlueAccent[400],
                child: Text('Terima',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await accepted(idxnya.toString());

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    prefs.setString('Idnya', idxnya);
                    prefs.setString('deliveryOrderNumber', deliveryOrderNumber);
                    prefs.setString('salesOrderId', salesOrderId);
                    prefs.setString('noVehicles', noVehicles);
                    prefs.setString('effectiveDateStart', effectiveDateStart);
                    prefs.setString('effectiveDateEnd', effectiveDateEnd);
                    prefs.setString('product', product);
                    prefs.setString('quantity', quantity);
                    idnya = idxnya;
                    posisi = index;
                    accept = true;
                  });
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  color: Colors.red[900],
                  child: Text('Batal'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Navigator.pop(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => DriverHomeDetail()),
                    // );
                  }),
            ],
          );
        },
      );
    }

    Future<void> __showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.green[900],
                width: 5.0,
              ),
            ),
            title: Icon(
              Icons.pin_drop,
              size: 120,
              color: Colors.green[900],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Bukti Pengiriman',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  Text(
                      'Apakah anda telah sampai ditujuan & mengunggah bukti pengiriman ?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.lightBlue[400],
                child: Text('Unggah',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () async {
                  Navigator.of(context).pop();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var idDO = prefs.get('Idnya');

                  await kirimdata(files, idDO == null ? idnya : idDO)
                      .then((value) async {
                    prefs.remove('Idnya');
                    prefs.remove('deliveryOrderNumber');
                    prefs.remove('salesOrderId');
                    prefs.remove('noVehicles');
                    prefs.remove('effectiveDateStart');
                    prefs.remove('effectiveDateEnd');
                    prefs.remove('product');
                    prefs.remove('quantity');
                    print(value);
                    if (value.statusCode == 200) {
                      setState(() {
                        posisi = null;
                      });

                      print('hahahahahaahah');
                      final responseJson = json.decode(value.body);
                    } else {
                      return AlertDialog(
                        title: new Text("Penukaran Promo "
                            "Gagal !!!"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Ok"),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverHomeDetail()),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  });
                  // setState(() {
                  //   prefs.setString('Idnya', idnya);
                  //   prefs.setString('deliveryOrderNumber', deliveryOrderNumber);
                  //   prefs.setString('salesOrderId', salesOrderId);
                  //   prefs.setString('noVehicles', noVehicles);
                  //   prefs.setString('effectiveDateStart', effectiveDateStart);
                  //   prefs.setString('effectiveDateEnd', effectiveDateEnd);
                  //   prefs.setString('product', product);
                  //   prefs.setString('quantity', quantity);
                  //   idnya = idnya;
                  //   posisi = index;
                  //   accept = true;
                  // });
                  await accepted(idnya.toString()).then((value) async {
                    if (value.statusCode == 200) {
                      print('hahahahahaahah');
                      final responseJson = json.decode(value.body);
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.green[900],
                                  width: 5.0,
                                ),
                              ),
                              title: Icon(
                                Icons.check,
                                size: 120,
                                color: Colors.green[900],
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text("Upload Bast ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),

                                    Text("Telah berhasil !!!",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    // Text('Would you like to approve of this message?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  color: Colors.lightBlueAccent[400],
                                  child: new Text("Ok",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DriverHomeDetail()),
                                    );
                                  },
                                ),
                              ],
                            );
                          });
                    } else {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.red[900],
                                  width: 5.0,
                                ),
                              ),
                              title: Icon(
                                Icons.clear,
                                size: 120,
                                color: Colors.red[900],
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text("Upload Bast ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),

                                    Text("Gagal !!!",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    // Text('Would you like to approve of this message?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  color: Colors.red[900],
                                  child: new Text("Ok"),
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DriverHomeDetail()),
                                    );
                                  },
                                ),
                              ],
                            );
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => DetailPromo(
                            //             id: _listPromoDetail
                            //                 .listDetailPromo[0]
                            //                 .id
                            //                 .toString())));
                          });
                    }
                  });

                  // Navigator.of(context).pop();
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                  );
                },
              ),
              FlatButton(
                  color: Colors.red[900],
                  child: Text('Batal',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Navigator.pop(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => DriverHomeDetail()),
                    // );
                  }),
            ],
          );
        },
      );
    }

    return Scaffold(
      key: _driverKey,
      backgroundColor: Colors.grey[850],
      // appBar: AppBar(title: Text('WARNA KALTIM')),
      body: RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: FutureBuilder(
              future: Provider.of<DriverHomeModel>(context, listen: false)
                  .fetchDataDriverHome(),
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
                  return Consumer<DriverHomeModel>(
                      builder: (ctx, _listNews, child) => Center(
                              child: CustomScrollView(
                            slivers: <Widget>[
                              SliverAppBar(
                                iconTheme: IconThemeData(
                                  color: Colors.white, //change your color here
                                ),
                                backgroundColor: Colors.black,
                                floating: false,
                                pinned: true,
                                expandedHeight:
                                    MediaQuery.of(context).size.width / 20,
                                leading: email == null
                                    ? null
                                    : new IconButton(
                                        icon: new Icon(Icons.menu, color: gold),
                                        onPressed: () {
                                          _driverKey.currentState.openDrawer();
                                        }),
                                flexibleSpace: FlexibleSpaceBar(
                                  // centerTitle: true,
                                  title: Row(
                                    crossAxisAlignment: email == null
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  100)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/patra.jpg',
                                            // Expanded(
                                            //     child: Container(
                                            //         // width: 100,
                                            //         child: Image.network(
                                            //   _listNews
                                            //       .listHomeDetail[0].company.,
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            // height: MediaQuery.of(context).size.height / 200,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10)),
                                      Expanded(
                                          child: email == null
                                              ? Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      InkWell(
                                                          onTap: () async {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Login()));
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .account_circle,
                                                            color: gold,
                                                            size: 35,
                                                          ))
                                                    ],
                                                  ))
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text('Driver',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15)),
                                                    Text(
                                                        'Reward Point Management ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10)),
                                                  ],
                                                ))
                                    ],
                                  ),
                                  titlePadding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 8,
                                      0.0,
                                      MediaQuery.of(context).size.width / 100,
                                      MediaQuery.of(context).size.width / 100),
                                  background: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: gold,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return email == null
                                        ? Container()
                                        : Container(
                                            // color: Colors.black12,
                                            padding: EdgeInsets.all(10),
                                            width: c_width,
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15)),
                                                Container(
                                                  // padding: EdgeInsets.all(),
                                                  child: Marquee(
                                                      direction:
                                                          Axis.horizontal,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      animationDuration:
                                                          Duration(seconds: 3),
                                                      backDuration: Duration(
                                                          milliseconds: 3000),
                                                      pauseDuration: Duration(
                                                          milliseconds: 100),
                                                      // directionMarguee:
                                                      //     DirectionMarguee.oneDirection,
                                                      child: Text(
                                                        "Welcome to PT Pertamina Patra Niaga Loyalty Card",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: gold,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10)),
                                              ],
                                            ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              data == null
                                  ? SliverToBoxAdapter(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: a_width,
                                        height: a_height,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: posisi == null
                                              ? _listNews.listHomeDetail[0].user
                                                  .readyDeliveryOrder.length
                                              : 1,
                                          // _listNews.listHomeDetail[0].hot.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                padding: EdgeInsets.all(10),
                                                // width: a_width,
                                                // height: a_height,
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Card(
                                                        color: Colors.grey[700],
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          side: BorderSide(
                                                            color: gold,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .warning,
                                                                        color: Colors
                                                                            .yellow,
                                                                        size:
                                                                            20),
                                                                    Text(
                                                                        'Tunjukan Notifikasi ini ke Layanan Jual PPN',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold))
                                                                  ],
                                                                ),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5)),
                                                                Text(
                                                                    'No DO : ' +
                                                                        _listNews
                                                                            .listHomeDetail[
                                                                                0]
                                                                            .user
                                                                            .readyDeliveryOrder[posisi == null
                                                                                ? index
                                                                                : posisi]
                                                                            .deliveryOrderNumber,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'No SO : ' +
                                                                        _listNews
                                                                            .listHomeDetail[
                                                                                0]
                                                                            .user
                                                                            .readyDeliveryOrder[posisi == null
                                                                                ? index
                                                                                : posisi]
                                                                            .salesOrderId
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'No Kendaraan : ' +
                                                                        _listNews
                                                                            .listHomeDetail[
                                                                                0]
                                                                            .user
                                                                            .readyDeliveryOrder[posisi == null
                                                                                ? index
                                                                                : posisi]
                                                                            .noVehicles,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Estimasi Berangkat : ' +
                                                                        _listNews
                                                                            .listHomeDetail[
                                                                                0]
                                                                            .user
                                                                            .readyDeliveryOrder[posisi == null
                                                                                ? index
                                                                                : posisi]
                                                                            .effectiveDateStart,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Estimasi Tiba : ' +
                                                                        _listNews
                                                                            .listHomeDetail[
                                                                                0]
                                                                            .user
                                                                            .readyDeliveryOrder[posisi == null
                                                                                ? index
                                                                                : posisi]
                                                                            .effectiveDateEnd,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Produk : ' +
                                                                        _listNews
                                                                            .listHomeDetail[
                                                                                0]
                                                                            .user
                                                                            .readyDeliveryOrder[posisi == null
                                                                                ? index
                                                                                : posisi]
                                                                            .product,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Kwantitas : ' +
                                                                        _listNews
                                                                            .listHomeDetail[
                                                                                0]
                                                                            .user
                                                                            .readyDeliveryOrder[posisi == null
                                                                                ? index
                                                                                : posisi]
                                                                            .quantity
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            20)),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .warning,
                                                                        color: Colors
                                                                            .yellow,
                                                                        size:
                                                                            15),
                                                                    Text(
                                                                        'JANGAN DI ACCEPT SEBELUM ANDA SELESAI MELAKUKAN PENGISIAN BBM.',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold))
                                                                  ],
                                                                ),
                                                                 Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            2)),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    posisi ==
                                                                            null
                                                                        ? Container()
                                                                        : Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Container(
                                                                                width: 120,
                                                                                height: 60,
                                                                                child: SpringButton(
                                                                                  SpringButtonType.OnlyScale,
                                                                                  roundedRectButton("Upload", signUpGradients, false),
                                                                                  onTapDown: (_) async {
                                                                                    files = await FilePicker.getFile();
                                                                                    setState(() {
                                                                                      file = 1;
                                                                                      print(files);
                                                                                      print(file);
                                                                                      // data= null;
                                                                                    });
                                                                                    // _btnController
                                                                                    //     .reset();

                                                                                    // Navigator.pop(
                                                                                    //   context,
                                                                                    //   // MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                                    // );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              file == null
                                                                                  ? Container()
                                                                                  : Container(
                                                                                      padding: EdgeInsets.fromLTRB(30, 5, 5, 5),
                                                                                      child: Image.file(
                                                                                        files,
                                                                                        width: 80,
                                                                                        height: 80,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                            ],
                                                                          ),
                                                                    Padding(
                                                                        padding:
                                                                            EdgeInsets.all(5)),
                                                                    posisi !=
                                                                            null
                                                                        ? Container()
                                                                        : Container(
                                                                            width:
                                                                                120,
                                                                            height:
                                                                                60,
                                                                            child:
                                                                                SpringButton(
                                                                              SpringButtonType.OnlyScale,
                                                                              roundedRectButton("Accept", signInGradients, false),
                                                                              onTap: () async {
                                                                                await showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          side: BorderSide(
                                                                                            color: Colors.green[900],
                                                                                            width: 5.0,
                                                                                          ),
                                                                                        ),
                                                                                        title: Icon(
                                                                                          Icons.directions_car,
                                                                                          size: 120,
                                                                                          color: Colors.green[900],
                                                                                        ),
                                                                                        content: SingleChildScrollView(
                                                                                          child: ListBody(
                                                                                            children: <Widget>[
                                                                                              Text("Pengiriman Pesanan", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),

                                                                                              Text(
                                                                                                "Apakah anda sudah selesai melakukan proses pengisian dan siap untuk berangkat ke lokasi customer?",
                                                                                              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
                                                                                              ),
                                                                                              // Text('Would you like to approve of this message?'),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        actions: <Widget>[
                                                                                          new FlatButton(
                                                                                            color: Colors.lightBlue[400],
                                                                                            child: new Text("Ok",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                )),
                                                                                            onPressed: () async {
                                                                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                              setState(() {
                                                                                                prefs.setString('Idnya', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString());
                                                                                                prefs.setString('deliveryOrderNumber', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].deliveryOrderNumber.toString());
                                                                                                prefs.setString('salesOrderId', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].salesOrderId.toString());
                                                                                                prefs.setString('noVehicles', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].noVehicles.toString());
                                                                                                prefs.setString('effectiveDateStart', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateStart.toString());
                                                                                                prefs.setString('effectiveDateEnd', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateEnd.toString());
                                                                                                prefs.setString('product', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].product.toString());
                                                                                                prefs.setString('quantity', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].quantity.toString());
                                                                                                idnya = _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString();
                                                                                                posisi = index;
                                                                                                data = _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString();
                                                                                                accept = true;
                                                                                              });

                                                                                              await accepted(_listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString()).then((value) async {
                                                                                                if (value.statusCode == 200) {
                                                                                                  print('hahahahahaahah');
                                                                                                  final responseJson = json.decode(value.body);
                                                                                                  await showDialog(
                                                                                                      context: context,
                                                                                                      builder: (BuildContext context) {
                                                                                                        return AlertDialog(
                                                                                                          shape: RoundedRectangleBorder(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                            side: BorderSide(
                                                                                                              color: Colors.green[900],
                                                                                                              width: 5.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          title: Icon(
                                                                                                            Icons.check,
                                                                                                            size: 120,
                                                                                                            color: Colors.green[900],
                                                                                                          ),
                                                                                                          content: SingleChildScrollView(
                                                                                                            child: ListBody(
                                                                                                              children: <Widget>[
                                                                                                                Text("Pesanan Pengiriman ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),

                                                                                                                Text("Telah berhasil diterima !!!", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                                                                                                                // Text('Would you like to approve of this message?'),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          actions: <Widget>[
                                                                                                            new FlatButton(
                                                                                                              color: Colors.lightBlueAccent[400],
                                                                                                              child: new Text("Ok",
                                                                                                                  style: TextStyle(
                                                                                                                    color: Colors.white,
                                                                                                                  )),
                                                                                                              onPressed: () {
                                                                                                                Navigator.pop(
                                                                                                                  context,
                                                                                                                  // MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                                                                );
                                                                                                              },
                                                                                                            ),
                                                                                                          ],
                                                                                                        );
                                                                                                      });
                                                                                                } else {
                                                                                                  await showDialog(
                                                                                                      context: context,
                                                                                                      builder: (BuildContext context) {
                                                                                                        return AlertDialog(
                                                                                                          shape: RoundedRectangleBorder(
                                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                                            side: BorderSide(
                                                                                                              color: Colors.red[900],
                                                                                                              width: 5.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          title: Icon(
                                                                                                            Icons.clear,
                                                                                                            size: 120,
                                                                                                            color: Colors.red[900],
                                                                                                          ),
                                                                                                          content: SingleChildScrollView(
                                                                                                            child: ListBody(
                                                                                                              children: <Widget>[
                                                                                                                Text("Pesanan Pengiriman ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),

                                                                                                                Text("Gagal !!!", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                                                                                                                // Text('Would you like to approve of this message?'),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          actions: <Widget>[
                                                                                                            new FlatButton(
                                                                                                              color: Colors.red[900],
                                                                                                              child: new Text("Ok"),
                                                                                                              onPressed: () {
                                                                                                                Navigator.pop(
                                                                                                                  context,
                                                                                                                  // MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                                                                );
                                                                                                              },
                                                                                                            ),
                                                                                                          ],
                                                                                                        );
                                                                                                      
                                                                                                      });
                                                                                                }
                                                                                              });
                                                                                              Navigator.pop(
                                                                                                context,
                                                                                                // MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                          new FlatButton(
                                                                                            color: Colors.red[900],
                                                                                            child: new Text("Batal"),
                                                                                            onPressed: () {
                                                                                              Navigator.pop(
                                                                                                context,
                                                                                                MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                      // });
                                                                                      //
                                                                                    });
                                                                              },

                                                                              // onTap: () async {
                                                                              //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                              //   setState(() {
                                                                              //     prefs.setString('Idnya', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString());
                                                                              //     prefs.setString('deliveryOrderNumber', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].deliveryOrderNumber.toString());
                                                                              //     prefs.setString('salesOrderId', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].salesOrderId.toString());
                                                                              //     prefs.setString('noVehicles', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].noVehicles.toString());
                                                                              //     prefs.setString('effectiveDateStart', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateStart.toString());
                                                                              //     prefs.setString('effectiveDateEnd', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateEnd.toString());
                                                                              //     prefs.setString('product', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].product.toString());
                                                                              //     prefs.setString('quantity', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].quantity.toString());
                                                                              //     idnya = _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString();
                                                                              //     posisi = index;
                                                                              //     accept = true;
                                                                              //   });
                                                                              //   await accepted(_listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString());

                                                                              //   _btnController.reset();

                                                                              // Navigator.push(context,
                                                                              //     MaterialPageRoute(builder: (context) => Register()));
                                                                              // },
                                                                            ),
                                                                          )
                                                                  ],
                                                                )
                                                              ],
                                                            )))));
                                          },
                                        ),
                                      ),
                                    )
                                  : SliverToBoxAdapter(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: a_width,
                                        height: 350,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 1,
                                          // _listNews.listHomeDetail[0].hot.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                padding: EdgeInsets.all(10),
                                                // width: a_width,
                                                // height: a_height,
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Card(
                                                        color: Colors.grey[700],
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          side: BorderSide(
                                                            color: gold,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    'No DO : ' +
                                                                        prf.get(
                                                                            'deliveryOrderNumber'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'No SO : ' +
                                                                        prf.get(
                                                                            'salesOrderId'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'No Kendaraan : ' +
                                                                        prf.get(
                                                                            'noVehicles'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Estimasi Berangkat : ' +
                                                                        prf.get(
                                                                            'effectiveDateStart'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Estimasi Tiba : ' +
                                                                        prf.get(
                                                                            'effectiveDateEnd'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Produk : ' +
                                                                        prf.get(
                                                                            'product'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Text(
                                                                    'Kwantitas : ' +
                                                                        prf.get(
                                                                            'quantity'),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10)),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              120,
                                                                          height:
                                                                              60,
                                                                          child:
                                                                              SpringButton(
                                                                            SpringButtonType.OnlyScale,
                                                                            roundedRectButton(
                                                                                "Upload",
                                                                                signUpGradients,
                                                                                false),
                                                                            onTapDown:
                                                                                (_) async {
                                                                              files = await FilePicker.getFile();
                                                                              setState(() {
                                                                                file = 1;
                                                                                print(files);
                                                                                print(file);
                                                                              });
                                                                              // _btnController
                                                                              //     .reset();

                                                                              // Navigator.pop(
                                                                              //   context,
                                                                              //   // MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                              // );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        file == null
                                                                            ? Container()
                                                                            : Container(
                                                                                padding: EdgeInsets.fromLTRB(30, 5, 5, 5),
                                                                                child: Image.file(
                                                                                  files,
                                                                                  width: 80,
                                                                                  height: 80,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                        padding:
                                                                            EdgeInsets.all(5)),
                                                                    // posisi != null &&
                                                                    //         data ==
                                                                    //             null
                                                                    //     ? Container()
                                                                    //     : Container(
                                                                    //         width:
                                                                    //             120,
                                                                    //         height:
                                                                    //             60,
                                                                    //         child:
                                                                    //             SpringButton(
                                                                    //           SpringButtonType.OnlyScale,
                                                                    //           roundedRectButton("Accept", signInGradients, false),
                                                                    //           onTap: () async {
                                                                    //             await showDialog(
                                                                    //                 context: context,
                                                                    //                 builder: (BuildContext context) {
                                                                    //                   return AlertDialog(
                                                                    //                     shape: RoundedRectangleBorder(
                                                                    //                       borderRadius: BorderRadius.circular(10),
                                                                    //                       side: BorderSide(
                                                                    //                         color: Colors.green[900],
                                                                    //                         width: 5.0,
                                                                    //                       ),
                                                                    //                     ),
                                                                    //                     // title: Image.network(
                                                                    //                     //     _listPromoDetail
                                                                    //                     //         .listDetailPromo[
                                                                    //                     //             0]
                                                                    //                     //         .image),
                                                                    //                     content: SingleChildScrollView(
                                                                    //                       child: ListBody(
                                                                    //                         children: <Widget>[
                                                                    //                           Text("Pengiriman Pesanan", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),

                                                                    //                           Text(
                                                                    //                             "Apakah anda yakin menerima prngiriman pesanan ?",
                                                                    //                           ),
                                                                    //                           // Text('Would you like to approve of this message?'),
                                                                    //                         ],
                                                                    //                       ),
                                                                    //                     ),
                                                                    //                     actions: <Widget>[
                                                                    //                       new FlatButton(
                                                                    //                         color: Colors.lightBlue[400],
                                                                    //                         child: new Text("Ok",
                                                                    //                             style: TextStyle(
                                                                    //                               color: Colors.white,
                                                                    //                             )),
                                                                    //                         onPressed: () async {
                                                                    //                           SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                    //                           setState(() {
                                                                    //                             prefs.setString('Idnya', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString());
                                                                    //                             prefs.setString('deliveryOrderNumber', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].deliveryOrderNumber.toString());
                                                                    //                             prefs.setString('salesOrderId', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].salesOrderId.toString());
                                                                    //                             prefs.setString('noVehicles', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].noVehicles.toString());
                                                                    //                             prefs.setString('effectiveDateStart', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateStart.toString());
                                                                    //                             prefs.setString('effectiveDateEnd', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateEnd.toString());
                                                                    //                             prefs.setString('product', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].product.toString());
                                                                    //                             prefs.setString('quantity', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].quantity.toString());
                                                                    //                             idnya = _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString();
                                                                    //                             posisi = index;
                                                                    //                             accept = true;
                                                                    //                           });

                                                                    //                           await accepted(_listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString()).then((value) async {
                                                                    //                             if (value.statusCode == 200) {
                                                                    //                               print('hahahahahaahah');
                                                                    //                               final responseJson = json.decode(value.body);
                                                                    //                               await showDialog(
                                                                    //                                   context: context,
                                                                    //                                   builder: (BuildContext context) {
                                                                    //                                     return AlertDialog(
                                                                    //                                       shape: RoundedRectangleBorder(
                                                                    //                                         borderRadius: BorderRadius.circular(10),
                                                                    //                                         side: BorderSide(
                                                                    //                                           color: Colors.green[900],
                                                                    //                                           width: 5.0,
                                                                    //                                         ),
                                                                    //                                       ),
                                                                    //                                       title: Icon(
                                                                    //                                         Icons.check,
                                                                    //                                         size: 120,
                                                                    //                                         color: Colors.green[900],
                                                                    //                                       ),
                                                                    //                                       content: SingleChildScrollView(
                                                                    //                                         child: ListBody(
                                                                    //                                           children: <Widget>[
                                                                    //                                             Text("Pesanan Pengiriman ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),

                                                                    //                                             Text("Telah berhasil diterima !!!", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                                                                    //                                             // Text('Would you like to approve of this message?'),
                                                                    //                                           ],
                                                                    //                                         ),
                                                                    //                                       ),
                                                                    //                                       actions: <Widget>[
                                                                    //                                         new FlatButton(
                                                                    //                                           color: Colors.lightBlueAccent[400],
                                                                    //                                           child: new Text("Ok",
                                                                    //                                               style: TextStyle(
                                                                    //                                                 color: Colors.white,
                                                                    //                                               )),
                                                                    //                                           onPressed: () {
                                                                    //                                             Navigator.pop(
                                                                    //                                               context,
                                                                    //                                               // MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                    //                                             );
                                                                    //                                           },
                                                                    //                                         ),
                                                                    //                                       ],
                                                                    //                                     );
                                                                    //                                   });
                                                                    //                             } else {
                                                                    //                               await showDialog(
                                                                    //                                   context: context,
                                                                    //                                   builder: (BuildContext context) {
                                                                    //                                     return AlertDialog(
                                                                    //                                       shape: RoundedRectangleBorder(
                                                                    //                                         borderRadius: BorderRadius.circular(10),
                                                                    //                                         side: BorderSide(
                                                                    //                                           color: Colors.red[900],
                                                                    //                                           width: 5.0,
                                                                    //                                         ),
                                                                    //                                       ),
                                                                    //                                       title: Icon(
                                                                    //                                         Icons.clear,
                                                                    //                                         size: 120,
                                                                    //                                         color: Colors.red[900],
                                                                    //                                       ),
                                                                    //                                       content: SingleChildScrollView(
                                                                    //                                         child: ListBody(
                                                                    //                                           children: <Widget>[
                                                                    //                                             Text("Pesanan Pengiriman ", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),

                                                                    //                                             Text("Gagal !!!", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                                                                    //                                             // Text('Would you like to approve of this message?'),
                                                                    //                                           ],
                                                                    //                                         ),
                                                                    //                                       ),
                                                                    //                                       actions: <Widget>[
                                                                    //                                         new FlatButton(
                                                                    //                                           color: Colors.red[900],
                                                                    //                                           child: new Text("Ok"),
                                                                    //                                           onPressed: () {
                                                                    //                                             Navigator.pop(
                                                                    //                                               context,
                                                                    //                                               MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                    //                                             );
                                                                    //                                           },
                                                                    //                                         ),
                                                                    //                                       ],
                                                                    //                                     );
                                                                    //                                     // Navigator.pushReplacement(
                                                                    //                                     //     context,
                                                                    //                                     //     MaterialPageRoute(
                                                                    //                                     //         builder: (context) => DetailPromo(
                                                                    //                                     //             id: _listPromoDetail
                                                                    //                                     //                 .listDetailPromo[0]
                                                                    //                                     //                 .id
                                                                    //                                     //                 .toString())));
                                                                    //                                   });
                                                                    //                             }
                                                                    //                           });
                                                                    //                           Navigator.pop(
                                                                    //                             context,
                                                                    //                             MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                                    //                           );
                                                                    //                         },
                                                                    //                       ),
                                                                    //                       new FlatButton(
                                                                    //                         color: Colors.red[900],
                                                                    //                         child: new Text("Batal"),
                                                                    //                         onPressed: () {
                                                                    //                           // Navigator
                                                                    //                           //     .pop(
                                                                    //                           //   context,
                                                                    //                           //   MaterialPageRoute(
                                                                    //                           //       builder: (context) =>
                                                                    //                           //           Driver()),
                                                                    //                           // );
                                                                    //                         },
                                                                    //                       ),
                                                                    //                     ],
                                                                    //                   );
                                                                    //                   // });
                                                                    //                   //
                                                                    //                 });
                                                                    //           },
                                                                    //           // _showMyDialog(_listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString(), _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].deliveryOrderNumber.toString(), _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].salesOrderId.toString(), _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].noVehicles.toString(), _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateStart.toString(), _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateEnd.toString(), _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].product.toString(), _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].quantity.toString(), index),
                                                                    //           // onTap: () => _showMyDialog('minyak')
                                                                    //           //  async {
                                                                    //           //             SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                    //           //             setState(() {
                                                                    //           //               prefs.setString('Idnya', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString());
                                                                    //           //               prefs.setString('deliveryOrderNumber', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].deliveryOrderNumber.toString());
                                                                    //           //               prefs.setString('salesOrderId', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].salesOrderId.toString());
                                                                    //           //               prefs.setString('noVehicles', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].noVehicles.toString());
                                                                    //           //               prefs.setString('effectiveDateStart', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateStart.toString());
                                                                    //           //               prefs.setString('effectiveDateEnd', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].effectiveDateEnd.toString());
                                                                    //           //               prefs.setString('product', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].product.toString());
                                                                    //           //               prefs.setString('quantity', _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].quantity.toString());
                                                                    //           //               idnya = _listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString();
                                                                    //           //               posisi = index;
                                                                    //           //               accept = true;
                                                                    //           //             });
                                                                    //           //             await accepted(_listNews.listHomeDetail[0].user.readyDeliveryOrder[index].id.toString());

                                                                    //           // _btnController.reset();

                                                                    //           // Navigator.push(context,
                                                                    //           //     MaterialPageRoute(builder: (context) => Register()));
                                                                    //           // },
                                                                    //         ),
                                                                    //       )
                                                                  ],
                                                                )
                                                              ],
                                                            )))));
                                          },
                                        ),
                                      ),
                                    ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return email == null
                                        ? Container()
                                        : Container(
                                            // color: Colors.black12,
                                            padding: EdgeInsets.all(10),
                                            // width: c_width,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.42,
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
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                20.0,
                                                                10.0,
                                                                20.0,
                                                                20.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            // ClipRRect(
                                                            //     borderRadius:
                                                            //         BorderRadius
                                                            //             .circular(
                                                            //                 50.0),
                                                            //     child: Image
                                                            //         .network(
                                                            //       _listNews
                                                            //           .listHomeDetail[
                                                            //               0]
                                                            //           .driver
                                                            //           .driver
                                                            //           .avatar,
                                                            //       fit: BoxFit
                                                            //           .cover,
                                                            //       width: 50,
                                                            //       height: 50,
                                                            //     )),
                                                            // Padding(
                                                            //     padding: EdgeInsets
                                                            //         .only(
                                                            //             left:
                                                            //                 5)),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    releaseTime.hour.toInt() <=
                                                                            12
                                                                        ? "Good Morning"
                                                                        : releaseTime.hour.toInt() <=
                                                                                18
                                                                            ? 'Good Afternoon'
                                                                            : "Good Evening",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10)),
                                                                // Text(
                                                                //     _listNews
                                                                //         .listHomeDetail[
                                                                //             0]
                                                                //         .driver
                                                                //         .driver
                                                                //         .name,
                                                                //     style: TextStyle(
                                                                //         color: Colors
                                                                //             .white,
                                                                //         fontSize:
                                                                //             15)),
                                                              ],
                                                            ),
                                                            // Padding(
                                                            //     padding: EdgeInsets
                                                            //         .only(
                                                            //             left:
                                                            //                 60,
                                                            //             right:
                                                            //                 20)),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                AllArrivalDetail(),
                                                                          ));
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .notifications_active,
                                                                      size: 30,
                                                                      color:
                                                                          gold,
                                                                    )),
                                                                Text(
                                                                  "History",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color:
                                                                          gold),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                    Divider(
                                                      endIndent: 20.0,
                                                      indent: 20.0,
                                                      height: 1.0,
                                                      thickness: 5,
                                                      color: gold,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10)),
                                                    // Image.asset(
                                                    //   'assets/pertamina-loyalty-card.png',
                                                    //   fit: BoxFit.cover,
                                                    // )
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width: 200,
                                                      height: 200,
                                                      child: RawMaterialButton(
                                                        onPressed: () =>
                                                            // _showMyDialog(),
                                                            // async {
                                                            __showMyDialog(),

                                                        // SharedPreferences
                                                        //     prefs =
                                                        //     await SharedPreferences
                                                        //         .getInstance();
                                                        // var idDO = prefs
                                                        //     .get('Idnya');

                                                        // await kirimdata(
                                                        //         files,
                                                        //         idDO == null
                                                        //             ? idnya
                                                        //             : idDO)
                                                        //     .then(
                                                        //         (value) async {
                                                        //   prefs.remove(
                                                        //       'Idnya');
                                                        //   prefs.remove(
                                                        //       'deliveryOrderNumber');
                                                        //   prefs.remove(
                                                        //       'salesOrderId');
                                                        //   prefs.remove(
                                                        //       'noVehicles');
                                                        //   prefs.remove(
                                                        //       'effectiveDateStart');
                                                        //   prefs.remove(
                                                        //       'effectiveDateEnd');
                                                        //   prefs.remove(
                                                        //       'product');
                                                        //   prefs.remove(
                                                        //       'quantity');
                                                        //   print(value);
                                                        //   if (value
                                                        //           .statusCode ==
                                                        //       200) {
                                                        //     setState(() {
                                                        //       posisi = null;
                                                        //     });

                                                        //     print(
                                                        //         'hahahahahaahah');
                                                        //     final responseJson =
                                                        //         json.decode(
                                                        //             value
                                                        //                 .body);
                                                        //   } else {
                                                        //     showDialog(
                                                        //         context:
                                                        //             context,
                                                        //         builder:
                                                        //             (BuildContext
                                                        //                 context) {
                                                        //           return AlertDialog(
                                                        //             title: new Text(
                                                        //                 "Penukaran Promo "
                                                        //                 "Gagal !!!"),
                                                        //             actions: <
                                                        //                 Widget>[
                                                        //               new FlatButton(
                                                        //                 child:
                                                        //                     new Text("Ok"),
                                                        //                 onPressed:
                                                        //                     () {
                                                        //                   Navigator.pop(
                                                        //                     context,
                                                        //                     MaterialPageRoute(builder: (context) => DriverHomeDetail()),
                                                        //                   );
                                                        //                 },
                                                        //               ),
                                                        //             ],
                                                        //           );
                                                        //         });
                                                        //   }
                                                        // });
                                                        // },
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.person_pin,
                                                              color: Colors
                                                                  .blue[900]
                                                                  .withOpacity(
                                                                      0.5),
                                                              size: 80.0,
                                                            ),
                                                            Text(
                                                              "Arrive",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                          .blue[
                                                                      900]),
                                                            ),
                                                          ],
                                                        ),
                                                        shape: new CircleBorder(
                                                          side: BorderSide(
                                                            color: gold,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        elevation: 2.0,
                                                        fillColor: Colors.white,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                      ),
                                                    ),
                                                  ],
                                                )));
                                  },
                                  childCount: 1,
                                ),
                              ),
                            ],
                          )));
                }
              })),

      drawer: email == null
          ? null
          : Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey[
                    850], //This will change the drawer background to blue.
                //other styles
              ),
              child: email == null
                  ? Text('')
                  : Drawer(
                      elevation: 12,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          DrawerHeader(
                            child:
                                // Text("data"),
                                Image.asset(
                              'assets/patra.jpg',
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(Icons.perm_identity, color: gold),
                                title: Text('Company Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CompanyDetail(url: pdf)));
                                },
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(Icons.phone_android, color: gold),

                                title: Text('Profile',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DriverDetail()));
                                },
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: ListTile(
                                leading: Icon(
                                    email == null ? Icons.input : Icons.input,
                                    color: gold),
                                title: email == null
                                    ? Text('Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))
                                    : Text('Logout',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),

                                // isThreeLine: true,
                                onTap: email == null
                                    ? () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      }
                                    : () async {
                                        await logout();
                                        // setState(() async{
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.remove('Email');
                                        prefs.remove('Token');
                                        prefs.remove('Idnya');
                                        prefs.remove('deliveryOrderNumber');
                                        prefs.remove('salesOrderId');
                                        prefs.remove('noVehicles');
                                        prefs.remove('effectiveDateStart');
                                        prefs.remove('effectiveDateEnd');
                                        prefs.remove('product');
                                        prefs.remove('quantity');

                                        login = false;
                                        email = null;
                                        token = null;
                                        data = null;
                                        // });

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage()));
                                      },
                              )),
                          Padding(padding: EdgeInsets.only(top: 300)),
                        ],
                      ),
                    )),
    );
    //   }
    // })),

    // floatingActionButton: FloatingActionButton(onPressed: null, child: Icon(Icons.mood_bad,)),
    // );
  }
}
