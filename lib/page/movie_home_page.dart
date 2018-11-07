import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/video_app.dart';
import 'package:flutter_movie/ui/GradientAppBar.dart';
import 'package:flutter_movie/ui/movie_horizontal_scroller.dart';
import 'package:flutter_movie/ui/parallax/parallax_image.dart';
import 'package:flutter_movie/ui/parallax/parallex_item.dart';
import 'package:flutter_movie/util/movie_api.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() {
    return new _MovieHomePageState();
  }
}

class _MovieHomePageState extends State<MovieHomePage> {
  List<Subject> movieInfos;

  @override
  void initState() {
    super.initState();
    _getMoviePopular();
  }

  void _getMoviePopular() async {
    Dio dio = new Dio();
    Response response = await dio.get(MovieApi.MOVIE_IN_THEATERS_API);

    setState(() {
      movieInfos = response.data['subjects']
          .map((json) => Subject.fromJson(json))
          .toList()
          .cast<Subject>();
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
                ? new MovieHorizontalScroller(movieInfos, title: "正在热映")
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
        child: new GestureDetector(
            onTap: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new VideoApp())),
            child: ParallaxImage(
              extent: 100.0,
              image: new ExactAssetImage('assets/img$index.jpg'),
            )));
  }
}
