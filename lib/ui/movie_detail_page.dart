import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_movie/model/movie_detail.dart';
import 'package:flutter_movie/ui/cast_scroller.dart';
import 'package:flutter_movie/ui/expansion_text.dart';
import 'package:flutter_movie/ui/movie_detail_header.dart';
import 'package:flutter_movie/ui/photo_scroller.dart';

class MovieDetailPage extends StatefulWidget {
  final String MOVIE_DETAIL_API =
      "https://ticket-api-m.mtime.cn/movie/detail.api";
  int movieId;

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
    //todo: hardcode params
    Response response = await dio
        .get(widget.MOVIE_DETAIL_API + "?locationId=974&movieId=125805");

//    print(response.data['data']['basic']);
    movieDetail = MovieDetail.fromJson(response.data['data']['basic']);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
      child: movieDetail != null
          ? Column(
              children: <Widget>[
                MovieDetailHeader(movieDetail),
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
    ));
  }
}
