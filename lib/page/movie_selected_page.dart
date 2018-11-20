import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/animator/blur_cover_transition_animation.dart';
import 'package:flutter_movie/model/short_comment.dart';
import 'dart:ui' as ui;
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/movie_detail_page.dart';
import 'package:flutter_movie/ui/page_transformer.dart';
import 'package:flutter_movie/ui/poster.dart';
import 'package:flutter_movie/ui/rating_info.dart';
import 'package:flutter_movie/util/movie_api.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieSelectedPage extends StatefulWidget {
  @override
  _MovieSelectedPageState createState() => _MovieSelectedPageState();
}

class _MovieSelectedPageState extends State<MovieSelectedPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Subject> selectedMovies;
  Map<int, List<ShortComment>> commentMap = new Map();

  bool loading;
  String selectedCover;
  String nextSelectedCover;

  int currentIndex;

  AnimationController _controller;
  BlurCoverTransitionAnimation blurAnimation;

  void _getSelectedMovies() async {
    Response response = await new Dio().get(MovieApi.MOVIE_TOP250 +
        '?apikey=${MovieApi.DOUBAN_API_KEY}&start=${Random().nextInt(81)}&count=20');

    selectedMovies = response.data['subjects']
        .map((json) => Subject.fromJson(json))
        .toList()
        .cast<Subject>();

    selectedMovies.shuffle();

    setState(() {
      loading = false;
      if (selectedMovies != null && selectedMovies.length > 0) {
        selectedCover = selectedMovies[0].images.medium;

        _getShortComments(0);
      }
    });
  }

  void _onPageChanged(int index) {
    currentIndex = index;

    if (selectedMovies != null && selectedMovies.length > index) {
//      selectedCover = selectedMovies[index].images.medium;

      if (!commentMap.containsKey(index)) {
        _getShortComments(index);
      }
    }

    setState(() {
      if (blurAnimation.fadeIn.isCompleted ||
          blurAnimation.fadeOut.isCompleted) {
        selectedCover = selectedMovies[index].images.medium;
//        nextSelectedCover = selectedMovies[index].images.medium;
        _controller.reverse();
        print('reverse');
      } else {
//        selectedCover = selectedMovies[index].images.medium;
        nextSelectedCover = selectedMovies[index].images.medium;
        _controller.forward();
        print('forward');
      }
    });
  }

  void _getShortComments(int index) async {
    Response response = await new Dio().get(MovieApi.MOVIE_DETAIL_API +
        '${selectedMovies[index].id}/comments?apikey=${MovieApi.DOUBAN_API_KEY}');

    List<ShortComment> comments = response.data['comments']
        .map((json) => ShortComment.fromJson(json))
        .toList()
        .cast<ShortComment>();

    commentMap.putIfAbsent(index, () => comments);

    setState(() {});
  }

  @override
  void initState() {
    loading = true;
    currentIndex = 0;

    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    blurAnimation = BlurCoverTransitionAnimation(_controller);

    _getSelectedMovies();
    super.initState();
  }

  Widget _buildPageItem(
      BuildContext context, int index, PageVisibility pageVisibility) {
//    print('index${index}/ pagePosition${pageVisibility.pagePosition.abs()}');

    Subject subject = selectedMovies[index];

    var poster = Poster(
        posterRadius: 8.0,
        movieId: subject.id,
        posterUrl: subject.images.large,
        posterWidth: MediaQuery.of(context).size.width * 0.8,
        posterHeight: MediaQuery.of(context).size.width * 0.8 * 1.4);

    return Stack(
      children: <Widget>[
        Container(
          alignment: FractionalOffset(
              0.25, 0.95 - (0.1 * pageVisibility.pagePosition.abs())),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 4.0,
            child: Container(
                height: 120.0,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0)),
                width: MediaQuery.of(context).size.width * 0.75,
                child: commentMap.containsKey(currentIndex)
                    ? Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          ShortCommentView(commentMap[currentIndex][0])
                        ],
                      )
                    : Container()),
          ),
        ),
        InkWell(
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new MovieDetailPage(
                          subject.id,
                          poster: poster,
                        ))),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                elevation: 4.0,
//            decoration: BoxDecoration(
//                shape: BoxShape.rectangle,
//                borderRadius: BorderRadius.circular(8.0),
//                boxShadow: [
//                  BoxShadow(
//                      color: Colors.grey,
//                      blurRadius: 2.0,
//                      offset: Offset.zero,
//                      spreadRadius: 2.0)
//                ]),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    poster,
                    Container(
                        height: 150.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.black45.withOpacity(0.0),
                                  Colors.black45.withOpacity(0.8)
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(0.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp))),
                    Container(
                        height: 120.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(subject.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 6.0),
                              RatingInfo(
                                subject.rating,
                                showText: false,
                                color: Colors.amberAccent,
                              ),
                              SizedBox(height: 6.0),
                            ]))
                  ],
                ))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AnimatedBuilder(
            animation: _controller,
            builder: (context, widget) =>
                Stack(fit: StackFit.expand, children: <Widget>[
                  selectedCover != null
                      ? Opacity(
                          opacity: blurAnimation.fadeOut.value,
                          child: FadeInImage.memoryNetwork(
                              fadeInDuration: Duration(milliseconds: 200),
                              placeholder: kTransparentImage,
                              image: selectedCover,
                              imageScale: 1.0,
                              fit: BoxFit.cover))
                      : Container(),
                  nextSelectedCover != null
                      ? Opacity(
                          opacity: blurAnimation.fadeIn.value,
                          child: FadeInImage.memoryNetwork(
                              fadeInDuration: Duration(milliseconds: 200),
                              placeholder: kTransparentImage,
                              image: nextSelectedCover,
                              imageScale: 1.0,
                              fit: BoxFit.cover))
                      : Container()
                ])),
        BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
            child: Container(color: Colors.white.withOpacity(0.2))),
        selectedMovies != null
            ? Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: PageTransformer(pageViewBuilder: (visibilityResolver) {
                  return PageView.builder(
                      onPageChanged: (index) => _onPageChanged(index),
                      controller: PageController(
                        viewportFraction: 0.85,
                      ),
                      itemCount: selectedMovies.length,
                      itemBuilder: (context, index) => _buildPageItem(
                          context,
                          index,
                          visibilityResolver.resolvePageVisibility(index)));
                }))
            : Container(),
        Center(
          child: new Opacity(
            opacity: loading ? 1.0 : 0.0,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.amber)
//                  new ColorTween(begin: Colors.tealAccent, end: Colors.teal)
//                      .animate(new CurvedAnimation(
//                          parent: new AnimationController(
//                              vsync: this, duration: Duration(minutes: 1)),
//                          curve: Curves.decelerate)
//                  ),
                ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ShortCommentView extends StatelessWidget {
  ShortComment shortComment;

  ShortCommentView(this.shortComment);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
                flex: 1,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                  shortComment.author.avatar,
                ))),
            SizedBox(width: 10.0),
            Flexible(
                flex: 4,
                child: Text(
                  shortComment.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.black87, fontSize: 11.0),
                )),
            Icon(
              Icons.format_quote,
              color: Colors.black87,
            ),
          ],
        ));
  }
}
