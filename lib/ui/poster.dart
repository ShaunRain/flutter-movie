import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Poster extends StatefulWidget {
  final String posterUrl;
  double posterHeight;
  double posterWidth;
  final String movieId;
  String source;
  ImageProvider _imageProvider;
  double posterRadius;

  ImageProvider get imageProvider => _imageProvider;

  Poster(
      {this.posterUrl,
      this.posterHeight,
      this.posterWidth,
      this.movieId,
      this.source = " ",
      this.posterRadius = 4.0});

//  Poster copyWith({double height, double width}) {
//    return Poster(
//        posterUrl, height ?? posterHeight, width ?? posterWidth, movieId);
//  }

  @override
  _PosterState createState() {
    return new _PosterState();
  }

  Poster reseize({double height, double width, double radius}) {
    posterHeight = height ?? posterHeight;
    posterWidth = width ?? posterWidth;
    radius = radius ?? posterRadius;
    return this;
  }
}

class _PosterState extends State<Poster> {
  @override
  Widget build(BuildContext context) {
    var image = new FadeInImage.memoryNetwork(
        fadeInDuration: Duration(milliseconds: 200),
        placeholder: kTransparentImage,
        image: widget.posterUrl,
        width: widget.posterWidth,
        height: widget.posterHeight,
        fit: BoxFit.cover);

    widget._imageProvider = image.image;

    return Hero(
        tag: 'poster-hero-${widget.movieId + widget.source}',
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(widget.posterRadius),
            child: image));
  }
}
