import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class CastScroller extends StatelessWidget {
  final List<Actor> actors;

  CastScroller(this.actors);

  Widget _buildCast(Actor actor) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
                actor.roleImg.length > 0 ? actor.roleImg : actor.img),
            radius: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              actor.nameEn,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'The cast',
            style: textTheme.subhead.copyWith(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: (context, index) => _buildCast(actors[index]),
            itemCount: actors.length,
          ),
        )
      ],
    );
  }
}