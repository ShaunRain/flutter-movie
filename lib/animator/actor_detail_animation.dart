import 'package:flutter/material.dart';
import 'package:flutter_movie/page/actor_detail_page.dart';

class ActorDetailAnimation {
  AnimationController controller;

  final Animation<double> avatarAnimation;
  final Animation<double> backdropBlur;
  final Animation<double> backdropOpacity;
  final Animation<double> nameOpacity;
  final Animation<double> locationOpacity;
  final Animation<double> dividerWidth;
  final Animation<double> contentOpacity;

  ActorDetailAnimation(this.controller)
      : avatarAnimation = new Tween(begin: 0.7, end: 1.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.1, 0.4, curve: Curves.elasticOut))),
        backdropBlur = new Tween(begin: 0.0, end: 8.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.2,
              0.8,
              curve: Curves.easeIn,
            ),
          ),
        ),
        backdropOpacity = new Tween(begin: 0.5, end: 1.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.2, 1.0, curve: Curves.easeIn))),
        nameOpacity = new Tween(begin: 0.0, end: 1.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.35, 0.85, curve: Curves.easeIn))),
        locationOpacity = new Tween(begin: 0.0, end: 0.85).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.45, 0.9, curve: Curves.easeIn))),
        dividerWidth = new Tween(begin: 0.0, end: 225.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.6, 0.85, curve: Curves.easeIn))),
        contentOpacity = new Tween(begin: 0.0, end: 1.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.7, 0.95, curve: Curves.easeIn)));
}
