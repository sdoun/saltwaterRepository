// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SignInAgreementStruct extends FFFirebaseStruct {
  SignInAgreementStruct({
    bool? personalData,
    bool? geoBased,
    bool? marketingNoti,
    bool? serviceTerms,
    bool? phoneAuth,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _personalData = personalData,
        _geoBased = geoBased,
        _marketingNoti = marketingNoti,
        _serviceTerms = serviceTerms,
        _phoneAuth = phoneAuth,
        super(firestoreUtilData);

  // "personal_data" field.
  bool? _personalData;
  bool get personalData => _personalData ?? false;
  set personalData(bool? val) => _personalData = val;

  bool hasPersonalData() => _personalData != null;

  // "geo_based" field.
  bool? _geoBased;
  bool get geoBased => _geoBased ?? false;
  set geoBased(bool? val) => _geoBased = val;

  bool hasGeoBased() => _geoBased != null;

  // "marketing_noti" field.
  bool? _marketingNoti;
  bool get marketingNoti => _marketingNoti ?? false;
  set marketingNoti(bool? val) => _marketingNoti = val;

  bool hasMarketingNoti() => _marketingNoti != null;

  // "service_terms" field.
  bool? _serviceTerms;
  bool get serviceTerms => _serviceTerms ?? false;
  set serviceTerms(bool? val) => _serviceTerms = val;

  bool hasServiceTerms() => _serviceTerms != null;

  // "phone_auth" field.
  bool? _phoneAuth;
  bool get phoneAuth => _phoneAuth ?? false;
  set phoneAuth(bool? val) => _phoneAuth = val;

  bool hasPhoneAuth() => _phoneAuth != null;

  static SignInAgreementStruct fromMap(Map<String, dynamic> data) =>
      SignInAgreementStruct(
        personalData: data['personal_data'] as bool?,
        geoBased: data['geo_based'] as bool?,
        marketingNoti: data['marketing_noti'] as bool?,
        serviceTerms: data['service_terms'] as bool?,
        phoneAuth: data['phone_auth'] as bool?,
      );

  static SignInAgreementStruct? maybeFromMap(dynamic data) => data is Map
      ? SignInAgreementStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'personal_data': _personalData,
        'geo_based': _geoBased,
        'marketing_noti': _marketingNoti,
        'service_terms': _serviceTerms,
        'phone_auth': _phoneAuth,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'personal_data': serializeParam(
          _personalData,
          ParamType.bool,
        ),
        'geo_based': serializeParam(
          _geoBased,
          ParamType.bool,
        ),
        'marketing_noti': serializeParam(
          _marketingNoti,
          ParamType.bool,
        ),
        'service_terms': serializeParam(
          _serviceTerms,
          ParamType.bool,
        ),
        'phone_auth': serializeParam(
          _phoneAuth,
          ParamType.bool,
        ),
      }.withoutNulls;

  static SignInAgreementStruct fromSerializableMap(Map<String, dynamic> data) =>
      SignInAgreementStruct(
        personalData: deserializeParam(
          data['personal_data'],
          ParamType.bool,
          false,
        ),
        geoBased: deserializeParam(
          data['geo_based'],
          ParamType.bool,
          false,
        ),
        marketingNoti: deserializeParam(
          data['marketing_noti'],
          ParamType.bool,
          false,
        ),
        serviceTerms: deserializeParam(
          data['service_terms'],
          ParamType.bool,
          false,
        ),
        phoneAuth: deserializeParam(
          data['phone_auth'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'SignInAgreementStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SignInAgreementStruct &&
        personalData == other.personalData &&
        geoBased == other.geoBased &&
        marketingNoti == other.marketingNoti &&
        serviceTerms == other.serviceTerms &&
        phoneAuth == other.phoneAuth;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([personalData, geoBased, marketingNoti, serviceTerms, phoneAuth]);
}

SignInAgreementStruct createSignInAgreementStruct({
  bool? personalData,
  bool? geoBased,
  bool? marketingNoti,
  bool? serviceTerms,
  bool? phoneAuth,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SignInAgreementStruct(
      personalData: personalData,
      geoBased: geoBased,
      marketingNoti: marketingNoti,
      serviceTerms: serviceTerms,
      phoneAuth: phoneAuth,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SignInAgreementStruct? updateSignInAgreementStruct(
  SignInAgreementStruct? signInAgreement, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    signInAgreement
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSignInAgreementStructData(
  Map<String, dynamic> firestoreData,
  SignInAgreementStruct? signInAgreement,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (signInAgreement == null) {
    return;
  }
  if (signInAgreement.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && signInAgreement.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final signInAgreementData =
      getSignInAgreementFirestoreData(signInAgreement, forFieldValue);
  final nestedData =
      signInAgreementData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = signInAgreement.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSignInAgreementFirestoreData(
  SignInAgreementStruct? signInAgreement, [
  bool forFieldValue = false,
]) {
  if (signInAgreement == null) {
    return {};
  }
  final firestoreData = mapToFirestore(signInAgreement.toMap());

  // Add any Firestore field values
  signInAgreement.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSignInAgreementListFirestoreData(
  List<SignInAgreementStruct>? signInAgreements,
) =>
    signInAgreements
        ?.map((e) => getSignInAgreementFirestoreData(e, true))
        .toList() ??
    [];
