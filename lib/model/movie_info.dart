import 'dart:convert' show json;

class MovieInfo {
  int length;
  int movieId;
  int rDay;
  int rMonth;
  int rYear;
  int wantedCount;
  num ratingFinal;
  bool is3D;
  bool isDMAX;
  bool isFilter;
  bool isHot;
  bool isIMAX;
  bool isIMAX3D;
  bool isNew;
  String actorName1;
  String actorName2;
  String btnText;
  String commonSpecial;
  String directorName;
  String img;
  String titleCn;
  String titleEn;
  String type;
  NearestShowTime nearestShowtime;

  MovieInfo.fromParams(
      {this.length,
      this.movieId,
      this.rDay,
      this.rMonth,
      this.rYear,
      this.wantedCount,
      this.ratingFinal,
      this.is3D,
      this.isDMAX,
      this.isFilter,
      this.isHot,
      this.isIMAX,
      this.isIMAX3D,
      this.isNew,
      this.actorName1,
      this.actorName2,
      this.btnText,
      this.commonSpecial,
      this.directorName,
      this.img,
      this.titleCn,
      this.titleEn,
      this.type,
      this.nearestShowtime});

  factory MovieInfo(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new MovieInfo.fromJson(json.decode(jsonStr))
          : new MovieInfo.fromJson(jsonStr);

  MovieInfo.fromJson(jsonRes) {
    length = jsonRes['length'];
    movieId = jsonRes['movieId'];
    rDay = jsonRes['rDay'];
    rMonth = jsonRes['rMonth'];
    rYear = jsonRes['rYear'];
    wantedCount = jsonRes['wantedCount'];
    ratingFinal = jsonRes['ratingFinal'];
    is3D = jsonRes['is3D'];
    isDMAX = jsonRes['isDMAX'];
    isFilter = jsonRes['isFilter'];
    isHot = jsonRes['isHot'];
    isIMAX = jsonRes['isIMAX'];
    isIMAX3D = jsonRes['isIMAX3D'];
    isNew = jsonRes['isNew'];
    actorName1 = jsonRes['actorName1'];
    actorName2 = jsonRes['actorName2'];
    btnText = jsonRes['btnText'];
    commonSpecial = jsonRes['commonSpecial'];
    directorName = jsonRes['directorName'];
    img = jsonRes['img'];
    titleCn = jsonRes['titleCn'];
    titleEn = jsonRes['titleEn'];
    type = jsonRes['type'];
    nearestShowtime = jsonRes['nearestShowtime'] == null
        ? null
        : new NearestShowTime.fromJson(jsonRes['nearestShowtime']);
  }

  @override
  String toString() {
    return '{"length": $length,"movieId": $movieId,"rDay": $rDay,"rMonth": $rMonth,"rYear": $rYear,"wantedCount": $wantedCount,"ratingFinal": $ratingFinal,"is3D": $is3D,"isDMAX": $isDMAX,"isFilter": $isFilter,"isHot": $isHot,"isIMAX": $isIMAX,"isIMAX3D": $isIMAX3D,"isNew": $isNew,"actorName1": ${actorName1 != null ? '${json.encode(actorName1)}' : 'null'},"actorName2": ${actorName2 != null ? '${json.encode(actorName2)}' : 'null'},"btnText": ${btnText != null ? '${json.encode(btnText)}' : 'null'},"commonSpecial": ${commonSpecial != null ? '${json.encode(commonSpecial)}' : 'null'},"directorName": ${directorName != null ? '${json.encode(directorName)}' : 'null'},"img": ${img != null ? '${json.encode(img)}' : 'null'},"titleCn": ${titleCn != null ? '${json.encode(titleCn)}' : 'null'},"titleEn": ${titleEn != null ? '${json.encode(titleEn)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"nearestShowtime": $nearestShowtime}';
  }
}

class NearestShowTime {
  int nearestCinemaCount;
  int nearestShowDay;
  int nearestShowtimeCount;
  bool isTicket;

  NearestShowTime.fromParams(
      {this.nearestCinemaCount,
      this.nearestShowDay,
      this.nearestShowtimeCount,
      this.isTicket});

  NearestShowTime.fromJson(jsonRes) {
    nearestCinemaCount = jsonRes['nearestCinemaCount'];
    nearestShowDay = jsonRes['nearestShowDay'];
    nearestShowtimeCount = jsonRes['nearestShowtimeCount'];
    isTicket = jsonRes['isTicket'];
  }

  @override
  String toString() {
    return '{"nearestCinemaCount": $nearestCinemaCount,"nearestShowDay": $nearestShowDay,"nearestShowtimeCount": $nearestShowtimeCount,"isTicket": $isTicket}';
  }
}
