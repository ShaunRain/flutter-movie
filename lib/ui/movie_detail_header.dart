import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_detail.dart';
import 'package:flutter_movie/ui/arc_banner.dart';
import 'package:flutter_movie/ui/rating_info.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetail movieDetail;
  ImageProvider imageProvider;

  MovieDetailHeader(this.movieDetail, this.imageProvider);

  Widget _buildTypeChips(TextTheme textTheme) {
    return new SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: movieDetail.tags
              .map((type) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Chip(
                        label: Text(type),
                        labelStyle: textTheme.caption,
                        backgroundColor: Colors.black12),
                  ))
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(movieDetail.title, style: textTheme.title),
        SizedBox(height: 4.0),
        RatingInfo(movieDetail.rating),
        SizedBox(height: 4.0),
        _buildTypeChips(textTheme)
      ],
    );

    return Stack(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(bottom: 140.0),
            child: new ArcBanner(
              bannerImage: movieDetail
                  .photos[Random().nextInt(movieDetail.photos.length - 1) + 1]
                  .image,
              videoUrl: movieDetail.trailer_urls != null &&
                      movieDetail.trailer_urls.length > 0
                  ? movieDetail.trailer_urls[0]
                  : "",
              videoTitle: "${movieDetail.title}(预告片)",
              imageProvider: imageProvider,
            )),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(width: 126.0),
//              Poster(movieDetail.img, 180.0, 126.0, movieDetail.movieId),
              SizedBox(width: 16.0),
              Expanded(child: movieInfo)
            ],
          ),
        )
      ],
    );
  }
}
