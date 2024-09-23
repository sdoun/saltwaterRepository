import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<String>? sW1stFilterBottomsheet(
  bool isTetra,
  bool isShift,
) {
  List<String> resultString = [];
  if (isTetra) {
    resultString.add('외향테트라');
  }
  if (isShift) {
    resultString.add('외향석축');
  }
  return resultString;
}

List<String>? sW2ndFilterBottomsheet(
  bool istoilet,
  bool isrestaurant,
  bool isshop,
  bool isbed,
) {
  List<String> amenresult = [];

  if (istoilet) {
    amenresult.add('화장실');
  }

  if (isrestaurant) {
    amenresult.add('식당');
  }

  if (isshop) {
    amenresult.add('매점');
  }

  if (isbed) {
    amenresult.add('숙소');
  }

  return amenresult;
}

List<String>? sW3rdFilterBottomsheet(
  bool carcamp,
  bool cancook,
  bool streetlight,
) {
  List<String> convinresult = [];
  if (carcamp) {
    convinresult.add('차박가능');
  }

  if (cancook) {
    convinresult.add('취사가능');
  }

  if (streetlight) {
    convinresult.add('야간가로등');
  }

  return convinresult;
}

List<String> carrotChatParticipant(
  String currentUser,
  String sellerId,
) {
  List<String> result = [];
  result.add(currentUser);
  result.add(sellerId);

  return result;
}

List<dynamic>? fcsSkyForTommorow(
  List<dynamic>? fcstList,
  String basedate,
  int datePlus,
) {
  // Parse the base date
  DateTime baseDateTime = DateTime.parse(basedate);
  // Calculate the target date
  DateTime targetDate = baseDateTime.add(Duration(days: datePlus));
  // Format the target date back to "YYYYMMDD"
  String targetDateString =
      targetDate.toIso8601String().split('T').first.replaceAll('-', '');
  if (fcstList == null) {
    print('fcstList is null');
    return null;
  } else {
    for (var item in fcstList!) {
      if (item["fcstDate"] == targetDateString && item["category"] == 'SKY') {
        print('fcstValue Detected');
        print('$item["fcstValue"]');
        return [item["fcstValue"]];
      }
    }
  }
  return null;
}

String datetimeToDateString(String datetime) {
  DateTime dateTime = DateTime.parse(datetime);

  // 문자열 길이를 10으로 만들기
  String formattedDateTime = dateTime.toString().substring(0, 10);

  // 문자열에서 '-' 제거하기
  formattedDateTime = formattedDateTime.replaceAll('-', '');
  if (formattedDateTime.length == 3) {
    formattedDateTime = '0' + formattedDateTime;
  }

  // 문자열을 int 값으로 변환하여 반환
  return formattedDateTime;
}

List<String> datetimeToDateCopyFcst(String datetime) {
  List<String> result = [];
  DateTime dateTime = DateTime.parse(datetime);
  print(dateTime.day);
  if (dateTime.hour < 2) {
    dateTime = dateTime.subtract(Duration(days: 1));
    print(dateTime.day);
  }

  if (dateTime.hour >= 23) {
    result.add('2300');
  } else if (dateTime.hour >= 20) {
    result.add('2000');
  } else if (dateTime.hour >= 17) {
    result.add('1700');
  } else if (dateTime.hour >= 14) {
    result.add('1400');
  } else if (dateTime.hour >= 11) {
    result.add('1100');
  } else if (dateTime.hour >= 8) {
    result.add('0800');
  } else if (dateTime.hour >= 5) {
    result.add('0500');
  } else if (dateTime.hour >= 2) {
    result.add('0200');
  } else {
    result.add('2300');
  }
  print(result[0]);

  // 문자열 길이를 10으로 만들기
  String formattedDateTime = dateTime.toString().substring(0, 10);

  // 문자열에서 '-' 제거하기
  formattedDateTime = formattedDateTime.replaceAll('-', '');
  print(formattedDateTime);
  // 문자열을 결과값에 추가
  result.add(formattedDateTime);
  print(result[1]);
  return result;
}

int datetimeToDateCopy(String datetime) {
  DateTime dateTime = DateTime.parse(datetime);

  // 문자열 길이를 10으로 만들기
  String formattedDateTime = dateTime.toString().substring(0, 10);

  // 문자열에서 '-' 제거하기
  formattedDateTime = formattedDateTime.replaceAll('-', '');
  print(formattedDateTime);
  // 문자열을 int 값으로 변환하여 반환
  return int.parse(formattedDateTime);
}

int datetimeToTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  int hour = dateTime.hour;

  hour = hour * 100;

  return hour;
}

String? datetimeToTimeString(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  if (minute <= 40) {
    hour - 1;
  }
  hour = hour * 100;
  String hourString = hour.toString();
  if (hourString.length == 3) {
    hourString = '0' + hourString;
  }
  if (hourString.length == 1) {
    hourString = '0000';
  }
  print(hourString);

  return hourString;
}

String vecToString(String? vecString) {
  final windDirectionList = [
    '북',
    '북북동',
    '북동',
    '동북동',
    '동',
    '동남동',
    '남동',
    '남남동',
    '남',
    '남남서',
    '남서',
    '서남서',
    '서',
    '서북서',
    '북서',
    '북북서',
    '북',
  ];

  if (vecString == null) {
    print('vec is null!');
    return '서버 응답없음';
  }
  double vec = double.parse(vecString);
  vec = (vec + 22.5 * 0.5) / 22.5;
  int result = vec.toInt();

  String resultString = windDirectionList[result];

  return resultString;
}

List<dynamic>? fcstListForCategory(
  List<dynamic>? fcstList,
  String basedate,
  int datePlus,
  String category,
) {
  // Parse the base date
  DateTime baseDateTime = DateTime.parse(basedate);
  // Calculate the target date
  DateTime targetDate = baseDateTime.add(Duration(days: datePlus));
  // Format the target date back to "YYYYMMDD"
  String targetDateString =
      targetDate.toIso8601String().split('T').first.replaceAll('-', '');
  if (fcstList == null) {
    print('fcstList is null');
    return null;
  } else {
    for (var item in fcstList!) {
      if (item["fcstDate"] == targetDateString &&
          item["category"] == category) {
        print('$item["fcstValue"]');
        return [item["fcstValue"]];
      }
    }
  }
  return null;
}

String wrttempFromJson(dynamic jsonItem) {
  if (jsonItem != null) {
    if (jsonItem.containsKey('wtr_tmp')) {
      return jsonItem['wtr_tmp'];
    } else {
      return ('wtr_tmp 키가 없거나 double 타입이 아닙니다.');
    }
  }
  return ('서버 응답없음');
}

List<String>? ocean1stFilterBottomsheet(
  bool isOcean,
  bool isRock,
) {
  List<String> resultString = [];
  if (isOcean) {
    resultString.add('해변');
  }
  if (isRock) {
    resultString.add('갯바위');
  }

  return resultString;
}

dynamic findItemFromStacdeLay1(
  List<dynamic>? wtrTmpJsonList,
  String staCode,
) {
  for (var item in wtrTmpJsonList!) {
    if (item["sta_cde"] == staCode) {
      return item;
    }
  }
  return null;
}

List<String>? ocean2ndFilterBottomsheet(
  bool istoilet,
  bool isrestaurant,
  bool isshop,
  bool isbed,
  bool fishingShop,
) {
  List<String> amenresult = [];

  if (istoilet) {
    amenresult.add('화장실');
  }

  if (isrestaurant) {
    amenresult.add('식당');
  }

  if (isshop) {
    amenresult.add('매점');
  }

  if (isbed) {
    amenresult.add('숙소');
  }
  if (fishingShop) {
    amenresult.add('낚시방');
  }

  return amenresult;
}

dynamic findItemFromStacdeLay2(
  List<dynamic>? wtrTmpJsonList,
  String staCode,
) {
  if (wtrTmpJsonList == null) {
    print('JsonList is null');
    return null;
  }
  for (var item in wtrTmpJsonList!) {
    print(item['obs_lay']);
    if (item['sta_cde'] == staCode && item['obs_lay'].toString() == '2') {
      print('item found success');
      return item;
    }
  }
  print('Cannot Find Item');
  return null;
}

dynamic findItemFromStacdeLay3(
  List<dynamic> wtrTmpJsonList,
  String staCode,
) {
  for (var item in wtrTmpJsonList!) {
    if (item['sta_cde'] == staCode) {
      if (item['obs_lay'] == '3') {
        return item;
      }
    }
  }
  return null;
}

