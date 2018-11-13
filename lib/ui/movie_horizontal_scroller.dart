import 'package:flutter/material.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/movie_detail_page.dart';
import 'package:flutter_movie/ui/poster.dart';

class MovieHorizontalScroller extends StatelessWidget {
  final List<Subject> movieInfos;
  String title;
  double ratio;
  Color textColor;
  ScrollController controller;

  MovieHorizontalScroller(this.movieInfos,
      {@required this.title, double ratio, Color textColor, this.controller})
      : this.ratio = ratio ?? 1.0,
        this.textColor = textColor ?? Colors.black45;

  Widget _buildMovieItem(BuildContext context, int index) {
    Subject info = movieInfos[index];
    var textTheme = Theme.of(context).textTheme;

    var poster =
        new Poster(info.images.large, 240.0 * ratio, 160.0 * ratio, info.id);

    return Padding(
        padding: EdgeInsets.only(right: 14.0 * ratio),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new MovieDetailPage(info.id, poster: poster))),
                child: poster,
              ),
              SizedBox(height: 6.0 * ratio),
              Container(
                child: Text(info.title,
                    style: textTheme.subhead
                        .copyWith(fontSize: 16.0 * ratio, color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                width: 160.0 * ratio,
              ),
              SizedBox(height: 6.0 * ratio),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text("Ratings",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.w200)),
                  SizedBox(width: 4.0 * ratio),
                  new Text(
                    (info.rating.average * 1.0).toString(),
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.w200),
                  ),
                ],
              )
            ]));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.0 * ratio, vertical: 12.0 * ratio),
            child: Text(title,
                style: textTheme.subhead
                    .copyWith(fontSize: 18.0, color: textColor))),
        new Container(
          height: 305.0 * ratio,
          child: new ListView.builder(
              controller: controller,
              padding: EdgeInsets.only(left: 20.0 * ratio),
              scrollDirection: Axis.horizontal,
              itemCount: movieInfos.length,
              itemBuilder: (context, index) => _buildMovieItem(context, index)),
        )
      ],
    );
  }
}
