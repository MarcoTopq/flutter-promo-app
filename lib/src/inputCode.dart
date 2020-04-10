import 'package:flutter/material.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputCode extends StatefulWidget {
  @override
  _InputCodeState createState() => _InputCodeState();
}

class _InputCodeState extends State<InputCode>
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
    this.kirimdata();
  }

  Future<http.Response> kirimdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.get('Token');
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        "Accept": "application/JSON",
        "Authorization": 'Bearer ' + token
      };

    http.Response hasil = await http.post(
        Uri.decodeFull("http://rpm.kantordesa.com/api/delivery/code"),
        body: {
          "code": codeController.text,
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
            "InputCode",
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
                child: Text("Input Code ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text("if the Driver Was Arrive",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("Code ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                // fontWeight: FontWeight.bold,
                                // fontFamily: Utils.ubuntuRegularFont),
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                color: Colors.white,
                                child: TextField(
                                  obscureText: false,
                                  controller: codeController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Code",
                                      fillColor: gold,
                                      hoverColor: gold,
                                      focusColor: gold,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0))),
                                ))),
                        // Padding(
                        //     padding: EdgeInsets.all(10),
                        //     child: Container(
                        //         color: Colors.white,
                        //         child: TextField(
                        //           obscureText: true,
                        //           controller: passwordController,
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //           ),
                        //           decoration: InputDecoration(
                        //               fillColor: gold,
                        //               hoverColor: gold,
                        //               focusColor: gold,
                        //               contentPadding: EdgeInsets.fromLTRB(
                        //                   20.0, 15.0, 20.0, 15.0),
                        //               hintText: "Password",
                        //               border: OutlineInputBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(2.0))),
                        //         ))),
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
                                        // print(responseJson['user']);
                                        // print(responseJson['user']
                                        //     ['access_token']);

                                        await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: new Text("Status : " +
                                                    responseJson['message']),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                InputCode()),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        final responseJson =
                                            json.decode(value.body);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: new Text("Status : " +
                                                    responseJson['message']),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                InputCode()),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    });
                                  }
                                },
                                child: Text("Send",
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
