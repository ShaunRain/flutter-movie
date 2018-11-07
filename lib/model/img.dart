import 'dart:convert' show json;

class Img {
  String large;
  String medium;
  String small;

  Img.fromParams({this.large, this.medium, this.small});

  Img.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null ? '${json.encode(large)}' : 'null'},"medium": ${medium != null ? '${json.encode(medium)}' : 'null'},"small": ${small != null ? '${json.encode(small)}' : 'null'}}';
  }
}