import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;       //tells dart not to import all the http libraries but just the get function
import 'models/image_model.dart';               //importing class we created receiving jsons
import 'dart:convert';
import 'widgets/image_list.dart';

 class App extends StatefulWidget {             //stateful widget and state<app> is required to change the stateless app into this mode
   createState(){
     return AppState();
   }
 
 }
 
 class AppState extends State<App>{             //class App  extends StatelessWidget // stateless means without any data
  int counter = 0;
  List<ImageModel> images= [];

  void fetchImage() async {                // asyc for using future data types.(not sure)
    counter++;
    var response = await get('http://jsonplaceholder.typicode.com/photos/$counter');           // /1 gets the first photo from that url
    //future data type is returned here from the link. await is used to manage thetime delay that  occurs due to net connection 
    
    var imagemodel = ImageModel.fromJson(json.decode(response.body));
    
    setState(() {
      images.add(imagemodel);
    });
   }

  Widget build(context){                                          //wont run without writng context
     
     return MaterialApp(
     home: Scaffold(                                              //refer flutter docs 
       body : ImageList(images),                                       //to display text in budy use Text '$content'
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
         onPressed:  fetchImage,                      // domt put parenthisis for fetchimage ie,fetchimage as that would
                                                      // call the fetch button immediately when the widget build is run. but it should run only when the button is pressed hence no ().
       ),
      appBar: AppBar(
         title: Text('Lets see some images!'),
       ),
     ),
   );
   }
 }