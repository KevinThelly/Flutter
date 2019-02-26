import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  
  ImageList(this.images);


  Widget build(context){
    return ListView.builder(                    //.builder is a type in which only a set of images are loaded. rest will be loaded only when end is reached. check 11.15 video.
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return builImage(images[index]);                                  
      },
    );
  }

  Widget builImage(ImageModel image){
    return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          padding: EdgeInsets.all(20.0),
          margin:  EdgeInsets.all(20.0),
                    //spacing arounf the edge at all sides, only double can be passed and no integer(20.0 and not 20)
          child:  Column(
            children: <Widget>[
              Padding (
                child: Image.network(image.url),
                padding: EdgeInsets.only(bottom: 8.0),
              ),
              Text(image.title),
            ],
          ),        
        );
  }
}