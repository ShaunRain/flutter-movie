import 'package:flutter_movie/ui/video_card.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  void _initVideo() async {
    _controller = VideoPlayerController.network(
        'http://vt1.doubanio.com/201811072043/35f823e21b40a78d197832e7b1162548/view/movie/M/302370778.mp4')
      ..setLooping(true)
      ..setVolume(0.0)
      ..play();

    await _controller.initialize();
  }

  @override
  void initState() {
    super.initState();

    _initVideo();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
          body: Center(
              child: VideoCard(
        title: "Test",
        controller: _controller,
        aspectRatio: 3 / 2,
      ))),
    );
  }
}
