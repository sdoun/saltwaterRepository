// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PointSchemaStruct extends FFFirebaseStruct {
  PointSchemaStruct({
    String? pointName,
    String? pointCategory,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _pointName = pointName,
        _pointCategory = pointCategory,
        super(firestoreUtilData);

  // "point_name" field.
  String? _pointName;
  String get pointName => _pointName ?? '';
  set pointName(String? val) => _pointName = val;

  bool hasPointName() => _pointName != null;

  // "point_category" field.
  String? _pointCategory;
  String get pointCategory => _pointCategory ?? '';
  set pointCategory(String? val) => _pointCategory = val;

  bool hasPointCategory() => _pointCategory != null;

  static PointSchemaStruct fromMap(Map<String, dynamic> data) =>
      PointSchemaStruct(
        pointName: data['point_name'] as String?,
        pointCategory: data['point_category'] as String?,
      );

  static PointSchemaStruct? maybeFromMap(dynamic data) => data is Map
      ? PointSchemaStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'point_name': _pointName,
        'point_category': _pointCategory,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'point_name': serializeParam(
          _pointName,
          ParamType.String,
        ),
        'point_category': serializeParam(
          _pointCategory,
          ParamType.String,
        ),
      }.withoutNulls;

  static PointSchemaStruct fromSerializableMap(Map<String, dynamic> data) =>
      PointSchemaStruct(
        pointName: deserializeParam(
          data['point_name'],
          ParamType.String,
          false,
        ),
        pointCategory: deserializeParam(
          data['point_category'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PointSchemaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PointSchemaStruct &&
        pointName == other.pointName &&
        pointCategory == other.pointCategory;
  }

  @override
  int get hashCode => const ListEquality().hash([pointName, pointCategory]);
}

PointSchemaStruct createPointSchemaStruct({
  String? pointName,
  String? pointCategory,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PointSchemaStruct(
      pointName: pointName,
      pointCategory: pointCategory,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PointSchemaStruct? updatePointSchemaStruct(
  PointSchemaStruct? pointSchema, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pointSchema
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPointSchemaStructData(
  Map<String, dynamic> firestoreData,
  PointSchemaStruct? pointSchema,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pointSchema == null) {
    return;
  }
  if (pointSchema.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pointSchema.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pointSchemaData =
      getPointSchemaFirestoreData(pointSchema, forFieldValue);
  final nestedData =
      pointSchemaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pointSchema.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPointSchemaFirestoreData(
  PointSchemaStruct? pointSchema, [
  bool forFieldValue = false,
]) {
  if (pointSchema == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pointSchema.toMap());

  // Add any Firestore field values
  pointSchema.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPointSchemaListFirestoreData(
  List<PointSchemaStruct>? pointSchemas,
) =>
    pointSchemas?.map((e) => getPointSchemaFirestoreData(e, true)).toList() ??
    [];
