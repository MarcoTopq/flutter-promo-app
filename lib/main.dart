import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:warnakaltim/src/agenHome.dart';
import 'package:warnakaltim/src/chartAgen.dart';
import 'package:warnakaltim/src/chartCustomer.dart';
import 'package:warnakaltim/src/homeDriver.dart';
// import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:warnakaltim/src/login.dart';
import 'package:warnakaltim/src/home.dart';
import 'package:warnakaltim/src/model/HomeAgenModel.dart';
import 'package:warnakaltim/src/model/HomeDriverModel.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:warnakaltim/src/model/HomeModel.dart';
import 'package:warnakaltim/src/model/HomeUserModel.dart';
import 'package:warnakaltim/src/model/allArrivalModel.dart';
import 'package:warnakaltim/src/model/allEventModel.dart';
import 'package:warnakaltim/src/model/allHotPromoModel.dart';
import 'package:warnakaltim/src/model/allPromoModel.dart';
import 'package:warnakaltim/src/model/chartModel.dart';
import 'package:warnakaltim/src/model/couponModel.dart';
import 'package:warnakaltim/src/model/criticModel.dart';
import 'package:warnakaltim/src/model/deliveryHistoryModel.dart';
import 'package:warnakaltim/src/model/detailDeliveryModel.dart';
import 'package:warnakaltim/src/model/detailDoModel.dart';
import 'package:warnakaltim/src/model/detailPromoModel.dart';
import 'package:warnakaltim/src/model/detailVoucherCustomerModel.dart';
import 'package:warnakaltim/src/model/distributorModel.dart';
import 'package:warnakaltim/src/model/doApproveDetailModel.dart';
import 'package:warnakaltim/src/model/doApproveModel.dart';
import 'package:warnakaltim/src/model/driverModel.dart';
import 'package:warnakaltim/src/model/newsModel.dart';
import 'package:warnakaltim/src/model/notifdoModel.dart';
import 'package:warnakaltim/src/model/profileModel.dart';
import 'package:warnakaltim/src/model/salesOrderModel.dart';
import 'package:warnakaltim/src/model/videosModel.dart';
import 'package:warnakaltim/src/model/voucherCustomer.dart';
import 'package:warnakaltim/src/model/voucherModel.dart';
import 'package:warnakaltim/src/model/detailVoucherModel.dart';
import 'package:warnakaltim/src/profile.dart';
import 'package:warnakaltim/src/ringkasan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warnakaltim/src/talk.dart';
import 'package:warnakaltim/src/userHome.dart';
import 'package:warnakaltim/src/doApproveAgen.dart';

var urls = 'http://rpm.lensaborneo.id';
File files;
var posisi;
var idnya;
var email;
var token;
var role;
var document;
var login;
var fcm;
int badges = 0;
String pdf;
var gold = Color.fromRGBO(
  212,
  175,
  55,
  2,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.get('Email');
  role = prefs.get('Role');
  print(email);
  print(role);
  if (email == null) {
    login = false;
  } else {
    login = true;
  }
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // badges = 100;
    // this._getToken();
    super.initState();
    firebaseMessaging.getToken().then((token) {
      print('fcm : ' + token);
      fcm = token;
    });
    // WidgetsBinding.instance.addObserver(this);
    // _refreshData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: NewsModel(),
          ),
          ChangeNotifierProvider.value(
            value: VideosModel(),
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
            value: AgenHomeModel(),
          ),
          ChangeNotifierProvider.value(
            value: DriverHomeModel(),
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
          ChangeNotifierProvider.value(
            value: ArrivalModel(),
          ),
          ChangeNotifierProvider.value(
            value: DriverPersonModel(),
          ),
          ChangeNotifierProvider.value(
            value: DetailDoModel(),
          ),
          ChangeNotifierProvider.value(
            value: DeliveryHistoryModel(),
          ),
          ChangeNotifierProvider.value(
            value: NotifDoModel(),
          ),
          ChangeNotifierProvider.value(
            value: SalesOrderModel(),
          ),
          ChangeNotifierProvider.value(
            value: DetailDoAgenModel(),
          ),
          ChangeNotifierProvider.value(
            value: DoApproveModel(),
          ),
          ChangeNotifierProvider.value(
            value: DoApproveDetailModel(),
          ),
          ChangeNotifierProvider.value(
            value: VoucherCustomerModel(),
          ),
          ChangeNotifierProvider.value(
            value: DetailVoucherCustomerModel(),
          ),
          ChangeNotifierProvider.value(
            value: CriticDetailModel(),
          ),
        ],
        child: MaterialApp(
          title: 'Warna Kaltim',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.yellow[600],
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
          home: Splash(),
        ));
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new Homepage(),
        title: new Text(
          'Reward Point Management',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.asset('assets/patra.jpg'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: gold);
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _homepageKey = new GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
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
      role = prefs.get('Role');
    });
    print(role);
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
        showNotification(
            message['notification']['title'], message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showNotification(
            message['notification']['title'], message['notification']['body']);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
        showNotification(
            message['notification']['title'], message['notification']['body']);
        _navigateToItemDetail(message);
      },
    );
    super.initState();
    _getToken();
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    // final Item item = _itemForMessage(message);
    // Clear away dialogs
    // Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    // if (!item.route.isCurrent) {
    //   Navigator.push(context, item.route);
    // }
    if (message['notification']['data']['screen'] == 'detaildo') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoApproveAgen()));
    }
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => DoApproveAgen()));
  }

  Future onSelectNotification(String payload) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DoApproveAgen()));
    // showDialog(
    //   context: context,
    //   builder: (_) {
    //     return new AlertDialog(
    //       title: Text("PayLoad"),
    //       content: Text("Payload : $payload"),
    //     );
    // },
    // );
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.max,
        playSound: true,
        // sound: '',
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  TabController controller;
  int _currentIndex = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _children = [
    login == false
        ? Home()
        : role == 'driver'
            ? DriverHomeDetail()
            : role == 'agen' ? AgenHomeDetail() : UserHomeDetail(),
    email == null ? Login() : role == 'agen' ? ChartAgen() : ChartCustomer(),
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
      key: _homepageKey,
      body: _children[_currentIndex], // new
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
