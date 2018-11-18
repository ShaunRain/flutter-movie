import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/animator/actor_detail_animation.dart';
import 'package:flutter_movie/animator/actor_works_animation.dart';
import 'package:flutter_movie/model/actor_detail.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/ui/expansion_text.dart';
import 'package:flutter_movie/ui/movie_horizontal_scroller.dart';
import 'package:flutter_movie/util/movie_api.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:ui' as ui;

class ActorDetailPage extends StatefulWidget {
  String personId;
  Animation animation;
  ImageProvider avatar;
  String avatarUrl;

  ActorDetailPage({@required this.personId, this.avatar, this.avatarUrl});

  @override
  _ActorDetailPage createState() => _ActorDetailPage();
}

class _ActorDetailPage extends State<ActorDetailPage>
    with TickerProviderStateMixin {
  AnimationController detailController;
  AnimationController worksController;
  ActorDetailAnimation detailAnimation;
  ActorWorksAnimation worksAnimation;
  ActorDetail actorDetail;
  List<Subject> actorWorks;

  double top;

  int current = 0;
  bool isRequest = false;
  bool isEnd = false;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    detailController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2500));
    worksController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    detailAnimation = new ActorDetailAnimation(detailController);
    worksAnimation = new ActorWorksAnimation(worksController);

    _getActorDetail();
    _getActorWorks(0, 10);
  }

  @override
  void dispose() {
    super.dispose();
    detailController.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          actorDetail != null
              ?
//          Image(image: widget.avatar)
              Opacity(
                  opacity: detailAnimation.backdropOpacity.value,
                  child: FadeInImage.memoryNetwork(
                      fadeInDuration: Duration(milliseconds: 200),
                      placeholder: kTransparentImage,
                      image: actorDetail.avatars.small,
                      fit: BoxFit.cover))
              : SizedBox(),
          BackdropFilter(
              filter: ui.ImageFilter.blur(
//                  sigmaX: 8.0, sigmaY: 8.0
                  sigmaX: detailAnimation.backdropBlur.value,
                  sigmaY: detailAnimation.backdropBlur.value),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              )),
          _buildContent()
        ],
      ),
    );
  }

  _getActorDetail() async {
    Dio dio = new Dio();

    Response response = await dio.get(
        "${MovieApi.ACTOR_DETAIL_API + widget.personId}?apikey=${MovieApi.DOUBAN_API_KEY}");

    actorDetail = ActorDetail.fromJson(response.data);

    setState(() {
      detailController.forward();
    });
  }

  _getActorWorks(int start, int count) async {
    if (isRequest || isEnd) {
      return;
    }

    isRequest = true;

//    print("request ${start}");

    Dio dio = new Dio();

    Response response = await dio.get(
        "${MovieApi.ACTOR_DETAIL_API + widget.personId}/works?start=${start}&count=${count}&apikey=${MovieApi.DOUBAN_API_KEY}");

    List<Subject> rawWorks = response.data['works']
        .map((json) => Subject.fromJson(json['subject']))
        .toList()
        .cast<Subject>();

    if (actorWorks == null) {
      actorWorks =
          rawWorks.where((subject) => int.parse(subject.year) <= 2018).toList();
    } else {
      actorWorks
          .addAll(rawWorks.where((subject) => int.parse(subject.year) <= 2018));
    }

    current += count;

    if (rawWorks.length < count) {
      isEnd = true;
    }

    isRequest = false;

    setState(() {
      worksController.forward();
    });
  }

  Widget _buildWorks() {
    if (actorWorks == null) {
      return SizedBox();
    }

    _controller
      ..addListener(() {
//        print(
//            "${_controller.position.pixels} / ${_controller.position
//                .maxScrollExtent}");
        if (_controller.position.pixels >=
            _controller.position.maxScrollExtent * 0.6) {
          _getActorWorks(current, 10);
        }
      });

    return new AnimatedBuilder(
        animation: worksController,
        builder: (context, child) => Transform(
            transform: new Matrix4.translationValues(
                worksAnimation.worksTranslationX.value, 0.0, 0.0),
            child: Opacity(
                opacity: worksAnimation.worksOpacity.value,
                child: new MovieHorizontalScroller(
                  actorWorks,
                  title: "代表作品",
                  controller: _controller,
                  ratio: 0.7,
                  textColor: Colors.white,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    top = MediaQuery.of(context).padding.top;
    return AnimatedBuilder(
        animation: detailController, builder: _buildAnimation);
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildAvatar(), _buildInfo(), _buildWorks()],
      ),
    );
  }

  Widget _buildAvatar() {
    return new Transform(
        alignment: Alignment.center,
        transform: new Matrix4.diagonal3Values(
            detailAnimation.avatarAnimation.value,
            detailAnimation.avatarAnimation.value,
            1.0),
        child: Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white30)),
          margin: EdgeInsets.only(top: 32.0 + top, left: 16.0),
          padding: const EdgeInsets.all(6.0),
          child: new Hero(
              tag: 'tag-avatar-${widget.personId}',
              child: CircleAvatar(
                backgroundImage:
                    widget.avatar ?? Image.network(widget.avatarUrl).image,
                radius: 55.0,
              )),
        ));
  }

  Widget _buildInfo() {
    if (actorDetail == null) {
      return SizedBox();
    }

    return Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(actorDetail.name + '\n' + actorDetail.name_en,
                style: TextStyle(
                    color: Colors.white
                        .withOpacity(detailAnimation.nameOpacity.value),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
            SizedBox(height: 10.0),
            Text(
              actorDetail.born_place,
              style: TextStyle(
                  color: Colors.white
                      .withOpacity(detailAnimation.locationOpacity.value),
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0),
            ),
            Container(
              color: Colors.white.withOpacity(0.85),
              height: 1.0,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              width: detailAnimation.dividerWidth.value,
            ),
            Opacity(
              child: ExpansionText(actorDetail.summary,
//                maxLines: 7,
//                overflow: TextOverflow.ellipsis,
                  expandColor: Colors.tealAccent,
                  expandLine: 8,
                  textStyle: TextStyle(
                      height: 1.2,
                      color: Colors.white
                          .withOpacity(detailAnimation.contentOpacity.value),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0)),
              opacity: detailAnimation.contentOpacity.value,
            )
          ],
        ));
  }
}
