import 'package:flutter/material.dart';
import 'package:flutter_movie/page/actor_detail_page.dart';

class ActorWorksAnimation {
  AnimationController controller;

  final Animation<double> worksOpacity;
  final Animation<double> worksTranslationX;

  ActorWorksAnimation(this.controller)
      : worksOpacity = new Tween(begin: 0.0, end: 1.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.75, 1.0, curve: Curves.easeIn))),
        worksTranslationX = new Tween(begin: 100.0, end: 0.0).animate(
            new CurvedAnimation(
                parent: controller,
                curve: new Interval(0.75, 1.0, curve: Curves.ease)));
}
