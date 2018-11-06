import 'dart:convert' show json;

class ActorDetail {
  Object community;
  Object hotMovie;
  Object quizGame;
  int birthDay;
  int birthMonth;
  int birthYear;
  int deathDay;
  int deathMonth;
  int deathYear;
  int movieCount;
  int totalNominateAward;
  int totalWinAward;
  String address;
  String bigImage;
  String content;
  String height;
  String image;
  String nameCn;
  String nameEn;
  String profession;
  String rating;
  String ratingFinal;
  String url;
  List<AwardInfo> awards;
  List<Exprience> expriences;
  List<Festival> festivals;
  List<Img> images;
  List<Honor> otherHonor;
  List<Person> relationPersons;
  Style style;

  ActorDetail.fromParams(
      {this.community,
      this.hotMovie,
      this.quizGame,
      this.birthDay,
      this.birthMonth,
      this.birthYear,
      this.deathDay,
      this.deathMonth,
      this.deathYear,
      this.movieCount,
      this.totalNominateAward,
      this.totalWinAward,
      this.address,
      this.bigImage,
      this.content,
      this.height,
      this.image,
      this.nameCn,
      this.nameEn,
      this.profession,
      this.rating,
      this.ratingFinal,
      this.url,
      this.awards,
      this.expriences,
      this.festivals,
      this.images,
      this.otherHonor,
      this.relationPersons,
      this.style});

