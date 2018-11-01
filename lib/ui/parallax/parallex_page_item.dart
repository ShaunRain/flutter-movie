import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ParallexPageItem extends StatelessWidget {
  String imageUrl;
  String imagePath;

  ParallexPageItem({this.imageUrl, this.imagePath});

  @override
  Widget build(BuildContext context) {
    var image = imageUrl != null
        ? FadeInImage.memoryNetwork(
            fadeInDuration: Duration(milliseconds: 500),
            placeholder: kTransparentImage,
            image: imageUrl,
            width: 160.0,
            height: 120.0,
            fit: BoxFit.cover,
            alignment: FractionalOffset(0.5, 0.5))
        : Image.asset(imagePath,
            width: 160.0,
            height: 120.0,
            fit: BoxFit.cover,
            alignment: FractionalOffset(0.5, 0.5));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[image],
        ),
      ),
    );
  }
}
