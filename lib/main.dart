import 'package:flutter/material.dart';
import 'package:warnakaltim/src/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warna Kaltim',
      theme: ThemeData(
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
          backgroundColor: Color.fromRGBO(
            212,
            175,
            55,
            2,
          )),
      home: Home(),
    );
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

    double c_width = MediaQuery.of(context).size.width * 0.8;
    double c_height = MediaQuery.of(context).size.width * 0.4;

    double d_width = MediaQuery.of(context).size.width * 0.3;
    double d_height = MediaQuery.of(context).size.width * 0.3;

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
      body: Center(
          child: CustomScrollView(
        slivers: <Widget>[
          ///First sliver is the App Bar
          SliverAppBar(
            ///Properties of app bar
            backgroundColor: Colors.black.withOpacity(0.5),
            floating: false,
            pinned: true,
            expandedHeight: 50.0,
            leading: new IconButton(
                icon: new Icon(Icons.info, color: gold),
                onPressed: () => _scaffoldKey.currentState.openDrawer()),
            
            ///Properties of the App Bar when it is expanded
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("Warna Kaltim",
                  style: TextStyle(
                    color: gold,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    // fontFamily: Utils.ubuntuRegularFont),
                  )),
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
                    padding: EdgeInsets.all(10),
                    width: c_width,
                    height: 300,
                    child: Card(child: Image.asset('assets/warna-kaltim.png')));
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
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            child: Text("Informasi Loyalty",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: d_width,
                              height: d_height,
                              // padding: EdgeInsets.all(10),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: gold,
                                      width: 2.0,
                                    ),
                                  ),
                                  color: Colors.grey[850],
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(10)),
                                      Text(
                                        "1200",
                                        style: TextStyle(
                                            color: gold, fontSize: 30),
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Loyalty",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              width: d_width,
                              height: d_height,
                              // padding: EdgeInsets.all(10),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: gold,
                                      width: 2.0,
                                    ),
                                  ),
                                  color: Colors.grey[850],
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(10)),
                                      Text(
                                        "5",
                                        style: TextStyle(
                                            color: gold, fontSize: 30),
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Poin",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: d_width,
                              height: d_height,
                              // padding: EdgeInsets.all(10),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: gold,
                                      width: 2.0,
                                    ),
                                  ),
                                  color: Colors.grey[850],
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(10)),
                                      Text(
                                        "150",
                                        style: TextStyle(
                                            color: gold, fontSize: 30),
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Reward",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              width: d_width,
                              height: d_height,
                              // padding: EdgeInsets.all(10),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: gold,
                                      width: 2.0,
                                    ),
                                  ),
                                  color: Colors.grey[850],
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(10)),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                            color: gold, fontSize: 30),
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Text(
                                        "Kupon",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        )
                      ],
                    ));
              },
              childCount: 1,

              /// Set childCount to limit no.of items
              /// childCount: 100,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(10),
              width: b_width,
              height: b_height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
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
                          child: Image.asset('assets/iklan.png')));
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(10),
                    // width: c_width,
                    // height: c_height,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset('assets/berita.jpg',
                              width: d_width,
                              height: c_height,
                              fit: BoxFit.cover),
                          Padding(padding: EdgeInsets.all(5)),
                          Flexible(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Putusan Penghapusan afafa fafaf afaf',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      // textBaseline: TextBaseline.alphabetic,
                                      fontWeight: FontWeight.bold)),
                              Text('12-10-2020',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                    textBaseline: TextBaseline.alphabetic,
                                  )),
                              Text('Putusan Penghapusan'),
                            ],
                          ))
                        ],
                      ),
                    ));
              },
              childCount: 5,
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        // onTap: onTabTapped, // new
        // currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            backgroundColor: gold,
            title: Text('Home',
                style: TextStyle(
                  color: gold,
                )),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.border_color),
            title: Text('Ringkasan',
                style: TextStyle(
                  color: gold,
                )),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Informasi',
                style: TextStyle(
                  color: gold,
                )),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            title: Text('Service',
                style: TextStyle(
                  color: gold,
                )),
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
                      Image.asset('assets/warna-kaltim.png'),
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
                        Navigator.of(context).pushNamed(
                          '/mangas',
                        );
                      },
                    )),
              ],
            ),
          )),
    );
  }
}
