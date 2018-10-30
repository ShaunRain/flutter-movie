import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/model/movie_info.dart';
import 'package:flutter_movie/ui/GradientAppBar.dart';
import 'package:flutter_movie/ui/movie_horizontal_scroller.dart';
import 'package:flutter_movie/util/movie_api.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() {
    return new _MovieHomePageState();
  }
}

class _MovieHomePageState extends State<MovieHomePage> {
  List<MovieInfo> movieInfos;

  @override
  void initState() {
    super.initState();
    _getMoviePopular();
  }

  void _getMoviePopular() async {
    Dio dio = new Dio();
    Response response = await dio.get(MovieApi.MOVIE_POPULAR_API);

    setState(() {
      movieInfos = response.data['movies']
          .map((json) => MovieInfo.fromJson(json)).toList().cast<MovieInfo>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GradientAppBar('Movies'),
            movieInfos != null
                ? new MovieHorizontalScroller(movieInfos)
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
