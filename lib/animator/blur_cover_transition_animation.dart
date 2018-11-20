import 'package:flutter/material.dart';

class BlurCoverTransitionAnimation {
  AnimationController controller;

  final Animation<double> fadeOut;
  final Animation<double> fadeIn;

  BlurCoverTransitionAnimation(this.controller)
      : fadeOut = new Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
            parent: controller,
            curve: new Interval(0.0, 0.75, curve: Curves.easeIn))),
        fadeIn = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
            parent: controller,
            curve: new Interval(0.25, 1.0, curve: Curves.easeIn)));
}
