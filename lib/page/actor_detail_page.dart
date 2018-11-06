import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/actor_detail.dart';
import 'package:flutter_movie/util/movie_api.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:ui' as ui;

class ActorDetailPage extends StatefulWidget {
  num personId;
  Animation animation;
  ImageProvider avatar;

  ActorDetailPage(
      {@required this.personId,
      @required this.avatar,
      AnimationController controller});

  @override
  _ActorDetailPage createState() => _ActorDetailPage();
}

class _ActorDetailPage extends State<ActorDetailPage> {
  ActorDetail actorDetail;

  double top;

  @override
  void initState() {
    super.initState();
    _getActorDetail();
  }

  _getActorDetail() async {
    Dio dio = new Dio();
    Response response = await dio.get(MovieApi.ACTOR_DETAIL_API +
        "?cityId=974&personId=" +
        widget.personId.toString());

    actorDetail = ActorDetail.fromJson(response.data['data']['background']);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          actorDetail != null
              ? FadeInImage.memoryNetwork(
                  fadeInDuration: Duration(milliseconds: 200),
                  placeholder: kTransparentImage,
                  image: actorDetail.image,
                  fit: BoxFit.cover)
              : SizedBox(),
          BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              )),
          _buildContent()
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildAvatar()],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.white30)),
      margin: EdgeInsets.only(top: 32.0 + top, left: 16.0),
      padding: const EdgeInsets.all(6.0),
      child: new Hero(
          tag: 'tag-avatar-${widget.personId}',
          child: CircleAvatar(
            backgroundImage: widget.avatar,
            radius: 55.0,
          )),
    );
  }
}
