import 'dart:convert' show json;
import 'package:flutter_movie/model/actor_detail.dart';
import 'package:flutter_movie/model/cast.dart';
import 'package:flutter_movie/model/director.dart';
import 'package:flutter_movie/model/img.dart';
import 'package:flutter_movie/model/rating.dart';

class MovieInfo {
  int collect_count;
  String alt;
  String id;
  String original_title;
  String subtype;
  String title;
  String year;
  List<Cast> casts;
  List<Director> directors;
  List<String> genres;
  Img images;
  Rating rating;

  MovieInfo.fromParams(
      {this.collect_count,
      this.alt,
      this.id,
      this.original_title,
      this.subtype,
      this.title,
      this.year,
      this.casts,
      this.directors,
      this.genres,
      this.images,
      this.rating});

  factory MovieInfo(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MovieInfo.fromJson(json.decode(jsonStr))
          : new MovieInfo.fromJson(jsonStr);

  MovieInfo.fromJson(jsonRes) {
    collect_count = jsonRes['collect_count'];
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    original_title = jsonRes['original_title'];
    subtype = jsonRes['subtype'];
    title = jsonRes['title'];
    year = jsonRes['year'];
    casts = jsonRes['casts'] == null ? null : [];

    for (var castsItem in casts == null ? [] : jsonRes['casts']) {
      casts.add(castsItem == null ? null : new Cast.fromJson(castsItem));
    }

    directors = jsonRes['directors'] == null ? null : [];

    for (var directorsItem in directors == null ? [] : jsonRes['directors']) {
      directors.add(
          directorsItem == null ? null : new Director.fromJson(directorsItem));
    }

    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']) {
      genres.add(genresItem);
    }

    images =
        jsonRes['images'] == null ? null : new Img.fromJson(jsonRes['images']);
    rating = jsonRes['rating'] == null
        ? null
        : new Rating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"collect_count": $collect_count,"alt": ${alt != null ? '${json.encode(alt)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"original_title": ${original_title != null ? '${json.encode(original_title)}' : 'null'},"subtype": ${subtype != null ? '${json.encode(subtype)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"year": ${year != null ? '${json.encode(year)}' : 'null'},"casts": $casts,"directors": $directors,"genres": $genres,"images": $images,"rating": $rating}';
  }
}
