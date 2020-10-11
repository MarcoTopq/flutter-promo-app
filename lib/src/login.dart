import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toast/toast.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final _loginKey = GlobalKey<FormState>();

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
    this.kirimdata();
  }

  Future<http.Response> kirimdata() async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil =
        await http.post(Uri.decodeFull("https://rpm.bpkadkaltim.com/api/login"),
            body: {
              "email": emailController.text,
              "password": passwordController.text,
              "fcm_token": fcm
            },
            headers: headers);
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
            "Login",
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
                child: Text("Login ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text("For more access",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Form(
                key: _loginKey,
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
                                  obscureText: false,
                                  controller: emailController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "email",
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
                                    obscureText: true,
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
                                        hintText: "Password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0))),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Harap di isi';
                                      }
                                    }))),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: RoundedLoadingButton(
                              width: 230,
                              child: Text(
                                "Login",
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
                                  if (_loginKey.currentState.validate()) {
                                    kirimdata().then((value) async {
                                      if (value.statusCode == 200) {
                                        final responseJson =
                                            json.decode(value.body);
                                        print(responseJson['user']);
                                        print(responseJson['user']
                                            ['access_token']);
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            'Token',
                                            responseJson['user']
                                                ['access_token']);

                                        prefs.setString('Email',
                                            responseJson['user']['email']);

                                        prefs.setString('Role',
                                            responseJson['user']['role']);

                                        print(responseJson['user']
                                                ['access_token']
                                            .toString());
                                        print('Token  :' + prefs.get('Token'));
                                        print('Token  :' + prefs.get('Email'));

                                        setState(() {
                                          login = true;
                                          email = prefs.get('Email');
                                          token = prefs.get('Token');
                                          role = prefs.get('Role');
                                        });
                                        Toast.show("Login Berhasil", context);
                                        _btnController.reset();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage()));
                                      } else {
                                        Toast.show(
                                            "Login Gagal Username atau Password salah",
                                            context,
                                            duration: 7);
                                        _btnController.reset();
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => Login()));
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
                                // child: Text("Login",
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
