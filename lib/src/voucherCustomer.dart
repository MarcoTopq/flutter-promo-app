import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/VoucherDetail.dart';
import 'package:warnakaltim/src/model/voucherCustomer.dart';
import 'package:warnakaltim/src/model/voucherModel.dart';
import 'package:warnakaltim/src/spring_button.dart';
import 'package:warnakaltim/src/widget.dart';

class VoucherCustomerDetail extends StatefulWidget {
  final String url;
  VoucherCustomerDetail({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _VoucherCustomerDetailState createState() => _VoucherCustomerDetailState();
}

class _VoucherCustomerDetailState extends State<VoucherCustomerDetail> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<VoucherCustomerModel>(context, listen: false)
        .fetchDataVoucherCustomer();
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
            'All Coupon',
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
                future:
                    Provider.of<VoucherCustomerModel>(context, listen: false)
                        .fetchDataVoucherCustomer(),
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
                    return Consumer<VoucherCustomerModel>(
                        builder: (ctx, _listVoucher, child) => Center(
                                // child: Stack(children: <Widget>[
                                child: CustomScrollView(slivers: <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.all(20),
                                        width: b_width,
                                        height: b_height,
                                        child: Card(
                                            color: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: gold,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Center(
                                                child: ListTile(
                                              leading: Image.network(
                                                  _listVoucher
                                                      .listVoucherCustomer[
                                                          index]
                                                      .promo
                                                      .image),
                                              title: Text(
                                                _listVoucher
                                                    .listVoucherCustomer[index]
                                                    .promo
                                                    .createdAt,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                _listVoucher
                                                    .listVoucherCustomer[index]
                                                    .promo
                                                    .title
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                              trailing: Icon(
                                                Icons.remove_red_eye,
                                                color: gold,
                                                size: 50,
                                              ),
                                              onTap: () => {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailVoucherCustomer(
                                                                id: _listVoucher
                                                                    .listVoucherCustomer[
                                                                        index]
                                                                    .id
                                                                    .toString())))
                                              },
                                            ))));
                                  },
                                  childCount:
                                      _listVoucher.listVoucherCustomer.length,
                                ),
                              ),
                            ])));
                  }
                })));
  }
}