List<String>? park1stFilterBottomsheet(
  bool notFree,
  bool isFree,
  bool nature,
  bool unnature,
) {
  List<String> resultString = [];
  if (notFree) {
    if (isFree) {
    } else {
      resultString.add('유료');
    }
  } else if (isFree) {
    if (notFree) {
    } else {
      resultString.add('무료');
    }
  }
  if (nature) {
    if (unnature) {
    } else {
      resultString.add('자연식');
    }
  } else if (unnature) {
    if (nature) {
    } else {
      resultString.add('입어식');
    }
  }

  return resultString;
}

List<String>? pension1stFilterBottomsheet(
  bool isLodge,
  bool isPension,
) {
  List<String> resultString = [];
  if (isLodge) {
    resultString.add('민박형');
  }
  if (isPension) {
    resultString.add('펜션형');
  }

  return resultString;
}

List<String>? pension2ndFilterBottomsheet(
  bool arroundFishing,
  bool isrestaurant,
  bool isshop,
  bool fishingShop,
) {
  List<String> amenresult = [];

  if (arroundFishing) {
    amenresult.add('주변낚시터');
  }

  if (isrestaurant) {
    amenresult.add('식당');
  }

  if (isshop) {
    amenresult.add('매점');
  }

  if (fishingShop) {
    amenresult.add('낚시방');
  }

  return amenresult;
}

int hourForFcst(int datetimeHour) {
  if (datetimeHour >= 2300) {
    return 2300;
  } else if (datetimeHour >= 2000) {
    return 2000;
  } else if (datetimeHour >= 1700) {
    return 1700;
  } else if (datetimeHour >= 1400) {
    return 1400;
  } else if (datetimeHour >= 1100) {
    return 1100;
  } else if (datetimeHour >= 800) {
    return 800;
  } else if (datetimeHour >= 500) {
    return 500;
  } else if (datetimeHour >= 200) {
    return 200;
  } else {
    return 2300;
  }
}

List<String>? pension3rdFilterBottomsheet(
  bool meal,
  bool ship,
  bool ocean,
  bool lent,
) {
  List<String> amenresult = [];

  if (meal) {
    amenresult.add('식사제공');
  }

  if (ship) {
    amenresult.add('낚시배및좌대 이용가능');
  }

  if (ocean) {
    amenresult.add('해변물놀이가능');
  }

  if (lent) {
    amenresult.add('낚시대 대여');
  }

  return amenresult;
}

List<String> skyToImageLink(String? fcstSkyString) {
  List<String> resultImage = [];

  int? fcstSky;
  if (fcstSkyString != null) {
    fcstSky = int.tryParse(fcstSkyString);
    print('$fcstSkyString');
    print('$fcstSky');

    if (fcstSky == null) {
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C2.png?alt=media&token=2615f6d1-aa8f-41b0-a37c-530abd25a581');
      return resultImage;
    }

    if (0 <= fcstSky && fcstSky <= 5) {
      print('success fcstSky : $fcstSky');
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C2.png?alt=media&token=2615f6d1-aa8f-41b0-a37c-530abd25a581');
    } else if (6 <= fcstSky && fcstSky <= 8) {
      print('success fcstSky : $fcstSky');
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EA%B3%A0%ED%9D%90%EB%A6%BC.png?alt=media&token=613a6068-5526-49c6-a497-1113bcbda715');
    } else if (9 <= fcstSky && fcstSky <= 10) {
      print('success fcstSky : $fcstSky');
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%ED%9D%90%EB%A6%BC.png?alt=media&token=6cde332b-5672-4ae7-8b04-4fcd7558a51a');
    }
  } else {
    print('fcstSky is null');
  }

  return resultImage;
}

List<dynamic>? fcsTmpForTommorow(
  List<dynamic>? fcstList,
  String basedate,
  int datePlus,
) {
  int tomorrow = int.parse(basedate) + datePlus;

  for (var item in fcstList!) {
    if (item["fcstDate"] == tomorrow.toString() && item["category"] == 'TMP') {
      return [item["fcstValue"]];
    }
  }
  return null;
}

List<String>? park2ndFilterBottomsheet(
  bool istoilet,
  bool isrestaurant,
  bool isshop,
  bool fishingShop,
) {
  List<String> amenresult = [];

  if (istoilet) {
    amenresult.add('화장실');
  }

  if (isrestaurant) {
    amenresult.add('식당');
  }

  if (isshop) {
    amenresult.add('매점');
  }

  if (fishingShop) {
    amenresult.add('낚시방');
  }

  return amenresult;
}

