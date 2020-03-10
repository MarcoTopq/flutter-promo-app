import 'package:flutter/material.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/all_event.dart';
import 'package:warnakaltim/src/all_hotPromo.dart';
import 'package:warnakaltim/src/all_news.dart';
import 'package:warnakaltim/src/all_promo.dart';
import 'package:warnakaltim/src/company.dart';
import 'package:warnakaltim/src/detail_Promo.dart';
import 'package:warnakaltim/src/detail_news.dart';
import 'package:warnakaltim/src/event.dart';
// import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:warnakaltim/src/login.dart';
import 'package:warnakaltim/src/home.dart';

import 'package:warnakaltim/src/model/HomeModel.dart';
import 'package:warnakaltim/src/model/HomeUserModel.dart';
import 'package:warnakaltim/src/model/allEventModel.dart';
import 'package:warnakaltim/src/model/allHotPromoModel.dart';
import 'package:warnakaltim/src/model/allPromoModel.dart';
import 'package:warnakaltim/src/model/chartModel.dart';
import 'package:warnakaltim/src/model/couponModel.dart';
import 'package:warnakaltim/src/model/detailPromoModel.dart';
import 'package:warnakaltim/src/model/distributorModel.dart';
import 'package:warnakaltim/src/model/newsModel.dart';
import 'package:warnakaltim/src/model/profileModel.dart';
import 'package:warnakaltim/src/model/voucherModel.dart';
import 'package:warnakaltim/src/model/detailVoucherModel.dart';
import 'package:warnakaltim/src/profile.dart';
import 'package:warnakaltim/src/ringkasan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:warnakaltim/src/talk.dart';
import 'package:warnakaltim/src/userHome.dart';

var email;
var token;
var document;
var login;
String pdf;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.get('Email');
  print(email);
  if (email == null) {
    login = false;
  } else {
    login = true;
  }
  runApp(MaterialApp(home: MyApp()));
}

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
            value: HomeDetailModel(),
          ),
          ChangeNotifierProvider.value(
            value: UserHomeModel(),
          ),
          ChangeNotifierProvider.value(
            value: AllPromoModel(),
          ),
          ChangeNotifierProvider.value(
            value: EventModel(),
          ),
          ChangeNotifierProvider.value(
            value: AllHotPromoModel(),
          ),
          ChangeNotifierProvider.value(
            value: AllPromoModel(),
          ),
          ChangeNotifierProvider.value(
            value: ProfileDetailModel(),
          ),
          ChangeNotifierProvider.value(
            value: DistributorDetailModel(),
          ),
          ChangeNotifierProvider.value(
            value: VoucherDetailModel(),
          ),
          ChangeNotifierProvider.value(
            value: CouponModel(),
          ),
          ChangeNotifierProvider.value(
            value: ChartModel(),
          ),
          ChangeNotifierProvider.value(
            value: DetailVoucherModel(),
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

  Future<void> _getToken() async {
    setState(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.get('Email');
      token = prefs.get('Token');
    });
  }

  @override
  void initState() {
    // this._getToken();
    super.initState();
    _getToken();
    // WidgetsBinding.instance.addObserver(this);
    // _refreshData(context);
  }

  TabController controller;
  int _currentIndex = 0;
  final List<Widget> _children = [
    login == false ? Home() : UserHomeDetail(),
    email == null ? Login() : Chart(),
    email == null ? Login() : Profile(),
    TalkService()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
            title: Text('Summary',
                style: TextStyle(color: Colors.grey[350], fontSize: 10)),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
              // color: Colors.grey[350],
            ),
            title: Text('Information',
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
