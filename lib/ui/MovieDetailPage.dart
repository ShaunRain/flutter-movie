import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_movie/model/MovieDetail.dart';

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

    print(response.data['data']['basic']);
    movieDetail = MovieDetail.fromJson(response.data['data']['basic']);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child:
              new Text(movieDetail == null ? "Movie Name" : movieDetail.name),
          onPressed: _getMovieDetail,
        ),
      ),
    );
  }
}
