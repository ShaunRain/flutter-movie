import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Poster extends StatelessWidget {
  static const RATIO = 0.7;

  final String posterUrl;
  final double posterHeight;

  Poster(this.posterUrl, this.posterHeight);

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
        borderRadius: new BorderRadius.circular(4.0),
        child: new FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: posterUrl,
            width: RATIO * posterHeight,
            height: posterHeight,
            fit: BoxFit.cover));
  }
}
