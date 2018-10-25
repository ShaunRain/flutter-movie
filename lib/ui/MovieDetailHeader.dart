import 'package:flutter/material.dart';
import 'package:flutter_movie/model/MovieDetail.dart';
import 'package:flutter_movie/ui/ArcBanner.dart';
import 'package:flutter_movie/ui/Poster.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetail movieDetail;

  MovieDetailHeader(this.movieDetail);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 140.0),
            child: new ArcBanner(movieDetail != null
                ? movieDetail.stageImg.list[0].imgUrl
                : null)),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Poster(movieDetail != null ? movieDetail.img : null, 180.0)
            ],
          ),
        )
      ],
    );
  }
}
