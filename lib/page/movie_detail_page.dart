import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/model/movie_detail.dart';
import 'package:flutter_movie/ui/cast_scroller.dart';
import 'package:flutter_movie/ui/expansion_text.dart';
import 'package:flutter_movie/ui/movie_detail_header.dart';
import 'package:flutter_movie/ui/photo_scroller.dart';
import 'package:flutter_movie/ui/poster.dart';
import 'package:flutter_movie/util/movie_api.dart';

class MovieDetailPage extends StatefulWidget {
  int movieId;
  Poster poster;

  MovieDetailPage(this.movieId, this.poster);

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
    Response response = await dio.get(MovieApi.MOVIE_DETAIL_API +
        "?locationId=974&movieId=" +
        widget.movieId.toString());

//    print(response.data['data']['basic']);
    movieDetail = MovieDetail.fromJson(response.data['data']['basic']);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(backgroundColor: Colors.black),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  movieDetail != null
                      ? MovieDetailHeader(movieDetail)
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 190.0, left: 15.0),
                    child: widget.poster.reseize(height: 180.0, width: 126.0),
                  )
                ],
              ),
              movieDetail != null
                  ? Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ExpansionText(movieDetail.story),
                        ),
                        PhotoScroller(movieDetail.stageImg.list
                            .map((img) => img.imgUrl)
                            .toList()),
                        SizedBox(height: 20.0),
                        CastScroller(movieDetail.actors)
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }
}
