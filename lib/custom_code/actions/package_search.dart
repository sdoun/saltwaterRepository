// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

Future<List<TBTravelPackageRecord>?> packageSearch(
  List<String>? area,
  List<String>? type,
  List<String>? typedetailed,
) async {
  // Add your function code here!
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    final packageReference = firestoreInstance.collection('TB_travelPackage');

    List<Future<QuerySnapshot>> queries = [];
    List<Set<String>> resultSets = [];

    // 각 조건에 대한 쿼리 생성
    if (area != null && area.isNotEmpty) {
      queries.add(packageReference.where('package_area', whereIn: area).get());
      resultSets.add({});
    }
    if (type != null && type.isNotEmpty) {
      queries.add(packageReference.where('package_type', whereIn: type).get());
      resultSets.add({});
    }
    if (typedetailed != null && typedetailed.isNotEmpty) {
      queries.add(packageReference
          .where('package_typeDetailed', whereIn: typedetailed)
          .get());
      resultSets.add({});
    }

    // 쿼리가 없는 경우 빈 리스트 반환
    if (queries.isEmpty) {
      return [];
    }

    // 모든 쿼리 실행
    List<QuerySnapshot> results = await Future.wait(queries);

    // 각 쿼리 결과의 문서 ID를 해당 Set에 추가
    for (int i = 0; i < results.length; i++) {
      for (var doc in results[i].docs) {
        resultSets[i].add(doc.id);
      }
    }

    // 모든 Set의 교집합 구하기
    Set<String> intersectionSet =
        resultSets.reduce((a, b) => a.intersection(b));

    // 교집합에 해당하는 문서만 TBTravelPackageRecord로 변환
    List<TBTravelPackageRecord> packageRecords = [];
    for (var querySnapshot in results) {
      for (var doc in querySnapshot.docs) {
        if (intersectionSet.contains(doc.id)) {
          packageRecords.add(TBTravelPackageRecord.fromSnapshot(doc));
          // 중복 방지를 위해 이미 추가한 문서는 제거
          intersectionSet.remove(doc.id);
        }
      }
    }

    return packageRecords;
  } catch (e) {
    print('Error in packageSearch: $e');
    return [];
  }
}
