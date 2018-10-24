import 'dart:convert' show json;

class MovieDetail {

  Object community;
  Object quizGame;
  int hotRanking;
  int movieId;
  double overallRating;
  int personCount;
  int showCinemaCount;
  int showDay;
  int showtimeCount;
  int totalNominateAward;
  int totalWinAward;
  bool is3D;
  bool isDMAX;
  bool isEggHunt;
  bool isFilter;
  bool isIMAX;
  bool isIMAX3D;
  bool isTicket;
  String commentSpecial;
  String img;
  String message;
  String mins;
  String name;
  String nameEn;
  String releaseArea;
  String releaseDate;
  String story;
  String url;
  List<Actor> actors;
  List<String> festivals;
  List<String> type;
  Award award;
  Director director;
  StageImg stageImg;
  Style style;
  Video video;

  MovieDetail.fromParams({this.community, this.quizGame, this.hotRanking, this.movieId, this.overallRating, this.personCount, this.showCinemaCount, this.showDay, this.showtimeCount, this.totalNominateAward, this.totalWinAward, this.is3D, this.isDMAX, this.isEggHunt, this.isFilter, this.isIMAX, this.isIMAX3D, this.isTicket, this.commentSpecial, this.img, this.message, this.mins, this.name, this.nameEn, this.releaseArea, this.releaseDate, this.story, this.url, this.actors, this.festivals, this.type, this.award, this.director, this.stageImg, this.style, this.video});

  factory MovieDetail(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MovieDetail.fromJson(json.decode(jsonStr)) : new MovieDetail.fromJson(jsonStr);

  MovieDetail.fromJson(jsonRes) {
    community = jsonRes['community'];
    quizGame = jsonRes['quizGame'];
    hotRanking = jsonRes['hotRanking'];
    movieId = jsonRes['movieId'];
    overallRating = jsonRes['overallRating'];
    personCount = jsonRes['personCount'];
    showCinemaCount = jsonRes['showCinemaCount'];
    showDay = jsonRes['showDay'];
    showtimeCount = jsonRes['showtimeCount'];
    totalNominateAward = jsonRes['totalNominateAward'];
    totalWinAward = jsonRes['totalWinAward'];
    is3D = jsonRes['is3D'];
    isDMAX = jsonRes['isDMAX'];
    isEggHunt = jsonRes['isEggHunt'];
    isFilter = jsonRes['isFilter'];
    isIMAX = jsonRes['isIMAX'];
    isIMAX3D = jsonRes['isIMAX3D'];
    isTicket = jsonRes['isTicket'];
    commentSpecial = jsonRes['commentSpecial'];
    img = jsonRes['img'];
    message = jsonRes['message'];
    mins = jsonRes['mins'];
    name = jsonRes['name'];
    nameEn = jsonRes['nameEn'];
    releaseArea = jsonRes['releaseArea'];
    releaseDate = jsonRes['releaseDate'];
    story = jsonRes['story'];
    url = jsonRes['url'];
    actors = jsonRes['actors'] == null ? null : [];

    for (var actorsItem in actors == null ? [] : jsonRes['actors']){
      actors.add(actorsItem == null ? null : new Actor.fromJson(actorsItem));
    }

    festivals = jsonRes['festivals'] == null ? null : [];

    for (var festivalsItem in festivals == null ? [] : jsonRes['festivals']){
      festivals.add(festivalsItem);
    }

    type = jsonRes['type'] == null ? null : [];

    for (var typeItem in type == null ? [] : jsonRes['type']){
      type.add(typeItem);
    }

    award = jsonRes['award'] == null ? null : new Award.fromJson(jsonRes['award']);
    director = jsonRes['director'] == null ? null : new Director.fromJson(jsonRes['director']);
    stageImg = jsonRes['stageImg'] == null ? null : new StageImg.fromJson(jsonRes['stageImg']);
    style = jsonRes['style'] == null ? null : new Style.fromJson(jsonRes['style']);
    video = jsonRes['video'] == null ? null : new Video.fromJson(jsonRes['video']);
  }

  @override
  String toString() {
    return '{"community": $community,"quizGame": $quizGame,"hotRanking": $hotRanking,"movieId": $movieId,"overallRating": $overallRating,"personCount": $personCount,"showCinemaCount": $showCinemaCount,"showDay": $showDay,"showtimeCount": $showtimeCount,"totalNominateAward": $totalNominateAward,"totalWinAward": $totalWinAward,"is3D": $is3D,"isDMAX": $isDMAX,"isEggHunt": $isEggHunt,"isFilter": $isFilter,"isIMAX": $isIMAX,"isIMAX3D": $isIMAX3D,"isTicket": $isTicket,"commentSpecial": ${commentSpecial != null?'${json.encode(commentSpecial)}':'null'},"img": ${img != null?'${json.encode(img)}':'null'},"message": ${message != null?'${json.encode(message)}':'null'},"mins": ${mins != null?'${json.encode(mins)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"nameEn": ${nameEn != null?'${json.encode(nameEn)}':'null'},"releaseArea": ${releaseArea != null?'${json.encode(releaseArea)}':'null'},"releaseDate": ${releaseDate != null?'${json.encode(releaseDate)}':'null'},"story": ${story != null?'${json.encode(story)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'},"actors": $actors,"festivals": $festivals,"type": $type,"award": $award,"director": $director,"stageImg": $stageImg,"style": $style,"video": $video}';
  }
}

class Video {

