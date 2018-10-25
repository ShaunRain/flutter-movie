import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  static const RATIO = 0.7;

  final String posterUrl;
  final double posterHeight;

  Poster(this.posterUrl, this.posterHeight);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 3.0,
        child: Image.network(
            posterUrl,
            width: RATIO * posterHeight,
            height: posterHeight,
            fit: BoxFit.cover));
  }
}
