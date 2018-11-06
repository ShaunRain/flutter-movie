import 'package:flutter/material.dart';

class MovieHomeAnimator extends StatefulWidget {
  @override
  _MovieHomeAnimatorState createState() => _MovieHomeAnimatorState();
}

class _MovieHomeAnimatorState extends State<MovieHomeAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
