import 'package:flutter/material.dart';
import 'package:flutter_movie/model/rating.dart';

class RatingInfo extends StatelessWidget {
  Rating rating;
  bool showText;
  double ratio;
  Color color;

  RatingInfo(this.rating, {this.showText = true, this.ratio = 1.0, this.color = Colors.redAccent});

  Widget _buildStars() {
    var stars = <Widget>[];

    for (var i = 1; i <= 5; i++) {
      IconData iconData;
      if (i > rating.average / 2) {
        iconData = Icons.star_border;
        if (i - 0.5 <= rating.average / 2) {
          iconData = Icons.star_half;
        }
      } else {
        iconData = Icons.star;
      }

      stars.add(new Icon(
        iconData,
        size: 24.0 * ratio,
        color: color,
      ));
    }

    return Row(children: stars);
  }

  /**
   *
      10分是Masterpiece，杰作
      9.0至10：Amazing令人惊奇
      8.0至8.9：Great棒极了
      7.0至7.9：Good良好
      6.0至6.9：Okay及格
      5.0至5.9：Medicore平庸
      4.0至4.9：Bad差
      3.0至3.9：Awful可怕极了
      2.0至2.0：Painful痛不欲生
      1.0至1.9：Unbearable无法忍受
      0分是Disaster，灾难
   */

  String _getRatingText(num ratingNum) {
    String ratingText;
    if (ratingNum >= 9.5) {
      ratingText = "Masterpiece";
    } else if (ratingNum >= 9.0) {
      ratingText = "Amazing";
    } else if (ratingNum >= 8.0) {
      ratingText = "Great";
    } else if (ratingNum >= 7.0) {
      ratingText = "Good";
    } else if (ratingNum >= 6.0) {
      ratingText = "Okay";
    } else if (ratingNum >= 5.0) {
      ratingText = "Medicore";
    } else if (ratingNum >= 4.0) {
      ratingText = "Bad";
    } else if (ratingNum >= 3.0) {
      ratingText = "Awful";
    } else if (ratingNum <= 0) {
      ratingText = "None";
    } else {
      ratingText = "Disaster";
    }

    return ratingText;
  }

  @override
  Widget build(BuildContext context) {
    var numRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          (rating.average * 1.0).toString(),
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 22.0 * ratio),
        ),
        showText
            ? Padding(
                padding: EdgeInsets.only(top: 4.0 * ratio),
                child: new Text("Ratings",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.w200)))
            : Container()
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildStars(),
        showText
            ? Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                child: Text(_getRatingText(rating.average),
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.w200)),
              )
            : Container(),
      ],
    );

    if (rating.average == 0.0) {
      return new Text('暂无评分',
          style:
              TextStyle(color: color, fontWeight: FontWeight.w600));
    }

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[numRating, SizedBox(width: 16.0 * ratio), starRating],
    );
  }
}
