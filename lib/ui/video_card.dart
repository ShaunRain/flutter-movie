import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatelessWidget {
  final VideoPlayerController controller;
  final String title;
  final double aspectRatio;

  VideoCard(
      {@required this.controller, this.title, @required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    void pushFullScreenWidget() {
      final TransitionRoute<void> route = PageRouteBuilder<void>(
          settings: RouteSettings(name: title, isInitialRoute: false),
          pageBuilder: (_, __, ___) => _buildFullScreenVideo());

      route.completed.then((result) => controller.setVolume(0.0));

      controller.setVolume(1.0);
      Navigator.push(context, route);
    }

    return SafeArea(
        top: false,
        bottom: false,
        child: GestureDetector(
          child: _buildInlineVideo(),
          onTap: pushFullScreenWidget,
        ));
  }

  Widget _buildInlineVideo() {
    return AspectRatio(
        aspectRatio: aspectRatio,
        child: Hero(tag: controller, child: VideoPlayerLoading(controller)));
  }

  Widget _buildFullScreenVideo() {
    return Scaffold(
      appBar: AppBar(
          title: Text(title, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent),
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Hero(tag: controller, child: VideoPlayPause(controller)),
        ),
      ),
    );
  }
}

class VideoPlayerLoading extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerLoading(this.controller);

  @override
  _VideoPlayerLoadingState createState() => _VideoPlayerLoadingState();
}

class _VideoPlayerLoadingState extends State<VideoPlayerLoading> {
  bool _initialized;

  @override
  void initState() {
    super.initState();
    _initialized = widget.controller.value.initialized;
    widget.controller.addListener(() {
      if (!mounted) {
        return;
      }
      final bool controllerInitialized = widget.controller.value.initialized;
      if (_initialized != controllerInitialized) {
        setState(() {
          _initialized = controllerInitialized;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return VideoPlayer(widget.controller);
    }
    return Stack(
      children: <Widget>[
        VideoPlayer(widget.controller),
        const Center(child: CircularProgressIndicator()),
      ],
      fit: StackFit.expand,
    );
  }
}

class VideoPlayPause extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayPause(this.controller);

  @override
  State createState() => _VideoPlayPauseState();
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  FadeAnimation imageFadeAnimation;
  VoidCallback listener;

  _VideoPlayPauseState() {
    listener = () {
      if (mounted) setState(() {});
    };
  }

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          child: VideoPlayerLoading(controller),
          onTap: () {
            if (!controller.value.initialized) {
              return;
            }
            if (controller.value.isPlaying) {
              imageFadeAnimation = const FadeAnimation(
                child: Icon(Icons.pause, size: 100.0),
              );
              controller.pause();
            } else {
              imageFadeAnimation = const FadeAnimation(
                child: Icon(Icons.play_arrow, size: 100.0),
              );
              controller.play();
            }
          },
        ),
        Center(child: imageFadeAnimation),
      ],
    );
  }
}

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeAnimation({
    this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? Opacity(
            opacity: 1.0 - animationController.value,
            child: widget.child,
          )
        : Container();
  }
}
