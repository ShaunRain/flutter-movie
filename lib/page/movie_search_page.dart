import 'package:flutter/material.dart';
import 'package:flutter_movie/model/subject.dart';
import 'package:flutter_movie/ui/movie_search.dart';
import 'package:material_search/material_search.dart';
import 'package:dio/dio.dart';
import 'package:flutter_movie/util/movie_api.dart';

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  requestSearch(String query) async {
    Response response = await new Dio().get(MovieApi.MOVIE_SEARCH_API +
        '?q=${query}&apikey=${MovieApi.DOUBAN_API_KEY}&start=0&count=10');

    return response.data['subjects']
        .map((json) => Subject.fromJson(json))
        .toList()
        .cast<Subject>();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new MaterialSearch<Subject>(
        placeholder: '输入电影名',
        getResults: (String query) async {
          List<Subject> results = await requestSearch(query);
          return results
              .map((subject) => new MovieSearchItem<Subject>(subject))
              .toList();
        },
      ),
    );
  }
}
