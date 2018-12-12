import 'package:flutter/material.dart';

class ScrollInAnimation extends StatefulWidget {
  Duration duration;
  Widget child;
  AnimationStatusListener statusListener;

  ScrollInAnimation(
      {this.duration = const Duration(milliseconds: 500),
      @required this.child,
      this.statusListener});

  @override
  _ScrollInAnimationState createState() => _ScrollInAnimationState();
}

class _ScrollInAnimationState extends State<ScrollInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> scrollInAnimation;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: widget.duration);

    scrollInAnimation = new Tween(begin: 300.0, end: 0.0).animate(
        new CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 1.0, curve: Curves.decelerate)));

    opacityAnimation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: animationController,
            curve: Interval(0.2, 0.5, curve: Curves.decelerate)));

    animationController
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..addStatusListener(widget.statusListener);

    animationController.forward(from: 0.0);

    super.initState();
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScrollInAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
//    if (oldWidget.child != widget.child) {
//      print('oldWidget.child != widget.child');
//      animationController.forward(from: 0.0);
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform:
            new Matrix4.translationValues(scrollInAnimation.value, 0.0, 0.0),
        child: Opacity(opacity: opacityAnimation.value, child: widget.child));
  }
}
