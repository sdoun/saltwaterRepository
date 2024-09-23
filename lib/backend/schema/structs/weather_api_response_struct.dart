// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class WeatherApiResponseStruct extends FFFirebaseStruct {
  WeatherApiResponseStruct({
    int? basedate,
    int? basetime,
    String? category,
    double? nx,
    double? ny,
    double? obsrValue,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _basedate = basedate,
        _basetime = basetime,
        _category = category,
        _nx = nx,
        _ny = ny,
        _obsrValue = obsrValue,
        super(firestoreUtilData);

  // "basedate" field.
  int? _basedate;
  int get basedate => _basedate ?? 0;
  set basedate(int? val) => _basedate = val;

  void incrementBasedate(int amount) => basedate = basedate + amount;

  bool hasBasedate() => _basedate != null;

  // "basetime" field.
  int? _basetime;
  int get basetime => _basetime ?? 0;
  set basetime(int? val) => _basetime = val;

  void incrementBasetime(int amount) => basetime = basetime + amount;

  bool hasBasetime() => _basetime != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "nx" field.
  double? _nx;
  double get nx => _nx ?? 0.0;
  set nx(double? val) => _nx = val;

  void incrementNx(double amount) => nx = nx + amount;

  bool hasNx() => _nx != null;

  // "ny" field.
  double? _ny;
  double get ny => _ny ?? 0.0;
  set ny(double? val) => _ny = val;

  void incrementNy(double amount) => ny = ny + amount;

  bool hasNy() => _ny != null;

  // "obsrValue" field.
  double? _obsrValue;
  double get obsrValue => _obsrValue ?? 0.0;
  set obsrValue(double? val) => _obsrValue = val;

  void incrementObsrValue(double amount) => obsrValue = obsrValue + amount;

  bool hasObsrValue() => _obsrValue != null;

  static WeatherApiResponseStruct fromMap(Map<String, dynamic> data) =>
      WeatherApiResponseStruct(
        basedate: castToType<int>(data['basedate']),
        basetime: castToType<int>(data['basetime']),
        category: data['category'] as String?,
        nx: castToType<double>(data['nx']),
        ny: castToType<double>(data['ny']),
        obsrValue: castToType<double>(data['obsrValue']),
      );

  static WeatherApiResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? WeatherApiResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'basedate': _basedate,
        'basetime': _basetime,
        'category': _category,
        'nx': _nx,
        'ny': _ny,
        'obsrValue': _obsrValue,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'basedate': serializeParam(
          _basedate,
          ParamType.int,
        ),
        'basetime': serializeParam(
          _basetime,
          ParamType.int,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'nx': serializeParam(
          _nx,
          ParamType.double,
        ),
        'ny': serializeParam(
          _ny,
          ParamType.double,
        ),
        'obsrValue': serializeParam(
          _obsrValue,
          ParamType.double,
        ),
      }.withoutNulls;

  static WeatherApiResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      WeatherApiResponseStruct(
        basedate: deserializeParam(
          data['basedate'],
          ParamType.int,
          false,
        ),
        basetime: deserializeParam(
          data['basetime'],
          ParamType.int,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        nx: deserializeParam(
          data['nx'],
          ParamType.double,
          false,
        ),
        ny: deserializeParam(
          data['ny'],
          ParamType.double,
          false,
        ),
        obsrValue: deserializeParam(
          data['obsrValue'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'WeatherApiResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WeatherApiResponseStruct &&
        basedate == other.basedate &&
        basetime == other.basetime &&
        category == other.category &&
        nx == other.nx &&
        ny == other.ny &&
        obsrValue == other.obsrValue;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([basedate, basetime, category, nx, ny, obsrValue]);
}

WeatherApiResponseStruct createWeatherApiResponseStruct({
  int? basedate,
  int? basetime,
  String? category,
  double? nx,
  double? ny,
  double? obsrValue,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    WeatherApiResponseStruct(
      basedate: basedate,
      basetime: basetime,
      category: category,
      nx: nx,
      ny: ny,
      obsrValue: obsrValue,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

WeatherApiResponseStruct? updateWeatherApiResponseStruct(
  WeatherApiResponseStruct? weatherApiResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    weatherApiResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addWeatherApiResponseStructData(
  Map<String, dynamic> firestoreData,
  WeatherApiResponseStruct? weatherApiResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (weatherApiResponse == null) {
    return;
  }
  if (weatherApiResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && weatherApiResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final weatherApiResponseData =
      getWeatherApiResponseFirestoreData(weatherApiResponse, forFieldValue);
  final nestedData =
      weatherApiResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      weatherApiResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getWeatherApiResponseFirestoreData(
  WeatherApiResponseStruct? weatherApiResponse, [
  bool forFieldValue = false,
]) {
  if (weatherApiResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(weatherApiResponse.toMap());

  // Add any Firestore field values
  weatherApiResponse.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getWeatherApiResponseListFirestoreData(
  List<WeatherApiResponseStruct>? weatherApiResponses,
) =>
    weatherApiResponses
        ?.map((e) => getWeatherApiResponseFirestoreData(e, true))
        .toList() ??
    [];
