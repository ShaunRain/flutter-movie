import 'dart:convert' show json;

class ShortComment {

  int useful_count;
  String content;
  String created_at;
  String id;
  String subject_id;
  Author author;
  SingleRating rating;

  ShortComment.fromParams({this.useful_count, this.content, this.created_at, this.id, this.subject_id, this.author, this.rating});

  factory ShortComment(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ShortComment.fromJson(json.decode(jsonStr)) : new ShortComment.fromJson(jsonStr);

  ShortComment.fromJson(jsonRes) {
    useful_count = jsonRes['useful_count'];
    content = jsonRes['content'];
    created_at = jsonRes['created_at'];
    id = jsonRes['id'];
    subject_id = jsonRes['subject_id'];
    author = jsonRes['author'] == null ? null : new Author.fromJson(jsonRes['author']);
    rating = jsonRes['rating'] == null ? null : new SingleRating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"useful_count": $useful_count,"content": ${content != null?'${json.encode(content)}':'null'},"created_at": ${created_at != null?'${json.encode(created_at)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"subject_id": ${subject_id != null?'${json.encode(subject_id)}':'null'},"author": $author,"rating": $rating}';
  }
}

class SingleRating {

  num max;
  num min;
  num value;

  SingleRating.fromParams({this.max, this.min, this.value});

  SingleRating.fromJson(jsonRes) {
    max = jsonRes['max'];
    min = jsonRes['min'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"max": $max,"min": $min,"value": $value}';
  }
}

class Author {

  String alt;
  String avatar;
  String id;
  String name;
  String signature;
  String uid;

  Author.fromParams({this.alt, this.avatar, this.id, this.name, this.signature, this.uid});

  Author.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    avatar = jsonRes['avatar'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    signature = jsonRes['signature'];
    uid = jsonRes['uid'];
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"signature": ${signature != null?'${json.encode(signature)}':'null'},"uid": ${uid != null?'${json.encode(uid)}':'null'}}';
  }
}

