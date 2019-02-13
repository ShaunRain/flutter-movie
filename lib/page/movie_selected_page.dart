import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/animator/blur_cover_transition_animation.dart';
import 'package:flutter_movie/animator/scroll_in_animation.dart';
import 'package:flutter_movie/model/short_comment.dart';
import 'dart:ui' as ui;
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/movie_detail_page.dart';
import 'package:flutter_movie/ui/page_transformer.dart';
import 'package:flutter_movie/ui/poster.dart';
import 'package:flutter_movie/ui/rating_info.dart';
import 'package:flutter_movie/util/movie_api.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_movie/util/event_bus.dart';

class MovieSelectedPage extends StatefulWidget {
  @override
  _MovieSelectedPageState createState() => _MovieSelectedPageState();

  MovieSelectedPage();
}

class _MovieSelectedPageState extends State<MovieSelectedPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Subject> selectedMovies = [];
  Map<int, List<ShortComment>> commentMap = new Map();

  bool loading;
  bool pageMounted = false;
  bool isSelectedPageEnd = false;

  String selectedCover;
  String nextSelectedCover;

  int currentIndex = 0;

  AnimationController _controller;
  BlurCoverTransitionAnimation blurAnimation;

  List<Timer> timers = [];

  PageController _selectedPageController;

  List<int> startPoints = [];
  int currentPoint = 0;

  final int pageSize = 10;

  int currentSelected = 0;

  List<List<Subject>> _cacheList = new List(3);

  @override
  void initState() {
    for (int i = 0; i < 250; i += 20) {
      startPoints.add(i);
    }

    startPoints.shuffle();

    loading = true;

    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    blurAnimation = BlurCoverTransitionAnimation(_controller);

    _selectedPageController = PageController(
      viewportFraction: 0.85,
    );

    _selectedPageController.addListener(() {
      if (_selectedPageController.offset ==
              _selectedPageController.position.maxScrollExtent &&
          pageMounted) {
        _getSelectedMovies(false);
      }
    });

    _getSelectedMovies(true);

    bus.on("selected_tab", (index) {
      if (currentSelected != index) {
        setState(() {
          selectedMovies.clear();
        });

        currentSelected = index;
        _selectedPageController.jumpToPage(0);

        _getSelectedMovies(true);
      }
    });

    super.initState();
  }

  Future<List<Subject>> requestResult() async {
    Response response;

    switch (currentSelected) {
      case 0:
        response = await new Dio().get(MovieApi.MOVIE_TOP250 +
            '?apikey=${MovieApi.DOUBAN_API_KEY}&start=${startPoints[currentPoint++]}&count=${pageSize}');
        break;
      case 1:
        response = await new Dio()
            .get(MovieApi.MOVIE_NEW + '?apikey=${MovieApi.DOUBAN_API_KEY}');
        break;
      case 2:
        response = await new Dio()
            .get(MovieApi.MOVIE_USBOX + '?apikey=${MovieApi.DOUBAN_API_KEY}');
        break;
    }

    List<Subject> results;
    if (currentSelected == 2) {
      results = response.data['subjects']
          .map((json) => Subject.fromJson(json['subject']))
          .toList()
          .cast<Subject>();
    } else {
      results = response.data['subjects']
          .map((json) => Subject.fromJson(json))
          .toList()
          .cast<Subject>();
    }

    if (results.isEmpty) {
      setState(() {
        isSelectedPageEnd = true;
      });
      return null;
    }

    if (currentSelected == 0) results.shuffle();

    return results;
  }

  void _getSelectedMovies(loadInit) async {
    if (isSelectedPageEnd) {
      return;
    }

    List<Subject> results = loadInit &&
            _cacheList[currentSelected] != null &&
            _cacheList[currentSelected].length > 0
        ? _cacheList[currentSelected]
        : await requestResult();

    if (loadInit) {
      selectedMovies = results;
      selectedCover = results[0].images.medium;
      nextSelectedCover = results[0].images.medium;
    } else {
      selectedMovies.addAll(results);
    }
    _cacheList[currentSelected] = new List.from(selectedMovies);

    setState(() {
      loading = false;

      if (currentPoint == 1) {
        selectedCover = selectedMovies[0].images.medium;
        _getShortComments(0);
      } else {
        try {
          selectedCover = selectedMovies[_selectedPageController.page.toInt()]
              .images
              .medium;
          _getShortComments(_selectedPageController.page.toInt());
        } catch (e) {
          print(e);
        }
      }
    });
  }

  @override
  void dispose() {
//    commentsAutoTimer.cancel();
    for (var timer in timers) {
      timer.cancel();
    }
    super.dispose();
  }

  void _onPageChanged(int index) {
    currentIndex = index;

    if (index >= selectedMovies.length) {
      return;
    }

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
        _controller.reverse();
//        print('reverse');
      } else {
        nextSelectedCover = selectedMovies[index].images.medium;
        _controller.forward();
//        print('forward');
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

  Widget _buildPageItem(
      BuildContext context, int index, PageVisibility pageVisibility) {
//    print('index${index}/ pagePosition${pageVisibility.pagePosition.abs()}');

    if (selectedMovies.length > 0 && index == selectedMovies.length) {
      return !isSelectedPageEnd && pageMounted
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.amber)))
          : Container();
    }

    Subject subject = selectedMovies[index];

    var poster = Poster(
        posterRadius: 8.0,
        movieId: subject.id,
        posterUrl: subject.images.large,
        posterWidth: MediaQuery.of(context).size.width * 0.8,
        posterHeight: MediaQuery.of(context).size.width * 0.8 * 1.4);

    var commentsPageView;

    if (commentMap.containsKey(index)) {
      commentsPageView = PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: PageController(initialPage: 0),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, _index) => ShortCommentView(
              commentMap[index][_index % commentMap[index].length]));

      timers.add(Timer.periodic(Duration(milliseconds: 3000), (timer) {
        try {
          PageController pageController = commentsPageView?.controller;
          if (pageController.positions.isNotEmpty) {
            pageController.nextPage(
                duration: Duration(milliseconds: 400), curve: Curves.easeIn);
          }
        } catch (e) {
          print(e);
        }
      }));
    }

    return Stack(
      children: <Widget>[
        Container(
          alignment: FractionalOffset(
              0.25, 0.85 - (0.2 * pageVisibility.pagePosition.abs())),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 4.0,
            child: Container(
                alignment: Alignment.bottomCenter,
                height: 120.0,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0)),
                width: MediaQuery.of(context).size.width * 0.75,
                child: commentMap.containsKey(currentIndex)
                    ? Container(
                        height: 50.0,
                        alignment: Alignment.bottomCenter,
                        child: commentsPageView)
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
                              Row(children: <Widget>[
                                Icon(Icons.alarm, color: Colors.white),
                                SizedBox(width: 4.0),
                                Text(' ${subject.durations[0]}',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 18.0),
                                Row(
                                  children: subject.genres
                                      .sublist(0, min(3, subject.genres.length))
                                      .map((genre) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 8.0),
                                            margin: const EdgeInsets.only(
                                                left: 8.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.0)),
                                            child: Text(
                                              genre,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ))
                                      .toList()
                                      .cast<Widget>(),
                                ),
                              ]),
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
            filter: ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(color: Colors.white.withOpacity(0.2))),
        selectedMovies.isNotEmpty
            ? ScrollInAnimation(
                statusListener: (status) {
                  if (AnimationStatus.completed == status) {
                    setState(() {
                      pageMounted = true;
                    });
                  }
                },
                duration: Duration(milliseconds: 800),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: PageTransformer(
                          pageViewBuilder: (visibilityResolver) {
                        return PageView.builder(
                            onPageChanged: (index) => _onPageChanged(index),
                            controller: _selectedPageController,
                            itemCount: selectedMovies.length + 1,
                            itemBuilder: (context, index) => _buildPageItem(
                                context,
                                index,
                                visibilityResolver
                                    .resolvePageVisibility(index)));
                      }),
                    )),
              )
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
  final ShortComment shortComment;

  ShortCommentView(this.shortComment);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
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