List<String>? park3rdFilterBottomsheet(
  bool lent,
  bool toolShop,
) {
  List<String> convinresult = [];
  if (lent) {
    convinresult.add('낚시장비 대여');
  }

  if (toolShop) {
    convinresult.add('낚시장비 판매');
  }

  return convinresult;
}

String midFcstToImage(String? fcstSkyString) {
  if (fcstSkyString == null) {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C2.png?alt=media&token=2615f6d1-aa8f-41b0-a37c-530abd25a581';
  }

  if (fcstSkyString == '맑음') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C2.png?alt=media&token=2615f6d1-aa8f-41b0-a37c-530abd25a581';
  } else if (fcstSkyString == '구름많음') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EA%B3%A0%ED%9D%90%EB%A6%BC.png?alt=media&token=613a6068-5526-49c6-a497-1113bcbda715';
  } else if (fcstSkyString == '흐림') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%ED%9D%90%EB%A6%BC.png?alt=media&token=6cde332b-5672-4ae7-8b04-4fcd7558a51a';
  } else if (fcstSkyString == '흐리고 비') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%B9%84.png?alt=media&token=b37e7a43-8d96-4592-904b-566249060f92';
  } else {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C2.png?alt=media&token=2615f6d1-aa8f-41b0-a37c-530abd25a581';
  }
}

String dateTimeToHourMinute(String datetime) {
  DateTime _currentDateTime = DateTime.parse(datetime);
  int hour = _currentDateTime.hour;
  int minute = _currentDateTime.minute;

  return '$hour:$minute';
}

List<String>? stand1stFilterBottomsheet(
  bool isStand,
  bool isPension,
  bool onDay,
  bool overnight,
) {
  List<String> resultString = [];
  if (isStand) {
    resultString.add('좌대');
  }
  if (isPension) {
    resultString.add('해상펜션');
  }
  if (onDay) {
    resultString.add('당일낚시');
  }
  if (overnight) {
    resultString.add('숙박가능');
  }

  return resultString;
}

List<String>? stand2ndFilterBottomsheet(
  bool isbed,
  bool istoilet,
  bool cancook,
  bool barbeque,
) {
  List<String> amenresult = [];

  if (isbed) {
    amenresult.add('침구류');
  }

  if (cancook) {
    amenresult.add('취사장비');
  }

  if (istoilet) {
    amenresult.add('화장실');
  }

  if (barbeque) {
    amenresult.add('바베큐');
  }

  return amenresult;
}

int indexMinus1(int itemIndex) {
  return itemIndex - 1;
}

bool isNullInListString(List<String> list) {
  List<String> myList = list;
  bool hasEmptyValues =
      myList.any((element) => element == null || element.isEmpty);

  return hasEmptyValues;
}

