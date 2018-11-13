import 'package:flutter/material.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/actor_detail_page.dart';
import 'package:flutter_movie/page/movie_detail_page.dart';
import 'package:flutter_movie/ui/rating_info.dart';
import 'package:material_search/material_search.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieSearchItem<T> extends MaterialSearchResult<T> {
  Subject subject;

  MovieSearchItem(this.subject);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new MovieDetailPage(subject.id,
                    posterUrl: subject.images.medium))),
        child: Container(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ClipRRect(
                  borderRadius: new BorderRadius.circular(2.0),
                  child: new FadeInImage.memoryNetwork(
                      fadeInDuration: Duration(milliseconds: 200),
                      placeholder: kTransparentImage,
                      image: subject.images.small,
                      width: 80.0,
                      height: 120.0,
                      fit: BoxFit.cover)),
              SizedBox(width: 12.0),
              Container(
                constraints: BoxConstraints.expand(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 120.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      subject.title,
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingInfo(
                      subject.rating,
                      showText: false,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: subject.casts
                              .map((cast) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new ActorDetailPage(
                                                      personId: cast.id,
                                                      avatarUrl:
                                                          cast.avatars.small))),
                                      child: Chip(
                                          label: Text(
                                            cast.name,
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                          backgroundColor: Colors.black12))))
                              .toList()),
                    )

//                Text(
//                  '主演：${subject.casts.fold<String>('', (value, cast) => value += '${cast.name}/')}',
//                  softWrap: true,
//                  maxLines: 2,
//                  overflow: TextOverflow.ellipsis,
//                ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
