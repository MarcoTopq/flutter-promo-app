import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:warnakaltim/src/detail_news.dart';
import 'package:warnakaltim/src/model/newsModel.dart';

class AllNews extends StatefulWidget {
  final String url;
  AllNews({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<NewsModel>(context, listen: false).fetchDataNews();
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
            'All News',
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
                                                      DetailNews(
                                                          url: _listNews
                                                              .listNews[index]
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
                                                            _listNews
                                                                .listNews[index]
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
                                                                      _listNews
                                                                          .listNews[
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
                                                          _listNews
                                                              .listNews[index]
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
                                                          _listNews
                                                              .listNews[index]
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
                                  childCount: _listNews.listNews.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