String vecStringToImage(String vecString) {
  if (vecString == null) {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FWSW(%EC%84%9C%EB%82%A8%EC%84%9C).jpg?alt=media&token=316b7100-77d5-43f7-a851-4bdbca2a9805';
  }
  if (vecString == '동') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FE(%EB%8F%99).jpg?alt=media&token=70d774a6-73ef-43f5-a5ba-0e549991babe';
  }
  if (vecString == '동북동') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FENE(%EB%8F%99%EB%B6%81%EB%8F%99).jpg?alt=media&token=60b5671b-8545-447f-8f53-9c5ddcc8d5b4';
  }
  if (vecString == '동남동') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FESE(%EB%8F%99%EB%82%A8%EB%8F%99).jpg?alt=media&token=6769b017-2eff-498e-9652-9e4d79c19e65';
  }
  if (vecString == '북') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FN(%EB%B6%81).jpg?alt=media&token=c1865cbd-d5e2-4f22-9a73-47f0800f13de';
  }
  if (vecString == '북동') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FNE(%EB%B6%81%EB%8F%99).jpg?alt=media&token=4ddfb640-878d-4a6d-8321-7ef6681ea4d2';
  }
  if (vecString == '북서') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FNE(%EB%B6%81%EC%84%9C).jpg?alt=media&token=7572cfb7-9ffc-420e-a750-ac49f4f82ab2';
  }
  if (vecString == '북북동') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FNNE(%EB%B6%81%EB%B6%81%EB%8F%99).jpg?alt=media&token=d6145f9b-d182-4a37-a07e-7d02554b0855';
  }
  if (vecString == '븍븍서') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FNNW(%EB%B6%81%EB%B6%81%EC%84%9C).jpg?alt=media&token=54c6a279-2de9-45c0-a593-84866ca0d8ae';
  }
  if (vecString == '남') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FS(%EB%82%A8).jpg?alt=media&token=06df126b-f8ed-4f87-b6cb-4556360721a8';
  }
  if (vecString == '남동') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FSE(%EB%82%A8%EB%8F%99).jpg?alt=media&token=9ee8ea85-ff95-4a42-af82-f5589a3309ed';
  }
  if (vecString == '남남동') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FSSE(%EB%82%A8%EB%82%A8%EB%8F%99).jpg?alt=media&token=44259360-74c1-499b-9a39-aa460760a4a5';
  }
  if (vecString == '남서') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FSW(%EB%82%A8%EC%84%9C).jpg?alt=media&token=782334e2-4be8-4ab0-b872-925af6db6c45';
  }
  if (vecString == '남남서') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FSSW(%EB%82%A8%EB%82%A8%EC%84%9C).jpg?alt=media&token=49640f1d-e5ff-421b-8133-1d158179c50c';
  }
  if (vecString == '서') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FW(%EC%84%9C).jpg?alt=media&token=c04cbd96-7bd6-4088-a53b-0ea47af04bb4';
  }
  if (vecString == '서북서') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FWNW(%EC%84%9C%EB%B6%81%EC%84%9C).jpg?alt=media&token=4ccaa5e1-fff3-427b-94c3-0e481916598c';
  }
  if (vecString == '서남서') {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FWSW(%EC%84%9C%EB%82%A8%EC%84%9C).jpg?alt=media&token=316b7100-77d5-43f7-a851-4bdbca2a9805';
  } else {
    return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%B0%94%EB%9E%8C%EB%B0%A9%ED%96%A5%2FWSW(%EC%84%9C%EB%82%A8%EC%84%9C).jpg?alt=media&token=316b7100-77d5-43f7-a851-4bdbca2a9805';
  }
}

TidFcstStruct? tidStructFromJson(dynamic tidFcst) {
  String tidDateTime = tidFcst["tph_time"];
  String tidCode = tidFcst["hl_code"];
  String tidLevel = tidFcst["tph_level"];
  DateTime parsedDateTime = DateTime.parse(tidDateTime);
  int tidTime =
      parsedDateTime.hour * 100 + parsedDateTime.minute + parsedDateTime.second;

  String HourString = parsedDateTime.hour.toString();
  String minuteString = parsedDateTime.minute.toString();
  String timeString = '$HourString 시 $minuteString 분';

  TidFcstStruct tidStruct = TidFcstStruct();
  tidStruct.time = tidTime;
  tidStruct.tidLevel = tidLevel;
  tidStruct.timeString = timeString;

  return tidStruct;
}

String? midFcstCodeTrans(String midFcstCode) {
  String result = '';
  result = midFcstCode.substring(0, 4) + '0000';
  return result;
}

List<DocumentReference> chatParticipants(
  DocumentReference currentUser,
  DocumentReference seller,
) {
  List<DocumentReference> listOfUser = [currentUser] + [seller];

  return listOfUser;
}

List<String> skyToImageLinkCopy(String? fcstSkyString) {
  List<String> resultImage = [];

  int? fcstSky;
  if (fcstSkyString != null) {
    fcstSky = int.tryParse(fcstSkyString);
    print('$fcstSkyString');
    print('$fcstSky');

    if (fcstSky == null) {
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C2.png?alt=media&token=2615f6d1-aa8f-41b0-a37c-530abd25a581');
      return resultImage;
    }
    print(fcstSky);

    if (fcstSky == 1) {
      print('success fcstSky : $fcstSky');
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C2.png?alt=media&token=2615f6d1-aa8f-41b0-a37c-530abd25a581');
    } else if (fcstSky == 3) {
      print('success fcstSky : $fcstSky');
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EA%B3%A0%ED%9D%90%EB%A6%BC.png?alt=media&token=613a6068-5526-49c6-a497-1113bcbda715');
    } else if (fcstSky == 4) {
      print('success fcstSky : $fcstSky');
      resultImage.add(
          'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%ED%9D%90%EB%A6%BC.png?alt=media&token=6cde332b-5672-4ae7-8b04-4fcd7558a51a');
    }
  } else {
    print('fcstSky is null');
  }

  return resultImage;
}

