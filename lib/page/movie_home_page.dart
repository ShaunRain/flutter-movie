import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/video_app.dart';
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

class _MovieHomePageState extends State<MovieHomePage>
    with AutomaticKeepAliveClientMixin {
  List<Subject> popularMovies;
  List<Subject> weeklyMovies;

  @override
  void initState() {
    super.initState();
    _getMoviePopular();
    _getMovieWeekly();
  }

  void _getMoviePopular() async {
    Dio dio = new Dio();
    Response response = await dio.get(MovieApi.MOVIE_IN_THEATERS_API);

    setState(() {
      popularMovies = response.data['subjects']
          .map((json) => Subject.fromJson(json))
          .toList()
          .cast<Subject>();
    });
  }

  void _getMovieWeekly() async {
    Dio dio = new Dio();
    Response response = await dio
        .get(MovieApi.MOVIE_WEEKLY_API + '?apikey=' + MovieApi.DOUBAN_API_KEY);

    setState(() {
      weeklyMovies = response.data['subjects']
          .map((json) => Subject.fromJson(json['subject']))
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
//            MovieAppBar('Movies'),
            popularMovies != null
                ? new MovieHorizontalScroller(popularMovies,
                    title: "正在热映", ratio: 0.9)
                : SizedBox(),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              height: 1.0,
              color: Colors.black12,
            ),
            weeklyMovies != null
                ? new MovieHorizontalScroller(weeklyMovies,
                    title: "口碑榜", ratio: 0.9)
                : SizedBox(),
//            ParallexPageView(list),
//            new Container(
//              padding: const EdgeInsets.symmetric(vertical: 10.0),
//              constraints: BoxConstraintsconst BoxConstraints(maxHeight: 200.0),
//              child: new ListView.builder(
//                  scrollDirection: Axis.horizontal,
//                  itemBuilder: _buildHorizontalChild),
//            )
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

  @override
  bool get wantKeepAlive => true;
}
