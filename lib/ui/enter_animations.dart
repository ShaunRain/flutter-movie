import 'package:flutter/material.dart';

class EnterAnimations {
  final AnimationController controller;

  final Animation<double> scrollerTranslation;
  final Animation<double> scrollerOpacity;

  EnterAnimations(this.controller) :
        scrollerTranslation = new Tween(begin: 120.0, end: 0.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.66, 1.0, curve: Curves.ease))),
        scrollerOpacity = new Tween(begin: 0.0, end: 1.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.66, 1.0, curve: Curves.fastOutSlowIn)));
}
