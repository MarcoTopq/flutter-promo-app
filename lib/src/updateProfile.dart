import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toast/toast.dart';
import 'package:warnakaltim/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:warnakaltim/src/deliveryHistory.dart';
import 'package:warnakaltim/src/profile.dart';
import 'package:warnakaltim/src/profileCustomer.dart';

class UpdateProfile extends StatefulWidget {
  final String email;
  UpdateProfile({
    Key key,
    this.email,
  }) : super(key: key);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile>
    with SingleTickerProviderStateMixin {
  final _updateProfileKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController oldpasswordController = new TextEditingController();

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
    emailController.text = widget.email;
    super.initState();
    // this.kirimdata();
  }

  Future<http.Response> kirimdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');

    http.Response hasil =
        await http.post(Uri.decodeFull(urls + "/api/user/update"), body: {
      "email": emailController.text,
      "old_password": oldpasswordController.text,
      "new_password": passwordController.text
    }, headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    print(hasil.statusCode);
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
            "Update Profile",
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
                child: Text("Change Email & Password ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
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
                key: _updateProfileKey,
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
                                  // maxLines: 5,
                                  obscureText: false,
                                  controller: emailController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Email",
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
                                    // maxLines: 5,
                                    obscureText: false,
                                    controller: oldpasswordController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        fillColor: gold,
                                        hoverColor: gold,
                                        focusColor: gold,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Old Password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0))),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Harap di isi';
                                      }
                                    }))),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                color: Colors.white,
                                child: TextFormField(
                                    // maxLines: 5,
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
                                        hintText: "New Password",
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
                                "Update",
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
                                  if (_updateProfileKey.currentState
                                      .validate()) {
                                    kirimdata().then((value) async {
                                      if (value.statusCode == 200) {
                                        Toast.show(
                                            "Update Profile Success", context);
                                        _btnController.reset();
                                        // Navigator.of(context).pop();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PersonDetail()));
                                      } else {
                                        Toast.show(
                                            "Update Profile Failed ", context,
                                            duration: 7);
                                        _btnController.reset();
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => UpdateProfile()));
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
                                // child: Text("UpdateProfile",
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
