import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class SecondRoute extends StatelessWidget {
  final String name;
  SecondRoute({Key key, @required this.name}): super(key: key);
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
            new Text(name),
            Container(margin: EdgeInsets.only(top: 50.0)),
            RaisedButton(
          onPressed: barcodeScanning,
          child: Text('Scan'),
        ),
          ]
      ),
      )
    );
  }

  Future barcodeScanning() async {
    String barcode;

    barcode = await BarcodeScanner.scan();


    
  }
}
