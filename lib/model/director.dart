import 'dart:convert' show json;

import 'package:flutter_movie/model/img.dart';

class Director {
  String alt;
  String id;
  String name;
  String name_en;
  Img avatars;

  Director.fromParams(
      {this.alt, this.id, this.name, this.name_en, this.avatars});

  Director.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    name_en = jsonRes['name_en'];
    avatars = jsonRes['avatars'] == null
        ? null
        : new Img.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null ? '${json.encode(alt)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"name_en": ${name_en != null ? '${json.encode(name_en)}' : 'null'},"avatars": $avatars}';
  }
}
