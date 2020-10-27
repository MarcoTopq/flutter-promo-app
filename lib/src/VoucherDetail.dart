import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/bast.dart';
import 'package:warnakaltim/src/model/detailVoucherCustomerModel.dart';

class DetailVoucherCustomer extends StatefulWidget {
  final String id;
  DetailVoucherCustomer({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _DetailVoucherCustomerState createState() => _DetailVoucherCustomerState();
}

class _DetailVoucherCustomerState extends State<DetailVoucherCustomer>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TextEditingController codeController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<DetailVoucherCustomerModel>(context, listen: false)
        .fetchDataDetailVoucerCustomer(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double a_width = MediaQuery.of(context).size.width * 0.9;
    double a_height = MediaQuery.of(context).size.width * 0.7;
    var gold = Color.fromRGBO(
      212,
      175,
      55,
      2,
    );
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          // centerTitle: true,
          title: Text(
            "Detail Voucher",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              // fontWeight: FontWeight.bold,
              // fontFamily: Utils.ubuntuRegularFont),
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        backgroundColor: Colors.grey[850],
        body: RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: Provider.of<DetailVoucherCustomerModel>(context,
                        listen: false)
                    .fetchDataDetailVoucerCustomer(widget.id),
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
                    return Consumer<DetailVoucherCustomerModel>(
                        builder: (ctx, _listDetailVoucher, child) => Center(
                                child: CustomScrollView(
                              slivers: <Widget>[
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // IntrinsicHeight(
                                            //     child: VerticalDivider(
                                            //   endIndent: 20.0,
                                            //   indent: 0.0,
                                            //   thickness: 10,
                                            //   width: 30.0,
                                            //   color: Colors.white,
                                            // )),
                                            Expanded(
                                                child: ListTile(
                                              // leading: Icon(
                                              //   Icons.add_circle,
                                              //   color: gold,
                                              //   size: 40,
                                              // ),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: InkWell(
                                                      child: Image.asset(
                                                        // "http://rpm.lensaborneo.id/uploads/avatars/default.jpg",

                                                        'assets/patra.jpg',
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      //
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(15)),
                                                  // Text(
                                                  //   'Image',
                                                  //   style: new TextStyle(
                                                  //     fontSize: 12.0,
                                                  //     color: gold,
                                                  //   ),
                                                  // ),
                                                  _listDetailVoucher
                                                              .detailCusVoucher[
                                                                  0]
                                                              .promo
                                                              .image
                                                              .toString() ==
                                                          "http://rpm.lensaborneo.id/uploads"
                                                      ? Text(
                                                          ' - ',
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : Center(
                                                          child: InkWell(
                                                            child:
                                                                Image.network(
                                                              // "http://rpm.lensaborneo.id/uploads/avatars/default.jpg",

                                                              _listDetailVoucher
                                                                  .detailCusVoucher[
                                                                      0]
                                                                  .promo
                                                                  .image
                                                                  .toString(),
                                                              // width: 100,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Bast(
                                                                                url: _listDetailVoucher.detailCusVoucher[0].promo.image.toString(),
                                                                              )));
                                                            },
                                                          ),
                                                        ),
                                                  // Divider(
                                                  //   endIndent: 0.0,
                                                  //   indent: 0.0,
                                                  //   height: 1.0,
                                                  //   thickness: 1,
                                                  //   color: Colors.white,
                                                  // ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Purchase',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetailVoucher
                                                        .detailCusVoucher[0]
                                                        .createdAt
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),

                                                  Text(
                                                    'Title',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetailVoucher
                                                        .detailCusVoucher[0]
                                                        .promo
                                                        .title
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'Description ',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetailVoucher
                                                        .detailCusVoucher[0]
                                                        .promo
                                                        .description
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Text(
                                                    'terms',
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: gold,
                                                    ),
                                                  ),
                                                  Text(
                                                    _listDetailVoucher
                                                        .detailCusVoucher[0]
                                                        .promo
                                                        .terms
                                                        .toString(),
                                                    style: new TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(2)),
                                                  Divider(
                                                    endIndent: 0.0,
                                                    indent: 0.0,
                                                    height: 1.0,
                                                    thickness: 1,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }, childCount: 1))
                              ],
                            )));
                  }
                })));
  }
}
