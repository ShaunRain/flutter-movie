import 'package:flutter/material.dart';

class NavigationIconView {
  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem _item;
  final AnimationController _controller;
  Animation<double> _animation;

  AnimationController get controller => _controller;

  BottomNavigationBarItem get item => _item;

  NavigationIconView(
      {Widget icon,
      Widget activeIcon,
      Color color,
      String title,
      TickerProvider vsync})
      : _icon = icon,
        _color = color,
        _title = title,
        _item = BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
            title: Text(title),
            backgroundColor: color),
        _controller = new AnimationController(
            vsync: vsync, duration: kThemeAnimationDuration) {
    _animation = _controller.drive(CurveTween(
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));
  }

  FadeTransition transition(BuildContext context, Widget page) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position:
            _animation.drive(Tween(begin: Offset(0.0, 0.02), end: Offset.zero)),
        child: page,
      ),
    );
  }
}
