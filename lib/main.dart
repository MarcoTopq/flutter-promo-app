import 'package:flutter/material.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/event.dart';
// import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:warnakaltim/src/login.dart';
// import 'package:marquee/marquee.dart';
import 'package:warnakaltim/src/model/news.dart';
import 'package:warnakaltim/src/ringkasan.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: NewsModel(),
          )
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
          home: Login(),
        ));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double b_width = MediaQuery.of(context).size.width * 0.5;
    double b_height = MediaQuery.of(context).size.width * 0.4;

    double a_width = MediaQuery.of(context).size.width * 0.6;
    double a_height = MediaQuery.of(context).size.width * 0.5;

    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.height * 0.3;

    double d_width = MediaQuery.of(context).size.width * 0.3;
    double d_height = MediaQuery.of(context).size.height * 0.15;

    double e_width = MediaQuery.of(context).size.width * 0.3;
    double e_height = MediaQuery.of(context).size.height / 8;

    var gold = Color.fromRGBO(
      212,
      175,
      55,
      2,
    );

    Future<void> _refreshData(BuildContext context) async {
      await Provider.of<NewsModel>(context, listen: false).fetchDataNews();
    }

    TabController controller;
    int _currentIndex = 0;
    final List<Widget> _children = [
      Home(),
      SimpleBarChart.withSampleData(),
      // SearchPage(),
    ];
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      // appBar: AppBar(title: Text('WARNA KALTIM')),
      body: RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: FutureBuilder(
              future: Provider.of<NewsModel>(context, listen: false)
                  .fetchDataNews(),
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
                  return Consumer<NewsModel>(
                    builder: (ctx, _listNews, child) => Center(
                        child: CustomScrollView(
                      slivers: <Widget>[
                        ///First sliver is the App Bar
                        SliverAppBar(
                          ///Properties of app bar
                          backgroundColor: Colors.black.withOpacity(0.5),
                          floating: false,
                          pinned: true,
                          expandedHeight:
                              MediaQuery.of(context).size.width / 20,
                          leading: new IconButton(
                              icon: new Icon(Icons.menu, color: gold),
                              onPressed: () =>
                                  _scaffoldKey.currentState.openDrawer()),

                          ///Properties of the App Bar when it is expanded
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                100)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/pertamina.png',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      // height: MediaQuery.of(context).size.height / 200,
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width /
                                            10)),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('PT. PERTAMINA',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                    Text('Reward Point Rp ',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10)),
                                  ],
                                ))
                              ],
                            ),
                            titlePadding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width / 8,
                                0.0,
                                MediaQuery.of(context).size.width / 100,
                                MediaQuery.of(context).size.width / 100),
                            // Text("Warna Kaltim",
                            //     style: TextStyle(
                            //       color: gold,
                            //       fontSize: 20.0,
                            //       fontWeight: FontWeight.bold,
                            //       // fontFamily: Utils.ubuntuRegularFont),
                            //     )),
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
                              return Container(
                                  // color: Colors.black12,
                                  padding: EdgeInsets.all(10),
                                  width: c_width,
                                  height: 200,
                                  child: Card(
                                      color: Colors.black12,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20.0, 20.0, 0.0, 20.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text("Good Evening",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15)),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10)),

                                                  //                 // Marquee(
                                                  //                 //   text:
                                                  //                 //       'Aplikasi ini dibuat oleh Topq',
                                                  //                 //   style: TextStyle(
                                                  //                 //       fontWeight: FontWeight.bold, color: Colors.white,
                                                  //                 //   scrollAxis: Axis.horizontal,
                                                  //                 //   crossAxisAlignment:
                                                  //                 //       CrossAxisAlignment.start,
                                                  //                 //   blankSpace: 20.0,
                                                  //                 //   velocity: 100.0,
                                                  //                 //   pauseAfterRound: Duration(seconds: 1),
                                                  //                 //   startPadding: 10.0,
                                                  //                 //   accelerationDuration:
                                                  //                 //       Duration(seconds: 1),
                                                  //                 //   accelerationCurve: Curves.linear,
                                                  //                 //   decelerationDuration:
                                                  //                 //       Duration(milliseconds: 500),
                                                  //                 //   decelerationCurve: Curves.easeOut,
                                                  //                 // ))
                                                  //                 // // Icon(Icons.notifications_active)
                                                  Container(
                                                    // padding: EdgeInsets.all(1),
                                                    child: Expanded(
                                                        child: Marquee(
                                                            direction: Axis
                                                                .horizontal,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            animationDuration:
                                                                Duration(
                                                                    seconds: 3),
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
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                            ))),
                                                  )
                                                ],
                                              )),
                                          Divider(
                                            endIndent: 2.0,
                                            indent: 5.0,
                                            // height: 4.0,
                                            color: gold,
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
                              return Container(
                                  // color: Colors.black12,
                                  padding: EdgeInsets.all(10),
                                  width: c_width,
                                  height: c_height,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: gold,
                                          width: 2.0,
                                        ),
                                      ),
                                      color: Colors.black12,
                                      child: Column(
                                        children: <Widget>[
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
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //   ///no.of items in the horizontal axis
                          //   crossAxisCount: 2,
                          // ),

                          ///Lazy building of list
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                // color: Colors.yellow,
                                width: c_width,
                                // height: 400,
                                padding: EdgeInsets.all(10),
                                child:
                                    // Stack(alignment: Alignment.topLeft, children: <Widget>[
                                    Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50),
                                        child: Text("Informasi Loyalty",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: d_width,
                                          height: d_height,
                                          // padding: EdgeInsets.all(10),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: gold,
                                                  width: 5.0,
                                                ),
                                              ),
                                              color: Colors.grey[850],
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              50)),
                                                  Text(
                                                    "1200",
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
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              )),
                                        ),
                                        // Padding(
                                        //     padding: EdgeInsets.all(
                                        //         MediaQuery.of(context).size.width / 10)),
                                        Container(
                                          width: d_width,
                                          height: d_height,
                                          // padding: EdgeInsets.all(10),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: gold,
                                                  width: 5.0,
                                                ),
                                              ),
                                              color: Colors.grey[850],
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              50)),
                                                  Text(
                                                    "5",
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
                                                    "Poin",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                    // Padding(padding: EdgeInsets.all(5)),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: d_width,
                                          height: d_height,
                                          // padding: EdgeInsets.all(10),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: gold,
                                                  width: 5.0,
                                                ),
                                              ),
                                              color: Colors.grey[850],
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              50)),
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
                                                    "Reward",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              )),
                                        ),
                                        // Padding(
                                        //     padding: EdgeInsets.all(
                                        //         MediaQuery.of(context).size.width / 10)),
                                        Container(
                                          width: d_width,
                                          height: d_height,
                                          // padding: EdgeInsets.all(10),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: gold,
                                                  width: 5.0,
                                                ),
                                              ),
                                              color: Colors.grey[850],
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              50)),
                                                  Text(
                                                    "2",
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
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                //   Positioned(
                                //       top: MediaQuery.of(context).size.width / 3.5,
                                //       left: MediaQuery.of(context).size.width / 3.1,
                                //       child: Container(
                                //           // color: Colors.yellow.withOpacity(0.5),
                                //           child: Padding(
                                //         padding: EdgeInsets.all(2),
                                //         child: Row(
                                //             crossAxisAlignment: CrossAxisAlignment.center,
                                //             mainAxisAlignment: MainAxisAlignment.center,
                                //             children: <Widget>[
                                //               Container(
                                //                 width: d_width,
                                //                 height: d_height,
                                //                 // padding: EdgeInsets.all(10),
                                //                 child: Card(
                                //                     shape: RoundedRectangleBorder(
                                //                       borderRadius:
                                //                           BorderRadius.circular(20),
                                //                       side: BorderSide(
                                //                         color: gold,
                                //                         width: 5.0,
                                //                       ),
                                //                     ),
                                //                     color: Colors.grey[850],
                                //                     child: Column(
                                //                       children: <Widget>[
                                //                         Padding(
                                //                             padding: EdgeInsets.all(
                                //                                 MediaQuery.of(context)
                                //                                         .size
                                //                                         .width /
                                //                                     100)),
                                //                         Icon(
                                //                           Icons.notifications_active,
                                //                           size: 50,
                                //                           color: gold,
                                //                         ),
                                //                         Padding(
                                //                             padding: EdgeInsets.all(
                                //                                 MediaQuery.of(context)
                                //                                         .size
                                //                                         .width /
                                //                                     100)),
                                //                         Text(
                                //                           "Reward",
                                //                           style: TextStyle(
                                //                               color: Colors.white,
                                //                               fontSize: 20),
                                //                         )
                                //                       ],
                                //                     )),
                                //               ),
                                //             ]),
                                //       ))),
                                // ])
                              );
                            },
                            childCount: 1,

                            /// Set childCount to limit no.of items
                            /// childCount: 100,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
                                child: Text("Hots Promo",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: a_width,
                            height: a_height,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                    width: a_width,
                                    height: a_height,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          side: BorderSide(
                                            color: gold,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/promo2.jpg',
                                          fit: BoxFit.cover,
                                        )));
                              },
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 2.0, 0.0, 0.0),
                                child: Text("Breaking News",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.all(10),
                                  width: b_width,
                                  height: b_height,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      side: BorderSide(
                                        color: gold,
                                        width: 2.0,
                                      ),
                                    ),
                                    // child: ListTile(
                                    //     leading: SizedBox(
                                    //   child: Image.asset(
                                    //     'assets/berita.jpg',
                                    //     width: 100,
                                    //     height: 100,
                                    //     // fit: BoxFit.cover
                                    //   ),
                                    // )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(
                                            alignment: Alignment.topLeft,
                                            children: <Widget>[
                                              Image.network(
                                                  _listNews
                                                      .listNews[index].image
                                                      .toString(),
                                                  width: d_width,
                                                  height: c_height,
                                                  fit: BoxFit.cover),
                                              Positioned(
                                                  top: 2.0,
                                                  left: 2.0,
                                                  child: Container(
                                                      color: Colors.yellow
                                                          .withOpacity(0.5),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                150),
                                                        child: Text(
                                                            _listNews
                                                                .listNews[index]
                                                                .category[0]
                                                                .name
                                                                .toString(),
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
                                                _listNews.listNews[index].title
                                                    .toString(),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    // textBaseline: TextBaseline.alphabetic,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                _listNews
                                                    .listNews[index].createdAt
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.italic,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                )),
                                            // Text(
                                            //   'Jakarta - Presiden Joko Widodo (Jokowi) mengunjungi kawasan Mount Ainslie di Canberra, Australia.',
                                            //   softWrap: true,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   maxLines: 2,
                                            // ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ));
                            },
                            childCount: _listNews.listNews.length,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
                                child: Text("Tukar Point, yuk!",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              );
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
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1),
                          // gridDelegate:
                          //     SliverGridDelegateWithMaxCrossAxisExtent(
                          //   maxCrossAxisExtent: 200.0,
                          //   mainAxisSpacing: 5.0,
                          //   crossAxisSpacing: 10.0,
                          //   // childAspectRatio: 4.0,
                          // ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.all(10),
                                  width: e_width,
                                  height: e_height,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/promo4.jpg',
                                        fit: BoxFit.fill,
                                        width: e_width,
                                        height: e_height,
                                      )));
                            },
                            childCount: 4,
                            // ),
                          ),
                        ),
                      ],
                    )),
                  );
                }
              })),
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
              color: Colors.grey[350],
            ),
            title: Text('Ringkasan',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
              color: Colors.grey[350],
            ),
            title: Text('Informasi',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.phone,
              color: Colors.grey[350],
            ),
            title: Text('Service',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
        ],
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .grey[850], //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(
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
                            bottom: new BorderSide(color: Colors.grey[850]))),
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
                            bottom: new BorderSide(color: Colors.grey[850]))),
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
                            bottom: new BorderSide(color: Colors.grey[850]))),
                    child: ListTile(
                      leading: Icon(Icons.phone_android, color: gold),

                      title: Text('Contact Person',
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
                            bottom: new BorderSide(color: Colors.grey[850]))),
                    child: ListTile(
                      leading: Icon(Icons.new_releases, color: gold),

                      title: Text('Event',
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
                            bottom: new BorderSide(color: Colors.grey[850]))),
                    child: ListTile(
                      leading: Icon(Icons.assessment, color: gold),
                      title: Text('Ringkasan Penjualan',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      // isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SimpleBarChart.withSampleData(),
                            ));
                      },
                    )),
                Padding(padding: EdgeInsets.only(top: 250)),
                Container(
                    height: 100,
                    padding: EdgeInsets.only(top: 10),
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        border: new Border(
                            bottom: new BorderSide(color: Colors.grey[850]))),
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
      // floatingActionButton: FloatingActionButton(onPressed: null, child: Icon(Icons.mood_bad,)),
    );
  }
}
