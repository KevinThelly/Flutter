import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body:  MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
} 

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String barcode="";
  var reply="";
  String val="SCAN";
  //var temp=[["89788","mohan","rajamanikam"],["8978","rohan","koralift"]];


   @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Scan Barcode'),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new RaisedButton(
                      onPressed: scanning,
                      child: new Text(val),       
                      ),
                  padding: const EdgeInsets.all(8.0),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                new Card(
                  child: //new Padding(
                     // padding: new EdgeInsets.all(7.0),
                      //child:
                       new Text(reply),
               // )
                ),
                //displayImage(),
              ],
            ),
          )),
    );
  }

   Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
  return reply;
}

    Future productScanning() async {
    String barcode1;

    barcode1 = await BarcodeScanner.scan();
    //print(barcode1);
    //http.read("http://192.168.43.74:3400/").then();
     String url ='http://192.168.43.74:3400/retrieveinfo';

      Map map = {
      'data': {'id': barcode1.split("-")[0]},
  };

    print(map);
    print(await apiRequest(url, map));
    var reply1= await apiRequest(url,map); 
    setState(() {
     reply = reply1;
    });   
    
  }

  Future barcodeScanning() async {
    // String barcode;

      var barcode2 = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode2);
    //if(barcode=="http://en.m.wikipedia.org"){
    if(barcode2.split("-").length==3){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute(name:barcode2.split("-")[0])),
          );
    }


    else{
      setState(() {
       val="SCAN PRODUCT"; 
      });
      //productScanning();   
    }


  }

  void scanning(){
    if(val=="SCAN"){
      barcodeScanning();
    }
    else if(val=="SCAN PRODUCT"){
      productScanning();
    }
  }
  
}

// class SecondRoute extends StatefulWidget{
//   // final String name;
//   // SecondRoute({Key key, @required this.name}): super(key: key);
//  createState(){
//     return SecondRouteState();
//   }
  
// }

class SecondRoute extends StatelessWidget {
  final String name;
  SecondRoute({Key key, @required this.name}): super(key: key);
 // var response="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
      ),
      body: Center(
          child: Column(
          children: [
            Container(margin: EdgeInsets.only(top: 50.0)),
            new Text("Welcome"),
            Container(margin: EdgeInsets.only(top: 50.0)),
            RaisedButton(
          onPressed: barcodeScanning,
          child: Text('Scan Product'),
        ),
         Container(margin: EdgeInsets.only(top: 50.0)),
            RaisedButton(
          onPressed: barcodeScanningReceiver,
          child: Text('Scan Receiver'),
        ),

          ]
      ),
      )
    );
  }

  Future barcodeScanning() async {
    String barcode;

    barcode = await BarcodeScanner.scan();
    print(barcode);
    //http.read("http://192.168.43.74:3400/").then();
     String url ='http://192.168.43.74:3400/sendinfo';

      Map map = {
      'data': {'id': name, 'target':barcode.split("-")[0]},
  };
    print(map);
    print(await apiRequest(url, map));
    return "succes";
    //var response1= await apiRequest(url,map); 
    // while(response1==null){
    // }
    // setState(() {
    //  response = response1;
    // });   
    
  }

  Future barcodeScanningReceiver() async {
    String barcode;

    barcode = await BarcodeScanner.scan();
    print(barcode);
    //http.read("http://192.168.43.74:3400/").then();
     String url ='http://192.168.43.74:3400/retrieveReceiver';

      Map map = {
      'data': {'id': name, 'target': barcode.split("-")[0]},
  };

    print(map);
    print(await apiRequest(url, map));
    return "succes";
    //var response1= await apiRequest(url,map); 
    // while(response1==null){
    // }
    // setState(() {
    //  response = response1;
    // });   
    
  }


  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
  return reply;
}





}