import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/model/movie_detail.dart';
import 'package:flutter_movie/ui/cast_scroller.dart';
import 'package:flutter_movie/ui/expansion_text.dart';
import 'package:flutter_movie/ui/movie_detail_header.dart';
import 'package:flutter_movie/ui/photo_scroller.dart';
import 'package:flutter_movie/ui/poster.dart';
import 'package:flutter_movie/util/movie_api.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetailPage extends StatefulWidget {
  String movieId;
  Poster poster;
  String posterUrl;

  MovieDetailPage(this.movieId, {this.poster, this.posterUrl});

  @override
  State<MovieDetailPage> createState() => new _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail movieDetail;

  @override
  void initState() {
    super.initState();
    _getMovieDetail();
  }

  _getMovieDetail() async {
    Dio dio = new Dio();
    Response response = await dio.get(
        "${MovieApi.MOVIE_DETAIL_API}${widget.movieId}?apikey=${MovieApi.DOUBAN_API_KEY}"
        "&city=杭州&client=something&udid=dddddddddddddddddddddd");

    movieDetail = MovieDetail.fromJson(response.data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Scaffold(
//        appBar: new AppBar(backgroundColor: Colors.black),
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              movieDetail != null
                  ? MovieDetailHeader(movieDetail, widget.poster.imageProvider)
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 190.0, left: 15.0),
                child: widget.poster == null
                    ? Poster(
                        posterUrl: widget.posterUrl,
                        posterHeight: 180.0,
                        posterWidth: 126.0,
                        movieId: widget.movieId)
                    : widget.poster.reseize(height: 180.0, width: 126.0),
              ),
            ],
          ),
          movieDetail != null
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Story Line",
                            style: textTheme.subhead.copyWith(fontSize: 18.0),
                          ),
                          ExpansionText(movieDetail.summary)
                        ],
                      ),
                    ),
                    PhotoScroller(movieDetail.photos
                        .map((photo) => photo.thumb)
                        .toList()),
                    SizedBox(height: 20.0),
                    CastScroller(movieDetail.casts),
                    SizedBox(height: 20.0),
                  ],
                )
              : SizedBox(),
        ],
      ),
    ));
  }
}
