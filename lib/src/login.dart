import 'package:flutter/material.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
        await http.post(Uri.decodeFull("http://rpm.kantordesa.com/api/login"),
            body: {
              "email": emailController.text,
              "password": passwordController.text,
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
                key: _formKey,
                child: Container(
                  width: a_width,
                  height: a_height,
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
                                child: TextField(
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
                                ))),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                color: Colors.white,
                                child: TextField(
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
                                ))),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: gold,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
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
                                          role =  prefs.get('Role');
                                        });

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage()));
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      }
                                    });
                                  }
                                },
                                child: Text("Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
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