  factory ActorDetail(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ActorDetail.fromJson(json.decode(jsonStr))
          : new ActorDetail.fromJson(jsonStr);

  ActorDetail.fromJson(jsonRes) {
    community = jsonRes['community'];
    hotMovie = jsonRes['hotMovie'];
    quizGame = jsonRes['quizGame'];
    birthDay = jsonRes['birthDay'];
    birthMonth = jsonRes['birthMonth'];
    birthYear = jsonRes['birthYear'];
    deathDay = jsonRes['deathDay'];
    deathMonth = jsonRes['deathMonth'];
    deathYear = jsonRes['deathYear'];
    movieCount = jsonRes['movieCount'];
    totalNominateAward = jsonRes['totalNominateAward'];
    totalWinAward = jsonRes['totalWinAward'];
    address = jsonRes['address'];
    bigImage = jsonRes['bigImage'];
    content = jsonRes['content'];
    height = jsonRes['height'];
    image = jsonRes['image'];
    nameCn = jsonRes['nameCn'];
    nameEn = jsonRes['nameEn'];
    profession = jsonRes['profession'];
    rating = jsonRes['rating'];
    ratingFinal = jsonRes['ratingFinal'];
    url = jsonRes['url'];
    awards = jsonRes['awards'] == null ? null : [];

    for (var awardsItem in awards == null ? [] : jsonRes['awards']) {
      awards
          .add(awardsItem == null ? null : new AwardInfo.fromJson(awardsItem));
    }

    expriences = jsonRes['expriences'] == null ? null : [];

    for (var expriencesItem
        in expriences == null ? [] : jsonRes['expriences']) {
      expriences.add(expriencesItem == null
          ? null
          : new Exprience.fromJson(expriencesItem));
    }

    festivals = jsonRes['festivals'] == null ? null : [];

    for (var festivalsItem in festivals == null ? [] : jsonRes['festivals']) {
      festivals.add(
          festivalsItem == null ? null : new Festival.fromJson(festivalsItem));
    }

    images = jsonRes['images'] == null ? null : [];

    for (var imagesItem in images == null ? [] : jsonRes['images']) {
      images.add(imagesItem == null ? null : new Img.fromJson(imagesItem));
    }

    otherHonor = jsonRes['otherHonor'] == null ? null : [];

    for (var otherHonorItem
        in otherHonor == null ? [] : jsonRes['otherHonor']) {
      otherHonor.add(
          otherHonorItem == null ? null : new Honor.fromJson(otherHonorItem));
    }

    relationPersons = jsonRes['relationPersons'] == null ? null : [];

    for (var relationPersonsItem
        in relationPersons == null ? [] : jsonRes['relationPersons']) {
      relationPersons.add(relationPersonsItem == null
          ? null
          : new Person.fromJson(relationPersonsItem));
    }

    style =
        jsonRes['style'] == null ? null : new Style.fromJson(jsonRes['style']);
  }

  @override
  String toString() {
    return '{"community": $community,"hotMovie": $hotMovie,"quizGame": $quizGame,"birthDay": $birthDay,"birthMonth": $birthMonth,"birthYear": $birthYear,"deathDay": $deathDay,"deathMonth": $deathMonth,"deathYear": $deathYear,"movieCount": $movieCount,"totalNominateAward": $totalNominateAward,"totalWinAward": $totalWinAward,"address": ${address != null ? '${json.encode(address)}' : 'null'},"bigImage": ${bigImage != null ? '${json.encode(bigImage)}' : 'null'},"content": ${content != null ? '${json.encode(content)}' : 'null'},"height": ${height != null ? '${json.encode(height)}' : 'null'},"image": ${image != null ? '${json.encode(image)}' : 'null'},"nameCn": ${nameCn != null ? '${json.encode(nameCn)}' : 'null'},"nameEn": ${nameEn != null ? '${json.encode(nameEn)}' : 'null'},"profession": ${profession != null ? '${json.encode(profession)}' : 'null'},"rating": ${rating != null ? '${json.encode(rating)}' : 'null'},"ratingFinal": ${ratingFinal != null ? '${json.encode(ratingFinal)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'},"awards": $awards,"expriences": $expriences,"festivals": $festivals,"images": $images,"otherHonor": $otherHonor,"relationPersons": $relationPersons,"style": $style}';
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
    return '{"isLeadPage": $isLeadPage,"leadImg": ${leadImg != null ? '${json.encode(leadImg)}' : 'null'},"leadUrl": ${leadUrl != null ? '${json.encode(leadUrl)}' : 'null'}}';
  }
}

class Person {
  int rPersonId;
  String rCover;
  String rNameCn;
  String rNameEn;
  String relation;

  Person.fromParams(
      {this.rPersonId, this.rCover, this.rNameCn, this.rNameEn, this.relation});

  Person.fromJson(jsonRes) {
    rPersonId = jsonRes['rPersonId'];
    rCover = jsonRes['rCover'];
    rNameCn = jsonRes['rNameCn'];
    rNameEn = jsonRes['rNameEn'];
    relation = jsonRes['relation'];
  }

  @override
  String toString() {
    return '{"rPersonId": $rPersonId,"rCover": ${rCover != null ? '${json.encode(rCover)}' : 'null'},"rNameCn": ${rNameCn != null ? '${json.encode(rNameCn)}' : 'null'},"rNameEn": ${rNameEn != null ? '${json.encode(rNameEn)}' : 'null'},"relation": ${relation != null ? '${json.encode(relation)}' : 'null'}}';
  }
}

class Honor {
  String honor;

  Honor.fromParams({this.honor});

  Honor.fromJson(jsonRes) {
    honor = jsonRes['honor'];
  }

  @override
  String toString() {
    return '{"honor": ${honor != null ? '${json.encode(honor)}' : 'null'}}';
  }
}

class Img {
  int imageId;
  int type;
  String image;

  Img.fromParams({this.imageId, this.type, this.image});

  Img.fromJson(jsonRes) {
    imageId = jsonRes['imageId'];
    type = jsonRes['type'];
    image = jsonRes['image'];
  }

  @override
  String toString() {
    return '{"imageId": ${image != null ? '${json.encode(image)}' : 'null'}Id,"type": $type,"image": ${image != null ? '${json.encode(image)}' : 'null'}}';
  }
}

class Festival {
  int festivalId;
  String img;
  String nameCn;
  String nameEn;
  String shortName;

  Festival.fromParams(
      {this.festivalId, this.img, this.nameCn, this.nameEn, this.shortName});

  Festival.fromJson(jsonRes) {
    festivalId = jsonRes['festivalId'];
    img = jsonRes['img'];
    nameCn = jsonRes['nameCn'];
    nameEn = jsonRes['nameEn'];
    shortName = jsonRes['shortName'];
  }

  @override
  String toString() {
    return '{"festivalId": $festivalId,"img": ${img != null ? '${json.encode(img)}' : 'null'},"nameCn": ${nameCn != null ? '${json.encode(nameCn)}' : 'null'},"nameEn": ${nameEn != null ? '${json.encode(nameEn)}' : 'null'},"shortName": ${shortName != null ? '${json.encode(shortName)}' : 'null'}}';
  }
}

class Exprience {
  int year;
  String content;
  String img;
  String title;

  Exprience.fromParams({this.year, this.content, this.img, this.title});

  Exprience.fromJson(jsonRes) {
    year = jsonRes['year'];
    content = jsonRes['content'];
    img = jsonRes['img'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"year": $year,"content": ${content != null ? '${json.encode(content)}' : 'null'},"img": ${img != null ? '${json.encode(img)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}

class AwardInfo {
  int festivalId;
  int nominateCount;
  int winCount;
  List<Award> nominateAwards;

  AwardInfo.fromParams(
      {this.festivalId,
      this.nominateCount,
      this.winCount,
      this.nominateAwards});

  AwardInfo.fromJson(jsonRes) {
    festivalId = jsonRes['festivalId'];
    nominateCount = jsonRes['nominateCount'];
    winCount = jsonRes['winCount'];
    nominateAwards = jsonRes['nominateAwards'] == null ? null : [];

    for (var nominateAwardsItem
        in nominateAwards == null ? [] : jsonRes['nominateAwards']) {
      nominateAwards.add(nominateAwardsItem == null
          ? null
          : new Award.fromJson(nominateAwardsItem));
    }
  }

  @override
  String toString() {
    return '{"festivalId": $festivalId,"nominateCount": $nominateCount,"winCount": $winCount,"nominateAwards": $nominateAwards}';
  }
}

class Award {
  int movieId;
  int sequenceNumber;
  String awardName;
  String festivalEventYear;
  String image;
  String movieTitle;
  String movieTitleEn;
  String movieYear;
  String roleName;

  Award.fromParams(
      {this.movieId,
      this.sequenceNumber,
      this.awardName,
      this.festivalEventYear,
      this.image,
      this.movieTitle,
      this.movieTitleEn,
      this.movieYear,
      this.roleName});

  Award.fromJson(jsonRes) {
    movieId = jsonRes['movieId'];
    sequenceNumber = jsonRes['sequenceNumber'];
    awardName = jsonRes['awardName'];
    festivalEventYear = jsonRes['festivalEventYear'];
    image = jsonRes['image'];
    movieTitle = jsonRes['movieTitle'];
    movieTitleEn = jsonRes['movieTitleEn'];
    movieYear = jsonRes['movieYear'];
    roleName = jsonRes['roleName'];
  }

  @override
  String toString() {
    return '{"movieId": $movieId,"sequenceNumber": $sequenceNumber,"awardName": ${awardName != null ? '${json.encode(awardName)}' : 'null'},"festivalEventYear": ${festivalEventYear != null ? '${json.encode(festivalEventYear)}' : 'null'},"image": ${image != null ? '${json.encode(image)}' : 'null'},"movieTitle": ${movieTitle != null ? '${json.encode(movieTitle)}' : 'null'},"movieTitleEn": ${movieTitleEn != null ? '${json.encode(movieTitleEn)}' : 'null'},"movieYear": ${movieYear != null ? '${json.encode(movieYear)}' : 'null'},"roleName": ${roleName != null ? '${json.encode(roleName)}' : 'null'}}';
  }
}
