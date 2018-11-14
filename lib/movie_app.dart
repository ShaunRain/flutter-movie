import 'package:flutter/material.dart';
import 'package:flutter_movie/page/movie_home_page.dart';
import 'package:flutter_movie/ui/app_bar.dart';
import 'package:flutter_movie/ui/bottom_navigation.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> with TickerProviderStateMixin {
  int _currentIndex = 1;
  List<NavigationIconView> _navigationViews;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: 1);

    _navigationViews = <NavigationIconView>[
      NavigationIconView(
          icon: Icon(Icons.movie_filter),
          title: "精选",
          color: Colors.teal,
          vsync: this),
      NavigationIconView(
          icon: Icon(Icons.explore),
          title: "发现",
          color: Colors.teal,
          vsync: this),
      NavigationIconView(
          icon: Icon(Icons.account_box),
          title: "我的",
          color: Colors.teal,
          vsync: this)
    ];
  }

//  Widget _buildTransitionStack() {
//    List<FadeTransition> transitions = <FadeTransition>[];
//
//    transitions.add(_navigationViews[0].transition(context, new Container()));
//    transitions
//        .add(_navigationViews[1].transition(context, new MovieHomePage()));
//    transitions.add(_navigationViews[2].transition(context, new Container()));
//
//    transitions.sort((FadeTransition a, FadeTransition b) {
//      Animation animationA = a.opacity;
//      Animation animationB = b.opacity;
//      return animationA.value.compareTo(animationB.value);
//    });
//
//    return Stack(children: transitions);
//  }

//  @override
//  void dispose() {
//    for (NavigationIconView view in _navigationViews) {
//      view.controller.dispose();
//    }
//    super.dispose();
//  }

  void _switchBar(int index) {
    setState(() {
//      _navigationViews[_currentIndex].controller.reverse();
      _currentIndex = index;
//      _navigationViews[_currentIndex].controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar navigationBar = BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationView) => navigationView.item)
            .toList(),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          _switchBar(index);

          pageController.jumpToPage(index);
        });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Flexible(flex: 1, child: MovieAppBar('MOVIE')),
          new Flexible(
              flex: 8,
              child: new PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) => _switchBar(index),
                children: <Widget>[
                  Container(),
                  new MovieHomePage(),
                  Container(),
                ],
              )),
        ],
      ),
      bottomNavigationBar: navigationBar,
    );
  }
}
