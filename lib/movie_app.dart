import 'package:flutter/material.dart';
import 'package:flutter_movie/page/movie_home_page.dart';
import 'package:flutter_movie/page/movie_selected_page.dart';
import 'package:flutter_movie/ui/app_bar.dart';
import 'package:flutter_movie/ui/bottom_navigation.dart';
import 'package:flutter_movie/ui/tinder_swap_card.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> with TickerProviderStateMixin {
  int _currentIndex = 1;
  List<NavigationIconView> _navigationViews;
  PageController pageController;

  List<ColorSwatch> colors;
  List<MovieAppBar> appBars;

  TabController _tabController;

  MovieAppBar appBar;

  List<String> welcomeImages = [
    "assets/welcome0.png",
    "assets/welcome1.png",
    "assets/welcome2.png",
    "assets/welcome2.png",
    "assets/welcome1.png",
    "assets/welcome1.png"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);

    appBars = [
      MovieAppBar([Colors.amber, Colors.amberAccent],
          centerWidget: _buildTabBar(), showSearch: false),
      MovieAppBar([Colors.teal, Colors.tealAccent]),
      MovieAppBar([Colors.lightBlue, Colors.lightBlueAccent])
    ];

    appBar = appBars[1];

    pageController = new PageController(initialPage: 1);

    _navigationViews = <NavigationIconView>[
      NavigationIconView(
          icon: Icon(Icons.movie_filter),
          title: "精选",
          color: Colors.amber,
          vsync: this),
      NavigationIconView(
          icon: Icon(Icons.explore),
          title: "发现",
          color: Colors.teal,
          vsync: this),
      NavigationIconView(
          icon: Icon(Icons.account_box),
          title: "我的",
          color: Colors.lightBlue,
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
      appBar = appBars[index];
    });
  }

  Widget _buildTabBar() {
    return TabBar(
        indicatorColor: Colors.white,
        controller: _tabController,
        isScrollable: true,
        tabs: <Tab>[
          Tab(text: 'TOP250', icon: Icon(Icons.stars)),
          Tab(text: '新片榜', icon: Icon(Icons.fiber_new)),
          Tab(text: '北美票房榜', icon: Icon(Icons.monetization_on)),
        ]);
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
          new Flexible(flex: 1, child: appBar),
          new Flexible(
              flex: _currentIndex == 0 ? 6 : 8,
              child: new PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) => _switchBar(index),
                children: <Widget>[
                  new MovieSelectedPage(),
                  new MovieHomePage(),
                  new Scaffold(
                    body: Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: new TinderSwapCard(
                              orientation: AmassOrientation.BOTTOM,
                              totalNum: 6,
                              stackNum: 3,
                              maxWidth: MediaQuery.of(context).size.width * 0.9,
                              maxHeight:
                                  MediaQuery.of(context).size.width * 0.9,
                              minWidth: MediaQuery.of(context).size.width * 0.8,
                              minHeight:
                                  MediaQuery.of(context).size.width * 0.8,
                              cardBuilder: (context, index) => Card(
                                    child:
                                        Image.asset('${welcomeImages[index]}'),
                                  ),
                            ))),
                  ),
                ],
              )),
        ],
      ),
      bottomNavigationBar: navigationBar,
    );
  }
}
