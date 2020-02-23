import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail Promo',
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        backgroundColor: Colors.grey[850],
        body: Center(
            child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20)),
            Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        'assets/lux.jpg',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )),
                ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: gold,
                    size: 50,
                  ),
                  title: Text(
                    'Nama',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    "Topq",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Divider(
                  endIndent: 70.0,
                  indent: 70.0,
                  height: 1.0,
                  color: gold,
                ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: gold,
                    size: 50,
                  ),
                  title: Text(
                    'Email',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    "Topq97@gmail.com",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Divider(
                  endIndent: 70.0,
                  indent: 70.0,
                  height: 1.0,
                  color: gold,
                ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: gold,
                    size: 50,
                  ),
                  title: Text(
                    'Ponsel',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    "085240506070",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Divider(
                  endIndent: 70.0,
                  indent: 70.0,
                  height: 1.0,
                  color: gold,
                ),
              ],
            )
          ],
        )));
  }
}
