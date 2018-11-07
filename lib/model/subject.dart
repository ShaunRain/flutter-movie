import 'dart:convert' show json;

import 'package:flutter_movie/model/cast.dart';
import 'package:flutter_movie/model/director.dart';
import 'package:flutter_movie/model/img.dart';
import 'package:flutter_movie/model/rating.dart';

class Subject {
  int collect_count;
  bool has_video;
  String alt;
  String id;
  String mainland_pubdate;
  String original_title;
  String subtype;
  String title;
  String year;
  List<Cast> casts;
  List<Director> directors;
  List<String> durations;
  List<String> genres;
  List<String> pubdates;
  Img images;
  Rating rating;

  Subject.fromParams(
      {this.collect_count,
        this.has_video,
        this.alt,
        this.id,
        this.mainland_pubdate,
        this.original_title,
        this.subtype,
        this.title,
        this.year,
        this.casts,
        this.directors,
        this.durations,
        this.genres,
        this.pubdates,
        this.images,
        this.rating});

  Subject.fromJson(jsonRes) {
    collect_count = jsonRes['collect_count'];
    has_video = jsonRes['has_video'];
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    mainland_pubdate = jsonRes['mainland_pubdate'];
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

    durations = jsonRes['durations'] == null ? null : [];

    for (var durationsItem in durations == null ? [] : jsonRes['durations']) {
      durations.add(durationsItem);
    }

    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']) {
      genres.add(genresItem);
    }

    pubdates = jsonRes['pubdates'] == null ? null : [];

    for (var pubdatesItem in pubdates == null ? [] : jsonRes['pubdates']) {
      pubdates.add(pubdatesItem);
    }

    images =
    jsonRes['images'] == null ? null : new Img.fromJson(jsonRes['images']);
    rating = jsonRes['rating'] == null
        ? null
        : new Rating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"collect_count": $collect_count,"has_video": $has_video,"alt": ${alt != null ? '${json.encode(alt)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"mainland_pubdate": ${mainland_pubdate != null ? '${json.encode(mainland_pubdate)}' : 'null'},"original_title": ${original_title != null ? '${json.encode(original_title)}' : 'null'},"subtype": ${subtype != null ? '${json.encode(subtype)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"year": ${year != null ? '${json.encode(year)}' : 'null'},"casts": $casts,"directors": $directors,"durations": $durations,"genres": $genres,"pubdates": $pubdates,"images": $images,"rating": $rating}';
  }
}