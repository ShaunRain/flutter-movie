import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/model/movie_info.dart';
import 'package:flutter_movie/ui/GradientAppBar.dart';
import 'package:flutter_movie/ui/movie_horizontal_scroller.dart';
import 'package:flutter_movie/ui/parallax/parallax_image.dart';
import 'package:flutter_movie/ui/parallax/parallex_item.dart';
import 'package:flutter_movie/ui/parallax/parallex_page_view.dart';
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
          .map((json) => MovieInfo.fromJson(json))
          .toList()
          .cast<MovieInfo>();
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = <ParallexItem>[
      ParallexItem(imagePath: 'assets/img1.jpg'),
      ParallexItem(imagePath: 'assets/img2.jpg'),
      ParallexItem(imagePath: 'assets/img3.jpg'),
      ParallexItem(imagePath: 'assets/img4.jpg'),
      ParallexItem(imagePath: 'assets/img5.jpg'),
      ParallexItem(imagePath: 'assets/img6.jpg'),
      ParallexItem(imagePath: 'assets/img7.jpg')
    ];

    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GradientAppBar('Movies'),
            movieInfos != null
                ? new MovieHorizontalScroller(movieInfos)
                : SizedBox(),
//            ParallexPageView(list),
            new Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              constraints: const BoxConstraints(maxHeight: 200.0),
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: _buildHorizontalChild),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalChild(BuildContext context, int index) {
    index++;
    if (index > 7) return null;
    return new Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: new ParallaxImage(
          extent: 100.0,
          image: new ExactAssetImage('assets/img$index.jpg'),
        ));
  }
}
