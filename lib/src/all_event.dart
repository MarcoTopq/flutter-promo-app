import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/detail_event.dart';
import 'package:warnakaltim/src/model/allEventModel.dart';

class AllEvent extends StatefulWidget {
  final String url;
  AllEvent({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _AllEventState createState() => _AllEventState();
}

class _AllEventState extends State<AllEvent> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<EventModel>(context, listen: false).fetchDataEvent();
  }

  @override
  void initState() {
    // this.getdata();
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    _refreshData(context);
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'All Event',
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
                future: Provider.of<EventModel>(context, listen: false)
                    .fetchDataEvent(),
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
                    return Consumer<EventModel>(
                        builder: (ctx, _listEvent, child) => Center(
                                // child: Stack(children: <Widget>[
                                child: CustomScrollView(slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailEvent(
                                                          url: _listEvent
                                                              .listEvent[index]
                                                              .url
                                                              .toString())));
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            width: b_width,
                                            height: b_height,
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
                                                        Image.network(
                                                            _listEvent
                                                                .listEvent[index]
                                                                .image
                                                                .toString(),
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
                                                                      _listEvent
                                                                          .listEvent[
                                                                              index]
                                                                          .category[
                                                                              0]
                                                                          .name
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black)),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                          _listEvent
                                                              .listEvent[index]
                                                              .title
                                                              .toString(),
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              // textBaseline: TextBaseline.alphabetic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                                      Padding(padding: EdgeInsets.only(top:10)),
                                                      Text(
                                                          _listEvent
                                                              .listEvent[index]
                                                              .createdAt
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 5,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 15,
                                                            fontStyle: FontStyle
                                                                .italic,
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
                                  },
                                  childCount: _listEvent.listEvent.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
