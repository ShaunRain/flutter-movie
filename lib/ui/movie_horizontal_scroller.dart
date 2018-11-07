import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_info.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/movie_detail_page.dart';
import 'package:flutter_movie/ui/poster.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieHorizontalScroller extends StatelessWidget {
  final List<Subject> movieInfos;
  String title;

  MovieHorizontalScroller(this.movieInfos, this.title);

  Widget _buildMovieItem(BuildContext context, int index) {
    Subject info = movieInfos[index];
    var textTheme = Theme.of(context).textTheme;

    var poster = new Poster(info.images.large, 240.0, 160.0, info.id);

    return Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new MovieDetailPage(info.id, poster))),
                child: poster,
              ),
              SizedBox(height: 6.0),
              Container(
                child: Text(info.title,
                    style: textTheme.subhead.copyWith(fontSize: 16.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                width: 160.0,
              ),
              SizedBox(height: 6.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text("Ratings",
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.w200)),
                  SizedBox(width: 4.0),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Text(title,
                style: textTheme.subhead.copyWith(fontSize: 18.0))),
        new Container(
          height: 300.0,
          child: new ListView.builder(
              padding: const EdgeInsets.only(left: 20.0),
              scrollDirection: Axis.horizontal,
              itemCount: movieInfos.length,
              itemBuilder: (context, index) => _buildMovieItem(context, index)),
        )
      ],
    );
  }
}
