import 'dart:convert' show json;

class Rating {
  int max;
  int min;
  num average;
  String stars;
  Object details;

  Rating.fromParams(
      {this.max, this.min, this.average, this.stars, this.details});

  Rating.fromJson(jsonRes) {
    max = jsonRes['max'];
    min = jsonRes['min'];
    average = jsonRes['average'];
    stars = jsonRes['stars'];
    details = jsonRes['details'];
  }

  @override
  String toString() {
    return '{"max": $max,"min": $min,"average": $average,"stars": ${stars != null ? '${json.encode(stars)}' : 'null'},"details": $details}';
  }
}
