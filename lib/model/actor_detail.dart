import 'dart:convert' show json;

import 'package:flutter_movie/model/cast.dart';
import 'package:flutter_movie/model/director.dart';
import 'package:flutter_movie/model/img.dart';
import 'package:flutter_movie/model/rating.dart';
import 'package:flutter_movie/model/subject.dart';

class ActorDetail {
  String alt;
  String birthday;
  String born_place;
  String constellation;
  String gender;
  String id;
  String mobile_url;
  String name;
  String name_en;
  String summary;
  String website;
  List<String> aka;
  List<String> aka_en;
  List<Photo> photos;
  List<String> professions;
  List<Role> works;
  Img avatars;

  ActorDetail.fromParams(
      {this.alt,
      this.birthday,
      this.born_place,
      this.constellation,
      this.gender,
      this.id,
      this.mobile_url,
      this.name,
      this.name_en,
      this.summary,
      this.website,
      this.aka,
      this.aka_en,
      this.photos,
      this.professions,
      this.works,
      this.avatars});

  factory ActorDetail(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ActorDetail.fromJson(json.decode(jsonStr))
          : new ActorDetail.fromJson(jsonStr);

  ActorDetail.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    birthday = jsonRes['birthday'];
    born_place = jsonRes['born_place'];
    constellation = jsonRes['constellation'];
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    mobile_url = jsonRes['mobile_url'];
    name = jsonRes['name'];
    name_en = jsonRes['name_en'];
    summary = jsonRes['summary'];
    website = jsonRes['website'];
    aka = jsonRes['aka'] == null ? null : [];

    for (var akaItem in aka == null ? [] : jsonRes['aka']) {
      aka.add(akaItem);
    }

    aka_en = jsonRes['aka_en'] == null ? null : [];

    for (var aka_enItem in aka_en == null ? [] : jsonRes['aka_en']) {
      aka_en.add(aka_enItem);
    }

    photos = jsonRes['photos'] == null ? null : [];

    for (var photosItem in photos == null ? [] : jsonRes['photos']) {
      photos.add(photosItem == null ? null : new Photo.fromJson(photosItem));
    }

    professions = jsonRes['professions'] == null ? null : [];

    for (var professionsItem
        in professions == null ? [] : jsonRes['professions']) {
      professions.add(professionsItem);
    }

    works = jsonRes['works'] == null ? null : [];

    for (var worksItem in works == null ? [] : jsonRes['works']) {
      works.add(worksItem == null ? null : new Role.fromJson(worksItem));
    }

    avatars = jsonRes['avatars'] == null
        ? null
        : new Img.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null ? '${json.encode(alt)}' : 'null'},"birthday": ${birthday != null ? '${json.encode(birthday)}' : 'null'},"born_place": ${born_place != null ? '${json.encode(born_place)}' : 'null'},"constellation": ${constellation != null ? '${json.encode(constellation)}' : 'null'},"gender": ${gender != null ? '${json.encode(gender)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"mobile_url": ${mobile_url != null ? '${json.encode(mobile_url)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"name_en": ${name_en != null ? '${json.encode(name_en)}' : 'null'},"summary": ${summary != null ? '${json.encode(summary)}' : 'null'},"website": ${website != null ? '${json.encode(website)}' : 'null'},"aka": $aka,"aka_en": $aka_en,"photos": $photos,"professions": $professions,"works": $works,"avatars": $avatars}';
  }
}

class Role {
  List<String> roles;
  Subject subject;

  Role.fromParams({this.roles, this.subject});

  Role.fromJson(jsonRes) {
    roles = jsonRes['roles'] == null ? null : [];

    for (var rolesItem in roles == null ? [] : jsonRes['roles']) {
      roles.add(rolesItem);
    }

    subject = jsonRes['subject'] == null
        ? null
        : new Subject.fromJson(jsonRes['subject']);
  }

  @override
  String toString() {
    return '{"roles": $roles,"subject": $subject}';
  }
}

class Photo {
  String alt;
  String cover;
  String icon;
  String id;
  String image;
  String thumb;

  Photo.fromParams(
      {this.alt, this.cover, this.icon, this.id, this.image, this.thumb});

  Photo.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    cover = jsonRes['cover'];
    icon = jsonRes['icon'];
    id = jsonRes['id'];
    image = jsonRes['image'];
    thumb = jsonRes['thumb'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null ? '${json.encode(alt)}' : 'null'},"cover": ${cover != null ? '${json.encode(cover)}' : 'null'},"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"image": ${image != null ? '${json.encode(image)}' : 'null'},"thumb": ${thumb != null ? '${json.encode(thumb)}' : 'null'}}';
  }
}
