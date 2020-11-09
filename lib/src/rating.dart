import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toast/toast.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Rating extends StatefulWidget {
  final String id;
  Rating({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> with SingleTickerProviderStateMixin {
  final _ratingKey = GlobalKey<FormState>();
  int rating = 0;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // this.kirimdata();
  }

  Future<http.Response> kirimdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    http.Response hasil = await http
        .post(Uri.decodeFull(urls + "/api/critics/" + widget.id), body: {
      "critics_suggestion": emailController.text,
      "service": passwordController.text,
      "rating": rating.toString()
    }, headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    return Future.value(hasil);
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
            "Rating",
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
        body: Center(
            child: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("Rating ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text("",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Form(
                key: _ratingKey,
                child: Container(
                  // width: a_width,
                  // height: a_height,
                  padding: EdgeInsets.all(10),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              color: Colors.white,
                              child: TextFormField(
                                  maxLines: 5,
                                  obscureText: false,
                                  controller: emailController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Critics",
                                      fillColor: gold,
                                      hoverColor: gold,
                                      focusColor: gold,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0))),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Harap di isi';
                                    }
                                  }),
                            )),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                color: Colors.white,
                                child: TextFormField(
                                    maxLines: 5,
                                    obscureText: false,
                                    controller: passwordController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        fillColor: gold,
                                        hoverColor: gold,
                                        focusColor: gold,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Service",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0))),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Harap di isi';
                                      }
                                    }))),
                        RatingBar(
                          initialRating: 3,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                );
                              case 1:
                                return Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                );
                              case 2:
                                return Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                );
                              case 3:
                                return Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                                );
                              case 4:
                                return Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                            }
                          },
                          onRatingUpdate: (star) {
                            rating = star.toInt();
                            print(rating);
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: RoundedLoadingButton(
                              width: 230,
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: gold,
                              controller: _btnController,
                              onPressed: () => Timer(
                                Duration(seconds: 3),
                                () async {
                                  print("lagi coba");
                                  if (_ratingKey.currentState.validate()) {
                                    kirimdata().then((value) async {
                                      if (value.statusCode == 200) {
                                        // final responseJson =
                                        //     json.decode(value.body);
                                        // print(responseJson['user']);
                                        // print(responseJson['user']
                                        //     ['access_token']);
                                        // SharedPreferences prefs =
                                        //     await SharedPreferences
                                        //         .getInstance();
                                        // prefs.setString(
                                        //     'Token',
                                        //     responseJson['user']
                                        //         ['access_token']);

                                        // prefs.setString('Email',
                                        //     responseJson['user']['email']);

                                        // prefs.setString('Role',
                                        //     responseJson['user']['role']);

                                        // print(responseJson['user']
                                        //         ['access_token']
                                        //     .toString());
                                        // print('Token  :' + prefs.get('Token'));
                                        // print('Token  :' + prefs.get('Email'));

                                        // setState(() {
                                        //   login = true;
                                        //   email = prefs.get('Email');
                                        //   token = prefs.get('Token');
                                        //   role = prefs.get('Role');
                                        // });
                                        Toast.show(
                                            "Rating Berhasil dikirim", context);
                                        _btnController.reset();
                                        Navigator.of(context).pop();
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             DeliveryHistoryDetail()));
                                      } else {
                                        Toast.show("Rating Gagal ", context,
                                            duration: 7);
                                        _btnController.reset();
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => Rating()));
                                      }
                                    });
                                  } else {
                                    Toast.show(
                                        "Harap isi semua kolom", context);
                                    _btnController.reset();
                                    // Navigator.pushReplacement(context,
                                    //     MaterialPageRoute(builder: (context) => Spalsh()));
                                  }
                                },
                                // child: Text("Rating",
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold)),
                              ),
                            ))
                      ],
                    ),
                  ),
                )),
          ],
        )));
  }
}
