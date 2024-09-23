import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class RealtimeWeatherAPICall {
  static Future<ApiCallResponse> call({
    String? serviceKey =
        'VcgMtzNuLXUcyCr6fVCfGeiT2b0iwexetcFE43%2FbFeTrUtz7afkQ3Y%2FG3WUyQaR4SBj6kQ96RY3kpvVz3sI%2Bfg%3D%3D',
    int? numOfRows,
    int? pageNo,
    String? dataType = 'JSON',
    int? baseDate,
    String? baseTime = '',
    int? nx,
    int? ny,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'realtimeWeatherAPI',
      apiUrl:
          'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=VcgMtzNuLXUcyCr6fVCfGeiT2b0iwexetcFE43%2FbFeTrUtz7afkQ3Y%2FG3WUyQaR4SBj6kQ96RY3kpvVz3sI%2Bfg%3D%3D',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'serviceKey': serviceKey,
        'numOfRows': numOfRows,
        'pageNo': pageNo,
        'dataType': dataType,
        'base_date': baseDate,
        'base_time': baseTime,
        'nx': nx,
        'ny': ny,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? dataList(dynamic response) => (getJsonField(
        response,
        r'''$.response.body.items.item[:].obsrValue''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? itemList(dynamic response) => getJsonField(
        response,
        r'''$.response.body.items''',
        true,
      ) as List?;
}

class RealtimeWtrTmpCall {
  static Future<ApiCallResponse> call({
    String? staCde = '',
    String? key = 'qPwOeIrU-2403-NDHXBJ-0759',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'realtimeWtrTmp',
      apiUrl: 'https://www.nifs.go.kr/OpenAPI_json?id=risaList',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'key': key,
        'sta_cde': staCde,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? jsonItems(dynamic response) => getJsonField(
        response,
        r'''$.body.item''',
        true,
      ) as List?;
}

class FcstWeatherApiCall {
  static Future<ApiCallResponse> call({
    int? numOfRows = 8,
    int? pageNo,
    String? dataType = 'JSON',
    String? baseDate = '',
    String? baseTime = '',
    int? nx,
    int? ny,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FcstWeatherApi',
      apiUrl:
          'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=VcgMtzNuLXUcyCr6fVCfGeiT2b0iwexetcFE43%2FbFeTrUtz7afkQ3Y%2FG3WUyQaR4SBj6kQ96RY3kpvVz3sI%2Bfg%3D%3D',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'numOfRows': numOfRows,
        'pageNo': pageNo,
        'nx': nx,
        'ny': ny,
        'dataType': dataType,
        'base_date': baseDate,
        'base_time': baseTime,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? valueList(dynamic response) => (getJsonField(
        response,
        r'''$.response.body.items.item[:].fcstValue''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? itemList(dynamic response) => getJsonField(
        response,
        r'''$.response.body.items.item''',
        true,
      ) as List?;
}

class TidalFcstCall {
  static Future<ApiCallResponse> call({
    String? date = '',
    String? dataType = 'tideObsPreTab',
    String? obsCode = '',
    String? resultType = 'json',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'tidalFcst',
      apiUrl:
          'http://www.khoa.go.kr/api/oceangrid/tideObsPreTab/search.do?ServiceKey=9hVeUO6Kty0cB2nhJfR62Q==',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'Date': date,
        'ObsCode': obsCode,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? dataList(dynamic response) => getJsonField(
        response,
        r'''$.result.data''',
        true,
      ) as List?;
  static List<String>? hlCodeList(dynamic response) => (getJsonField(
        response,
        r'''$.result.data[:].hl_code''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? levelList(dynamic response) => (getJsonField(
        response,
        r'''$.result.data[:].tph_level''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class MidFcstCall {
  static Future<ApiCallResponse> call({
    int? numOfRows,
    int? pageNo,
    String? dataType = 'JSON',
    String? regId = '',
    String? tmFc = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'MidFcst',
      apiUrl:
          'http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst?serviceKey=VcgMtzNuLXUcyCr6fVCfGeiT2b0iwexetcFE43%2FbFeTrUtz7afkQ3Y%2FG3WUyQaR4SBj6kQ96RY3kpvVz3sI%2Bfg%3D%3D',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'numOfRows': numOfRows,
        'pageNo': pageNo,
        'regId': regId,
        'tmFc': tmFc,
        'dataType': dataType,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? am3(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.body.items.item[:].wf3Am''',
      ));
  static String? am4(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.body.items.item[:].wf4Am''',
      ));
  static String? am5(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.body.items.item[:].wf5Am''',
      ));
  static String? am6(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.body.items.item[:].wf6Am''',
      ));
  static String? am7(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.body.items.item[:].wf7Am''',
      ));
  static int? rnSt3Am(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.response.body.items.item[:].rnSt3Am''',
      ));
  static int? rnSt4Am(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.response.body.items.item[:].rnSt4Am''',
      ));
  static int? rnSt5Am(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.response.body.items.item[:].rnSt5Am''',
      ));
  static int? rnSt6Am(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.response.body.items.item[:].rnSt6Am''',
      ));
  static int? rnSt7Am(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.response.body.items.item[:].rnSt7Am''',
      ));
}

class MidTmpCall {
  static Future<ApiCallResponse> call({
    int? numOfRows = 10,
    int? pageNo = 1,
    String? dataType = 'JSON',
    String? regId = '',
    String? tmFc = '0600',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'MidTmp',
      apiUrl:
          'http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa?serviceKey=VcgMtzNuLXUcyCr6fVCfGeiT2b0iwexetcFE43%2FbFeTrUtz7afkQ3Y%2FG3WUyQaR4SBj6kQ96RY3kpvVz3sI%2Bfg%3D%3D',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'regId': regId,
        'tmFc': tmFc,
        'numOfRows': numOfRows,
        'pageNo': pageNo,
        'dataType': dataType,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