String? packageTypeToString(
  List<String>? stateFromFilter,
  String fishing,
  String experience,
) {
  String result = '';
  if (stateFromFilter == null) {
    return '종류';
  }
  if (stateFromFilter!.contains(fishing)) {
    if (stateFromFilter!.contains(experience)) {
      result = result + fishing + ', ' + experience;
    } else {
      result = result + fishing;
    }
  } else if (stateFromFilter!.contains(experience)) {
    result = result + experience;
  } else {
    return '';
  }
  return result;
}

List<String>? package3rdFilterSum(
  List<String>? fishing,
  List<String>? seaEx,
) {
  List<String>? result = [];
  result = (fishing ?? []) + (seaEx ?? []);
  return result;
}

List<TidFcstStruct>? tidStructListFromJson(List<dynamic>? tidFcst) {
  List<TidFcstStruct> tidStructList = [];

  if (tidFcst != null) {
    for (var tid in tidFcst) {
      String tidDateTime = tid["tph_time"];
      String tidCode = tid["hl_code"];
      String tidLevel = tid["tph_level"];
      DateTime parsedDateTime = DateTime.parse(tidDateTime);
      int tidTime = parsedDateTime.hour * 100 +
          parsedDateTime.minute +
          parsedDateTime.second;

      String HourString = parsedDateTime.hour.toString();
      String minuteString = parsedDateTime.minute.toString();
      String timeString = '$HourString 시 $minuteString 분';

      TidFcstStruct tidStruct = TidFcstStruct();
      tidStruct.time = tidTime;
      tidStruct.tidType = tidCode;
      tidStruct.tidLevel = tidLevel;
      tidStruct.timeString = timeString;
      tidStructList.add(tidStruct);
    }
  } else {
    TidFcstStruct tidStruct = TidFcstStruct();
    tidStruct.time = 0;
    tidStruct.tidType = '서버 응답없음';
    tidStruct.tidLevel = '서버 응답없음';
    tidStruct.timeString = '서버 응답없음';
    tidStructList.add(tidStruct);
  }
  return tidStructList;
}

List<String>? newCustomFunction(
  bool fishingSelect,
  bool exSelect,
) {
  List<String>? result = [];

  if (fishingSelect) {
    result.add('낚시');
  }
  if (exSelect) {
    result.add('바다체험');
  }
  return result;
}

List<String>? fishingBusFishes(
  List<String>? popular,
  List<String>? fish1,
  List<String>? fish2,
  List<String>? fish3,
) {
  var sum = (popular ?? []) + (fish1 ?? []) + (fish2 ?? []) + (fish3 ?? []);
  return sum;
}

int dateTimeForNcst(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  int hour = dateTime.hour;
  if (dateTime.minute < 40) {
    if (dateTime.hour == 0) {
      hour = 23;
    } else {
      hour = hour - 1;
    }
  } else {}

  hour = hour * 100;

  return hour;
}

int dateForNcst(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  int date = dateTime.day;
  if (dateTime.minute < 40 && dateTime.hour == 0) {
    date = date - 1;
  } else {}

  return date;
}

String? tidDateButton(
  bool increse,
  bool decrease,
  String tidDateTime,
) {
  DateTime tidDate = DateTime.parse(tidDateTime);
  if (increse) {
    tidDate = tidDate.add(Duration(days: 1));
  } else if (decrease) {
    tidDate = tidDate.subtract(Duration(days: 1));
  } else {
    tidDate = DateTime.now();
  }
  print(tidDate);
  String formattedDateTime = tidDate.toString().substring(0, 10);

  // 문자열에서 '-' 제거하기
  formattedDateTime = formattedDateTime.replaceAll('-', '');
  print(formattedDateTime);

  return formattedDateTime;
}

String? formatTidDate(String tidDate) {
  if (tidDate.length != 8) {
    return '잘못된 날짜 형식';
  }

  try {
    // 문자열을 DateTime 객체로 파싱
    DateTime date = DateTime.parse(tidDate);

    // 월과 일을 추출
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    // 포맷팅된 문자열 반환
    return '$month월 $day일';
  } catch (e) {
    return '날짜 변환 오류';
  }
}
