import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/video_card.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

class ArcBanner extends StatefulWidget {
  String bannerImage;
  String videoUrl;
  String videoTitle;

  ArcBanner({this.bannerImage, this.videoUrl, this.videoTitle});

  @override
  _ArcBannerState createState() => _ArcBannerState();
}

class _ArcBannerState extends State<ArcBanner> {
  VideoPlayerController _controller;

  void _initVideo() async {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..setLooping(true)
      ..setVolume(0.0)
      ..play();

    await _controller.initialize();
  }

  @override
  void initState() {
    if (widget.videoUrl != null) {
      _initVideo();
    }

    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: new ArcClipper(),
            child: widget.videoUrl != null
                ? VideoCard(
                    aspectRatio: screenWidth / 230.0,
                    title: widget.videoTitle,
                    controller: _controller)
                : FadeInImage.memoryNetwork(
                    fadeInDuration: Duration(milliseconds: 500),
                    placeholder: kTransparentImage,
                    image: widget.bannerImage,
                    width: screenWidth,
                    height: 230.0,
                    fit: BoxFit.cover))
      ],
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
