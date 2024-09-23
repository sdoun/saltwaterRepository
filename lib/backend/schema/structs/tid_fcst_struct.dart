// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TidFcstStruct extends FFFirebaseStruct {
  TidFcstStruct({
    int? time,
    String? tidType,
    String? tidLevel,
    String? timeString,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _time = time,
        _tidType = tidType,
        _tidLevel = tidLevel,
        _timeString = timeString,
        super(firestoreUtilData);

  // "time" field.
  int? _time;
  int get time => _time ?? 0;
  set time(int? val) => _time = val;

  void incrementTime(int amount) => time = time + amount;

  bool hasTime() => _time != null;

  // "tidType" field.
  String? _tidType;
  String get tidType => _tidType ?? '';
  set tidType(String? val) => _tidType = val;

  bool hasTidType() => _tidType != null;

  // "tidLevel" field.
  String? _tidLevel;
  String get tidLevel => _tidLevel ?? '';
  set tidLevel(String? val) => _tidLevel = val;

  bool hasTidLevel() => _tidLevel != null;

  // "timeString" field.
  String? _timeString;
  String get timeString => _timeString ?? '';
  set timeString(String? val) => _timeString = val;

  bool hasTimeString() => _timeString != null;

  static TidFcstStruct fromMap(Map<String, dynamic> data) => TidFcstStruct(
        time: castToType<int>(data['time']),
        tidType: data['tidType'] as String?,
        tidLevel: data['tidLevel'] as String?,
        timeString: data['timeString'] as String?,
      );

  static TidFcstStruct? maybeFromMap(dynamic data) =>
      data is Map ? TidFcstStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'time': _time,
        'tidType': _tidType,
        'tidLevel': _tidLevel,
        'timeString': _timeString,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'time': serializeParam(
          _time,
          ParamType.int,
        ),
        'tidType': serializeParam(
          _tidType,
          ParamType.String,
        ),
        'tidLevel': serializeParam(
          _tidLevel,
          ParamType.String,
        ),
        'timeString': serializeParam(
          _timeString,
          ParamType.String,
        ),
      }.withoutNulls;

  static TidFcstStruct fromSerializableMap(Map<String, dynamic> data) =>
      TidFcstStruct(
        time: deserializeParam(
          data['time'],
          ParamType.int,
          false,
        ),
        tidType: deserializeParam(
          data['tidType'],
          ParamType.String,
          false,
        ),
        tidLevel: deserializeParam(
          data['tidLevel'],
          ParamType.String,
          false,
        ),
        timeString: deserializeParam(
          data['timeString'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TidFcstStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TidFcstStruct &&
        time == other.time &&
        tidType == other.tidType &&
        tidLevel == other.tidLevel &&
        timeString == other.timeString;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([time, tidType, tidLevel, timeString]);
}

TidFcstStruct createTidFcstStruct({
  int? time,
  String? tidType,
  String? tidLevel,
  String? timeString,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TidFcstStruct(
      time: time,
      tidType: tidType,
      tidLevel: tidLevel,
      timeString: timeString,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TidFcstStruct? updateTidFcstStruct(
  TidFcstStruct? tidFcst, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tidFcst
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTidFcstStructData(
  Map<String, dynamic> firestoreData,
  TidFcstStruct? tidFcst,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tidFcst == null) {
    return;
  }
  if (tidFcst.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tidFcst.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tidFcstData = getTidFcstFirestoreData(tidFcst, forFieldValue);
  final nestedData = tidFcstData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tidFcst.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTidFcstFirestoreData(
  TidFcstStruct? tidFcst, [
  bool forFieldValue = false,
]) {
  if (tidFcst == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tidFcst.toMap());

  // Add any Firestore field values
  tidFcst.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTidFcstListFirestoreData(
  List<TidFcstStruct>? tidFcsts,
) =>
    tidFcsts?.map((e) => getTidFcstFirestoreData(e, true)).toList() ?? [];
