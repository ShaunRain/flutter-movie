import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/page/movie_search_page.dart';
import 'package:flutter_movie/ui/movie_search.dart';
import 'package:flutter_movie/util/movie_api.dart';

class MovieAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 40.0;

  MovieAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
        padding: new EdgeInsets.only(top: statusBarHeight),
//      height: barHeight + statusBarHeight,
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: new Center(
          child: new Stack(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                child: new Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Popins',
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                  margin: const EdgeInsets.only(left: 12.0),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28.0,
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  new MovieSearchPage()))
//                        () => showSearch(context: context, delegate: _MovieSearchDelegate()),
                      ))
            ],
          ),
        ));
  }
}

class _MovieSearchDelegate extends SearchDelegate<String> {
  List<Subject> searchResult;
  Widget resultWidget;

  String _query;

  void requestSearch(BuildContext context) async {
    if (query == _query) {
      return;
    }

    Response response = await new Dio().get(MovieApi.MOVIE_SEARCH_API +
        '?q=${query}&apikey=${MovieApi.DOUBAN_API_KEY}&start=0&count=10');

    searchResult = response.data['subjects']
        .map((json) => Subject.fromJson(json))
        .toList()
        .cast<Subject>();

    _query = query;

    buildSuggestions(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            searchResult = null;
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    showResults(context);

    return searchResult != null && searchResult.length > 0
        ? ListView.builder(
            itemCount: searchResult.length,
            itemBuilder: (context, index) =>
                new MovieSearchItem(searchResult[index]))
        : Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    requestSearch(context);

    return searchResult != null && searchResult.length > 0
        ? ListView.builder(
            itemCount: searchResult.length,
            itemBuilder: (context, index) =>
                new MovieSearchItem(searchResult[index]))
        : Container();
  }
}
