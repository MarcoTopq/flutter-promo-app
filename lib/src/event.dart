import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Events'),
        ),
        // key: _scaffoldKey,
        backgroundColor: Colors.grey[850],
        // appBar: AppBar(title: Text('WARNA KALTIM')),
        body: Center(
            child: CustomScrollView(slivers: <Widget>[
          ///First sliver is the App Bar
          // SliverAppBar(
          //   ///Properties of app bar
          //   backgroundColor: Colors.black.withOpacity(0.5),
          //   floating: false,
          //   pinned: true,
          //   expandedHeight: MediaQuery.of(context).size.width / 20,
          // leading: new IconButton(
          //     icon: new Icon(Icons.menu, color: gold),
          //     onPressed: () => _scaffoldKey.currentState.openDrawer()),

          ///Properties of the App Bar when it is expanded
          // flexibleSpace: FlexibleSpaceBar(
          //   centerTitle: true,
          //   title: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Padding(
          //           padding: EdgeInsets.only(
          //               top: MediaQuery.of(context).size.height / 100)),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: <Widget>[
          //           Image.asset(
          //             'assets/pertamina.png',
          //             fit: BoxFit.cover,
          //             width: MediaQuery.of(context).size.width * 0.3,
          //             // height: MediaQuery.of(context).size.height / 200,
          //           ),
          //         ],
          //       ),
          //       Padding(
          //           padding: EdgeInsets.all(
          //               MediaQuery.of(context).size.width / 10)),
          //       Expanded(
          //           child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: <Widget>[
          //           Text('PT. PERTAMINA',
          //               style: TextStyle(color: Colors.white, fontSize: 15)),
          //           Text('Reward Point Rp ',
          //               style: TextStyle(color: Colors.white, fontSize: 10)),
          //         ],
          //       ))
          //     ],
          //   ),
          //   titlePadding: EdgeInsets.fromLTRB(
          //       MediaQuery.of(context).size.width / 8,
          //       0.0,
          //       MediaQuery.of(context).size.width / 100,
          //       MediaQuery.of(context).size.width / 100),
          // Text("Warna Kaltim",
          //     style: TextStyle(
          //       color: gold,
          //       fontSize: 20.0,
          //       fontWeight: FontWeight.bold,
          //       // fontFamily: Utils.ubuntuRegularFont),
          //     )),
          // background: Container(
          //   decoration: BoxDecoration(
          //     border: Border(
          //       top: BorderSide(
          // color: gold,
          //       width: 1.0,
          //     ),
          //   ),
          // ),
          //       ),
          //     ),
          //   ),
          // ])));
        ])));
  }
}
