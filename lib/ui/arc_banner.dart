import 'package:flutter/material.dart';
import 'package:flutter_movie/ui/video_card.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

class ArcBanner extends StatefulWidget {
  String bannerImage;
  String videoUrl;
  String videoTitle;
  ImageProvider imageProvider;

  ArcBanner(
      {this.bannerImage, this.videoUrl, this.videoTitle, this.imageProvider});

  @override
  _ArcBannerState createState() => _ArcBannerState();
}

class _ArcBannerState extends State<ArcBanner> {
  VideoPlayerController _controller;
  bool isPlaying;
  PaletteGenerator paletteGenerator;

  _generatePaletteButton() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        widget.imageProvider,
        size: Size(80.0, 80.0),
        region: Offset.zero & Size(80.0, 80.0));

    print(paletteGenerator);

    setState(() {});
  }

  void _initVideo() async {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..setLooping(true)
      ..setVolume(0.0)
      ..play();

    await _controller.initialize();
  }

  @override
  void initState() {
    isPlaying = false;

    if (widget.videoUrl != null && widget.videoUrl.isNotEmpty) {
      _generatePaletteButton();
    }

    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      isPlaying = !isPlaying;

      if (isPlaying && widget.videoUrl != null) {
        _initVideo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: new ArcClipper(),
            child: isPlaying
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
                    fit: BoxFit.cover)),
        paletteGenerator != null && widget.videoUrl != null
            ? Positioned(
                top: 150.0,
                left: MediaQuery.of(context).size.width * 0.8,
                child: FloatingActionButton(
                  child: Icon(
                    isPlaying ? Icons.videocam_off : Icons.videocam,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  onPressed: () => _togglePlay(),
                  shape: CircleBorder(),
                  backgroundColor: paletteGenerator.dominantColor?.color ?? Colors.white70,
                ))
            : Container()
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
    var firstEndPoint = Offset(size.width * 1 / 3, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 2 / 3, size.height);
    var secondEndPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