  int count;
  int videoId;
  String hightUrl;
  String img;
  String title;
  String url;

  Video.fromParams({this.count, this.videoId, this.hightUrl, this.img, this.title, this.url});

  Video.fromJson(jsonRes) {
    count = jsonRes['count'];
    videoId = jsonRes['videoId'];
    hightUrl = jsonRes['hightUrl'];
    img = jsonRes['img'];
    title = jsonRes['title'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"count": $count,"videoId": $videoId,"hightUrl": ${hightUrl != null?'${json.encode(hightUrl)}':'null'},"img": ${img != null?'${json.encode(img)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

class Style {

  int isLeadPage;
  String leadImg;
  String leadUrl;

  Style.fromParams({this.isLeadPage, this.leadImg, this.leadUrl});

  Style.fromJson(jsonRes) {
    isLeadPage = jsonRes['isLeadPage'];
    leadImg = jsonRes['leadImg'];
    leadUrl = jsonRes['leadUrl'];
  }

  @override
  String toString() {
    return '{"isLeadPage": $isLeadPage,"leadImg": ${leadImg != null?'${json.encode(leadImg)}':'null'},"leadUrl": ${leadUrl != null?'${json.encode(leadUrl)}':'null'}}';
  }
}

class StageImg {

  int count;
  List<Img> list;

  StageImg.fromParams({this.count, this.list});

  StageImg.fromJson(jsonRes) {
    count = jsonRes['count'];
    list = jsonRes['list'] == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['list']){
      list.add(listItem == null ? null : new Img.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"count": $count,"list": $list}';
  }
}

class Img {

  int imgId;
  String imgUrl;

  Img.fromParams({this.imgId, this.imgUrl});

  Img.fromJson(jsonRes) {
    imgId = jsonRes['imgId'];
    imgUrl = jsonRes['imgUrl'];
  }

  @override
  String toString() {
    return '{"imgId": $imgId,"imgUrl": ${imgUrl != null?'${json.encode(imgUrl)}':'null'}}';
  }
}

class Director {

  int directorId;
  String img;
  String name;
  String nameEn;

  Director.fromParams({this.directorId, this.img, this.name, this.nameEn});

  Director.fromJson(jsonRes) {
    directorId = jsonRes['directorId'];
    img = jsonRes['img'];
    name = jsonRes['name'];
    nameEn = jsonRes['nameEn'];
  }

  @override
  String toString() {
    return '{"directorId": $directorId,"img": ${img != null?'${json.encode(img)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"nameEn": ${nameEn != null?'${json.encode(nameEn)}':'null'}}';
  }
}

class Award {

  int totalNominateAward;
  int totalWinAward;
  List<String> awardList;

  Award.fromParams({this.totalNominateAward, this.totalWinAward, this.awardList});

  Award.fromJson(jsonRes) {
    totalNominateAward = jsonRes['totalNominateAward'];
    totalWinAward = jsonRes['totalWinAward'];
    awardList = jsonRes['awardList'] == null ? null : [];

    for (var awardListItem in awardList == null ? [] : jsonRes['awardList']){
      awardList.add(awardListItem);
    }
  }

  @override
  String toString() {
    return '{"totalNominateAward": $totalNominateAward,"totalWinAward": $totalWinAward,"awardList": $awardList}';
  }
}

class Actor {

  int actorId;
  String img;
  String name;
  String nameEn;
  String roleImg;
  String roleName;

  Actor.fromParams({this.actorId, this.img, this.name, this.nameEn, this.roleImg, this.roleName});

  Actor.fromJson(jsonRes) {
    actorId = jsonRes['actorId'];
    img = jsonRes['img'];
    name = jsonRes['name'];
    nameEn = jsonRes['nameEn'];
    roleImg = jsonRes['roleImg'];
    roleName = jsonRes['roleName'];
  }

  @override
  String toString() {
    return '{"actorId": $actorId,"img": ${img != null?'${json.encode(img)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"nameEn": ${nameEn != null?'${json.encode(nameEn)}':'null'},"roleImg": ${roleImg != null?'${json.encode(roleImg)}':'null'},"roleName": ${roleName != null?'${json.encode(roleName)}':'null'}}';
  }
}

