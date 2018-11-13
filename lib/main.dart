import 'package:flutter/material.dart';
import 'package:flutter_movie/movie_app.dart';
import 'package:flutter_movie/page/movie_home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MovieApp(),
    );
  }
}