import 'package:flutter/material.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/all_event.dart';
import 'package:warnakaltim/src/all_news.dart';
import 'package:warnakaltim/src/all_promo.dart';
import 'package:warnakaltim/src/detail_Promo.dart';
import 'package:warnakaltim/src/detail_news.dart';
import 'package:warnakaltim/src/event.dart';
// import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:warnakaltim/src/login.dart';
import 'package:warnakaltim/src/model/HomeModel.dart';
import 'package:warnakaltim/src/model/allEventModel.dart';
import 'package:warnakaltim/src/model/allPromoModel.dart';
import 'package:warnakaltim/src/model/detailPromoModel.dart';
// import 'package:marquee/marquee.dart';
import 'package:warnakaltim/src/model/newsModel.dart';
import 'package:warnakaltim/src/profile.dart';
import 'package:warnakaltim/src/ringkasan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(MyApp());
var email;
var token;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: NewsModel(),
          ),
          ChangeNotifierProvider.value(
            value: DetailPromoModel(),
          ),
          ChangeNotifierProvider.value(
            value: HomeModel(),
          ),
          ChangeNotifierProvider.value(
            value: AllPromoModel(),
          ),
          ChangeNotifierProvider.value(
            value: EventModel(),
          ),
        ],
        child: MaterialApp(
          title: 'Warna Kaltim',
          theme: ThemeData(
              primaryColor: Colors.greenAccent[200],
              primarySwatch: MaterialColor(Colors.grey.shade200.value, {
                50: Colors.grey.shade50,
                100: Colors.grey.shade100,
                200: Colors.grey.shade200,
                300: Colors.grey.shade300,
                400: Colors.grey.shade400,
                500: Colors.grey.shade500,
                600: Colors.grey.shade600,
                700: Colors.grey.shade700,
                800: Colors.grey.shade800,
                900: Colors.grey.shade900
              }),
              fontFamily: 'OpenSans',
              backgroundColor: Color.fromRGBO(
                212,
                175,
                55,
                2,
              )),
          home: Homepage(),
        ));
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );

  // Future<void> _getToken() async {
  //   setState(() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     email = prefs.get('Email').toString();
  //     token = prefs.get('Token').toString();
  //   });
  // }

  TabController controller;
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    SimpleBarChart.withSampleData(),
    Profile(),
    Home()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // _getToken();
    // WidgetsBinding.instance.addObserver(this);
    // _refreshData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _children[_currentIndex], // new
      // ])),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        type: BottomNavigationBarType.fixed,
        elevation: 2.0,

        backgroundColor: Colors.grey[700],
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            backgroundColor: gold,
            title: Text('Home',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.border_color,
              // color: Colosrs.grey[350],
            ),
            title: Text('Ringkasan',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
              // color: Colors.grey[350],
            ),
            title: Text('Informasi',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.phone,
              // color: Colors.grey[350],
            ),
            title: Text('Service',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  final email;
  final token;
  Home({
    Key key,
    this.email,
    this.token,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<HomeModel>(context, listen: false).fetchDataHome();
  }

  @override
  void initState() {
    super.initState();
    // _getToken();
    // WidgetsBinding.instance.addObserver(this);
    _refreshData(context);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print('dapat' + email.toString());
    print('dapat' + token.toString());

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

    var gold = Color.fromRGBO(
      212,
      175,
      55,
      2,
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      // appBar: AppBar(title: Text('WARNA KALTIM')),
      body: RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: FutureBuilder(
              future: Provider.of<HomeModel>(context, listen: false)
                  .fetchDataHome(),
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
                  return Consumer<HomeModel>(
                      builder: (ctx, _listNews, child) => Center(
                              child: CustomScrollView(
                            slivers: <Widget>[
                              SliverAppBar(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                floating: false,
                                pinned: true,
                                expandedHeight:
                                    MediaQuery.of(context).size.width / 20,
                                leading: email == null
                                    ? null
                                    : new IconButton(
                                        icon: new Icon(Icons.menu, color: gold),
                                        onPressed: () {
                                          _scaffoldKey.currentState
                                              .openDrawer();
                                        }),
                                flexibleSpace: FlexibleSpaceBar(
                                  centerTitle: true,
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            'assets/pertamina.png',
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
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
                                                            Icons.person_pin,
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
                                                    Text('PT. PERTAMINA',
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
                                    return email != null
                                        ? Container()
                                        : Container(
                                            // color: Colors.black12,
                                            padding: EdgeInsets.all(10),
                                            width: c_width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.32,
                                            child: Card(
                                                // shape: RoundedRectangleBorder(
                                                //   borderRadius:
                                                //       BorderRadius.circular(10),
                                                //   side: BorderSide(
                                                //     color: gold,
                                                //     width: 2.0,
                                                //   ),
                                                // ),
                                                color: Colors.black12,
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                20.0,
                                                                10.0,
                                                                0.0,
                                                                20.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            // ClipRRect(
                                                            //     borderRadius:
                                                            //         BorderRadius
                                                            //             .circular(
                                                            //                 50.0),
                                                            //     child: Image.asset(
                                                            //       'assets/lux.jpg',
                                                            //       fit: BoxFit.cover,
                                                            //       width: 50,
                                                            //       height: 50,
                                                            //     )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5)),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    "Good Evening",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10)),
                                                                Text("Guest",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15)),
                                                              ],
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            150,
                                                                        right:
                                                                            10)),
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: <
                                                                    Widget>[
                                                                  Text(''),
                                                                  Text("Login",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15)),
                                                                ]),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10)),
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: <Widget>[
                                                                  Text(''),
                                                                  Icon(
                                                                      Icons
                                                                          .input,
                                                                      color:
                                                                          gold,
                                                                      size: 30)
                                                                ])
                                                          ],
                                                        )),
                                                    Divider(
                                                      endIndent: 20.0,
                                                      indent: 20.0,
                                                      height: 1.0,
                                                      color: gold,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20)),
                                                    new Expanded(
                                                        child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: 2,
                                                      //  _listNews
                                                      //     .listHome[0]
                                                      //     .promo
                                                      //     .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                            width: 400,
                                                            height: a_height,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DetailPromo(id: _listNews.listHome[0].promo[index].id.toString()),
                                                                      ));
                                                                },
                                                                child: Card(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2),
                                                                      side:
                                                                          BorderSide(
                                                                        color:
                                                                            gold,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        // Image
                                                                        //     .network(
                                                                        //   _listNews
                                                                        //       .listHome[
                                                                        //           0]
                                                                        //       .promo[
                                                                        //           index]
                                                                        //       .image,
                                                                        //   fit: BoxFit
                                                                        //       .cover,
                                                                        // )
                                                                        Image
                                                                            .asset(
                                                                      'assets/iklan-pertamina.png',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ))));
                                                      },
                                                    )
                                                        //         new Swiper(
                                                        //   itemBuilder:
                                                        //       (BuildContext context,
                                                        //           int index) {
                                                        //     return new Image.asset(
                                                        //       'assets/iklan-pertamina.png',
                                                        //       fit: BoxFit.fill,
                                                        //     );
                                                        //   },
                                                        //   itemCount: 10,
                                                        //   viewportFraction: 0.8,
                                                        //   scale: 0.9,
                                                        // )
                                                        ),
                                                  ],
                                                )));
                                  },
                                  childCount: 1,
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
                                            height: 250,
                                            child: Card(
                                                color: Colors.black12,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15)),
                                                    Container(
                                                      // padding: EdgeInsets.all(),
                                                      child: Expanded(
                                                          child: Marquee(
                                                              direction: Axis
                                                                  .horizontal,
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              animationDuration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                              backDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          3000),
                                                              pauseDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          100),
                                                              // directionMarguee:
                                                              //     DirectionMarguee.oneDirection,
                                                              child: Text(
                                                                "Welcome To RPM (Reward Point Management) PT PERTAMINA PATRA NIAGA",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white),
                                                              ))),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5)),
                                                    new Expanded(
                                                        child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: 2,
                                                      //  _listNews
                                                      //     .listHome[0]
                                                      //     .promo
                                                      //     .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                            width: 400,
                                                            height: a_height,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DetailPromo(id: _listNews.listHome[0].promo[index].id.toString()),
                                                                      ));
                                                                },
                                                                child: Card(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2),
                                                                      side:
                                                                          BorderSide(
                                                                        color:
                                                                            gold,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        // Image
                                                                        //     .network(
                                                                        //   _listNews
                                                                        //       .listHome[
                                                                        //           0]
                                                                        //       .promo[
                                                                        //           index]
                                                                        //       .image,
                                                                        //   fit: BoxFit
                                                                        //       .cover,
                                                                        // )
                                                                        Image
                                                                            .asset(
                                                                      'assets/iklan-pertamina.png',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ))));
                                                      },
                                                    )
                                                        //         new Swiper(
                                                        //   itemBuilder:
                                                        //       (BuildContext context,
                                                        //           int index) {
                                                        //     return new Image.asset(
                                                        //       'assets/iklan-pertamina.png',
                                                        //       fit: BoxFit.fill,
                                                        //     );
                                                        //   },
                                                        //   itemCount: 10,
                                                        //   viewportFraction: 0.8,
                                                        //   scale: 0.9,
                                                        // )
                                                        ),

                                                    //     Column(
                                                    //   children: <Widget>[
                                                    //     Image.asset('assets/pertamina-loyalty-card.png')
                                                    //   ],
                                                    // ))
                                                  ],
                                                )));
                                  },
                                  childCount: 1,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.42,
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
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                20.0,
                                                                10.0,
                                                                0.0,
                                                                20.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/lux.jpg',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 50,
                                                                  height: 50,
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5)),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    "Good Evening",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10)),
                                                                Text("Topq",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20)),
                                                              ],
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            150,
                                                                        right:
                                                                            10)),
                                                            Icon(
                                                              Icons
                                                                  .notifications_active,
                                                              size: 30,
                                                              color: gold,
                                                            )
                                                          ],
                                                        )),
                                                    Divider(
                                                      endIndent: 20.0,
                                                      indent: 20.0,
                                                      height: 1.0,
                                                      color: gold,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20)),
                                                    Image.asset(
                                                      'assets/pertamina-loyalty-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                  ],
                                                )));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return email == null
                                      ? Container()
                                      : Container(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 10, 0, 0),
                                          child: Text(
                                            "Informasi Loyalty",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        );
                                },
                                childCount: 1,
                              )),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return email == null
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.all(10),
                                            width: c_width,
                                            height: d_height,
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
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IntrinsicHeight(
                                                        child: Row(
                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              "1230",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 30),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.all(
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        100)),
                                                            Text(
                                                              "Loyalty",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 20),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10)),
                                                          ],
                                                        )),
                                                        Container(
                                                            child:
                                                                VerticalDivider(
                                                          endIndent: 0.0,
                                                          indent: 10.0,
                                                          width: 0.0,
                                                          color: gold,
                                                        )),
                                                        Expanded(
                                                            child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              "15",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 30),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.all(
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        100)),
                                                            Text(
                                                              "Kupon",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 20),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            10)),
                                                          ],
                                                        )),
                                                      ],
                                                    )),
                                                    Divider(
                                                      endIndent: 20.0,
                                                      indent: 20.0,
                                                      height: 1.0,
                                                      color: gold,
                                                    ),
                                                    IntrinsicHeight(
                                                        child: Row(
                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      // mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Column(
                                                          children: <Widget>[
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10)),
                                                            Text(
                                                              "120",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 30),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.all(
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        100)),
                                                            Text(
                                                              "Tranksaksi",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 20),
                                                            )
                                                          ],
                                                        )),
                                                        Container(
                                                            child:
                                                                VerticalDivider(
                                                          endIndent: 10.0,
                                                          indent: 0.0,
                                                          width: 0.0,
                                                          color: gold,
                                                        )),
                                                        Expanded(
                                                            child: Column(
                                                          children: <Widget>[
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10)),

                                                            Text(
                                                              "150",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 30),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets.all(
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        100)),
                                                            Text(
                                                              "reward",
                                                              style: TextStyle(
                                                                  color: gold,
                                                                  fontSize: 20),
                                                            ),
                                                            // Padding(padding: EdgeInsets.only(bottom: 10)),
                                                          ],
                                                        )),
                                                      ],
                                                    )),
                                                  ],
                                                )),
                                          );
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Special Offers',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Padding(
                                                padding: EdgeInsets.all(20)),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllPromo(),
                                                      ));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: a_width,
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    // _listNews.listHome[0].promo.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          padding: EdgeInsets.all(10),
                                          width: a_width,
                                          height: a_height,
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPromo(
                                                              id: _listNews
                                                                  .listHome[0]
                                                                  .promo[index]
                                                                  .id
                                                                  .toString()),
                                                    ));
                                              },
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    side: BorderSide(
                                                      color: gold,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child:
                                                      // Image.network(
                                                      //   _listNews.listHome[0]
                                                      //       .promo[index].image,
                                                      //   fit: BoxFit.cover,
                                                      // )
                                                      Image.asset(
                                                    'assets/promo2.jpg',
                                                    fit: BoxFit.cover,
                                                  ))));
                                    },
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Breaking News",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Padding(
                                                padding: EdgeInsets.all(20)),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllNews(),
                                                      ));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return InkWell(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               DetailNews(
                                      //                   url: _listNews
                                      //                       .listHome[0]
                                      //                       .news[index]
                                      //                       .url
                                      //                       .toString())));
                                      // },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: b_width,
                                          height: 150,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              side: BorderSide(
                                                color: gold,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Stack(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    children: <Widget>[
                                                      // Image.network(
                                                      //     _listNews
                                                      //         .listHome[0]
                                                      //         .news[index]
                                                      //         .image
                                                      //         .toString(),
                                                      Image.asset(
                                                          'assets/news.jpg',
                                                          width: d_width,
                                                          height: c_height,
                                                          fit: BoxFit.cover),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5)),
                                                      Positioned(
                                                          top: 2.0,
                                                          left: 2.0,
                                                          child: Container(
                                                              color: Colors
                                                                  .yellow
                                                                  .withOpacity(
                                                                      0.5),
                                                              child: Padding(
                                                                padding: EdgeInsets.all(
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        150),
                                                                child: Text(
                                                                    // _listNews
                                                                    //     .listHome[
                                                                    //         0]
                                                                    //     .news[
                                                                    //         index]
                                                                    //     .category[
                                                                    //         0]
                                                                    //     .name
                                                                    //     .toString(),
                                                                    'Bencana',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black)),
                                                              ))),
                                                    ]),
                                                Padding(
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            100)),
                                                Flexible(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        // _listNews.listHome[0]
                                                        //     .news[index].title
                                                        //     .toString(),
                                                        'Produksi Anjlok karena Virus Corona, Iphone Bisa Langka di Pasaran ???',
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            // textBaseline: TextBaseline.alphabetic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10)),

                                                    Text(
                                                        // _listNews
                                                        //     .listHome[0]
                                                        //     .news[index]
                                                        //     .createdAt
                                                        //     .toString(),
                                                        '18 February 2020',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                        )),
                                                    // Text(
                                                    //   'Jakarta - Presiden Joko Widodo (Jokowi) mengunjungi kawasan Mount Ainslie di Canberra, Australia.',
                                                    //   softWrap: true,
                                                    //   overflow: TextOverflow
                                                    //       .ellipsis,
                                                    //   maxLines: 2,
                                                    // ),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          )));
                                }, childCount: 3
                                    // _listNews.listHome[0].news.length,
                                    ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 0.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Tukar Poin, yuk!",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20)),
                                            Padding(
                                                padding: EdgeInsets.all(20)),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllPromo(),
                                                      ));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                              // SliverToBoxAdapter(
                              //   child: Container(
                              //     padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 30.0),
                              //     width: 300,
                              //     height: 500,
                              // child:
                              SliverGrid(
                                // gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                                //     maxCrossAxisExtent: 200, childAspectRatio: 1),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.5),
                                ),
                                //     SliverGridDelegateWithMaxCrossAxisExtent(
                                //   maxCrossAxisExtent: 250.0,
                                //   mainAxisSpacing: 50.0,
                                //   crossAxisSpacing: 10.0,
                                //   // childAspectRatio: 4.0,
                                // ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.all(10),
                                        width: e_width,
                                        height: e_height,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPromo(),
                                                  ));
                                            },
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
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                      'assets/iklan-max.jpg',
                                                      fit: BoxFit.cover,
                                                      // width: e_width,
                                                      // height: e_height,
                                                    )))));
                                  },
                                  childCount: 4,
                                  // ),
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
                              'assets/pertamina.png',
                            ),
                            decoration: BoxDecoration(
                              color: gold,
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
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/mangas',
                                  );
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
                                leading: Icon(Icons.phone, color: gold),

                                title: Text('Contact Person Penyalur',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/mangas',
                                  );
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

                                title: Text('Contact Person',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
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
                                leading: Icon(Icons.new_releases, color: gold),

                                title: Text('Event',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllEvent()));
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
                                leading: Icon(Icons.new_releases, color: gold),
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
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.remove('Email');
                                        prefs.remove('Token');

                                        email = null;
                                        token = null;

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage()));
                                      },
                              )),
                          Padding(padding: EdgeInsets.only(top: 300)),
                          Container(
                              height: 100,
                              padding: EdgeInsets.only(top: 10),
                              decoration: new BoxDecoration(
                                  color: Colors.black12,
                                  border: new Border(
                                      bottom: new BorderSide(
                                          color: Colors.grey[850]))),
                              child: Center(
                                  child: ListTile(
                                // leading: Icon(Icons.assessment, color: gold),
                                title: Text('Build by Topq',
                                    style: TextStyle(
                                        color: gold,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text('Topq@gmail.com',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: 15,
                                      // fontWeight: FontWeight.bold
                                    )),
                                // isThreeLine: true,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/mangas',
                                  );
                                },
                              ))),
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
