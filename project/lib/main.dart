import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
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
        body:  MyHomePage(),
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
                      onPressed: barcodeScanning,
                      child: new Text("SCAN"),       
                      ),
                  padding: const EdgeInsets.all(8.0),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                new Text("Value : " + barcode),
                // displayImage(),
              ],
            ),
          )),
    );
  }


  Future barcodeScanning() async {
    String barcode;

    try {
      barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
    if(barcode=="http://en.m.wikipedia.org"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute(name:barcode)),
          );
    }
  }
  
}


class SecondRoute extends StatefulWidget{
  final String name;
  SecondRoute({Key key, @required this.name}): super(key: key);
  createState(){
    return SecondRouteState();
  }
  
}

class SecondRouteState extends State<SecondRoute> {
  String barcode="";
  String data1;
      List data;

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );
    data = json.decode(response.body);
    setState(() {
     data1=data[2]["title"].toString(); 
    });
    debugPrint(data[2]["title"].toString());
    print(data1);
    return "Success!";
  }

    Future barcodeScanning() async {
     String barcode;

    barcode = await BarcodeScanner.scan();
    setState(() => this.barcode = barcode);

    if(barcode=="http://en.m.wikipedia.org")
    {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
      ),
      body: Center(
        child:  Column(
          children: [
            Container(margin: EdgeInsets.only(top: 50.0)),
            //new Text(name),
            Container(margin: EdgeInsets.only(top: 50.0)),
            RaisedButton(
          onPressed: barcodeScanning,
          child: Text('Scan'),
        ),

        //new Text(barcode),
        new Text(data1)
          ]
      ),
      )
    );
  }
}
