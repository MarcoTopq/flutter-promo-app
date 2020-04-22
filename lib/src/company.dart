import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';
// import 'package:warnakaltim/src/model/profileDetailModel.dart';
import 'package:warnakaltim/src/model/profileModel.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
class CompanyDetail extends StatefulWidget {
  final url;
  final token;
  CompanyDetail({
    Key key,
    this.url,
    this.token,
  }) : super(key: key);

  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    changePDF(2);
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    // document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
          "http://rpm.kantordesa.com/company/profile/download");
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
  }

          
        
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );

  @override
  Widget build(BuildContext context) {
    // loadDocument();
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        title: Text(
          'Profile Company',
          style: new TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      backgroundColor: Colors.grey[850],
      body:
      

      Center(
        child: 
        Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(document: document)),
      ),
      
      // RefreshIndicator(
      //     onRefresh: () => _refreshData(context),
      //     child: FutureBuilder(
      //         future: Provider.of<ProfileDetailModel>(context, listen: false)
      //             .fetchDataProfileDetail(),
      //         builder: (ctx, snapshop) {
      //           if (snapshop.connectionState == ConnectionState.waiting) {
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           } else {
      //             if (snapshop.error != null) {
      //               return Center(
      //                 child: Text("Error Loading Data"),
      //               );
      //             }
      //             return Consumer<ProfileDetailModel>(
      //                 builder: (ctx, _listProfileDetail, child) => Center(
      //                     child: ListView.builder(
      //                         scrollDirection: Axis.horizontal,
      //                         itemCount:
      //                             _listProfileDetail.listProfileDetail.length,
      //                         itemBuilder: (context, index) {
      //                           return document == null
      //                               ? Text('Error Loading Data')
      //                               : PDFViewer(document: document);
      // Padding(padding: EdgeInsets.all(20)),
      // Column(
      //   children: <Widget>[
      //     Container(
      //       width: 100,
      //       height: 100,
      //       child: ClipRRect(
      //           borderRadius:
      //               BorderRadius.circular(50.0),
      //           child: Image.asset(
      //              _listProfileDetail.listProfileDetail[0].logo,
      //             fit: BoxFit.cover,
      //             width: 100,
      //             height: 100,
      //           )),
      //     ),
      //     Padding(padding: EdgeInsets.all(20)),
      //     ListTile(
      //       leading: Icon(
      //         Icons.person,
      //         color: gold,
      //         size: 50,
      //       ),
      //       title: Text(
      //         'Nama',
      //         style: new TextStyle(
      //           fontSize: 15.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //       subtitle: Text(
      //         _listProfileDetail.listProfileDetail[0].name,
      //         style: new TextStyle(
      //           fontSize: 20.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     Divider(
      //       endIndent: 70.0,
      //       indent: 70.0,
      //       height: 1.0,
      //       color: gold,
      //     ),
      //     Padding(padding: EdgeInsets.all(20)),
      //     ListTile(
      //       leading: Icon(
      //         Icons.mail,
      //         color: gold,
      //         size: 50,
      //       ),
      //       title: Text(
      //         'Email',
      //         style: new TextStyle(
      //           fontSize: 15.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //       subtitle: Text(
      //         _listProfileDetail.listProfileDetail[0].email,
      //         style: new TextStyle(
      //           fontSize: 20.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     Divider(
      //       endIndent: 70.0,
      //       indent: 70.0,
      //       height: 1.0,
      //       color: gold,
      //     ),
      //     Padding(padding: EdgeInsets.all(20)),
      //     ListTile(
      //       leading: Icon(
      //         Icons.phone,
      //         color: gold,
      //         size: 50,
      //       ),
      //       title: Text(
      //         'Ponsel',
      //         style: new TextStyle(
      //           fontSize: 15.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //       subtitle: Text(
      //         _listProfileDetail.listProfileDetail[0].phone.toString(),
      //         style: new TextStyle(
      //           fontSize: 20.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     Divider(
      //       endIndent: 70.0,
      //       indent: 70.0,
      //       height: 1.0,
      //       color: gold,
      //     ),
      //      Padding(padding: EdgeInsets.all(20)),
      //     ListTile(
      //       leading: Icon(
      //         Icons.desktop_windows,
      //         color: gold,
      //         size: 50,
      //       ),
      //       title: Text(
      //         'Website',
      //         style: new TextStyle(
      //           fontSize: 15.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //       subtitle: Text(
      //         _listProfileDetail.listProfileDetail[0].website.toString(),
      //         style: new TextStyle(
      //           fontSize: 20.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //     Divider(
      //       endIndent: 70.0,
      //       indent: 70.0,
      //       height: 1.0,
      //       color: gold,
      //     ),
      //   ],
      // )
      //
    );
  }
}
