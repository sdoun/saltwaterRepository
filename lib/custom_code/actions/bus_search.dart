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

Future<List<TBFishingBusRecord>?> busSearch(
  List<String>? fishes,
  List<String>? busExtraFilter,
  List<String>? area,
  DateTime? startDate,
  DateTime? endDate,
  List<String>? busTime,
) async {
  // Add your function code here!
  final firestoreInstance = FirebaseFirestore.instance;
  final packageReference = firestoreInstance.collection('TB_fishingBus');
  final querysnapshot = await packageReference.get();

  List<DocumentSnapshot> busList =
      []; // Initialize busList as a List<DocumentSnapshot>

  for (var bus in querysnapshot.docs) {
    try {
      final busArea = bus.get('bus_area') as String? ?? '';
      final busDate = (bus.get('bus_date') as Timestamp?)?.toDate();
      final busFish =
          (bus.get('bus_fishes') as List<dynamic>?)?.cast<String>() ?? [];
      final timeOfUse = (bus.get('bus_timeOfUse') as double?);
      final fishing =
          (bus.get('bus_fishing') as List<dynamic>?)?.cast<String>() ?? [];
      final payment =
          (bus.get('bus_payment') as List<dynamic>?)?.cast<String>() ?? [];
      final busExtra = [...fishing, ...payment];

      bool areaFilter = area == null || area.isEmpty || area.contains(busArea);
      bool dateFilter = (startDate == null && endDate == null) ||
          (busDate != null &&
              busDate.millisecondsSinceEpoch >=
                  startDate!.millisecondsSinceEpoch &&
              busDate.millisecondsSinceEpoch <=
                  endDate!.millisecondsSinceEpoch);
      bool fishFilter = fishes == null ||
          fishes.isEmpty ||
          busFish.any((element) => fishes.contains(element));
      bool extraFilter = busExtraFilter == null ||
          busExtraFilter.isEmpty ||
          busExtra.any((element) => busExtraFilter.contains(element));

      bool timeFilter = busTime == null ||
          busTime.isEmpty ||
          (timeOfUse != null &&
              ((busTime.contains('3시간이하') && timeOfUse <= 3.0) ||
                  (busTime.contains('3~6시간') &&
                      timeOfUse >= 3.0 &&
                      timeOfUse <= 6.0) ||
                  (busTime.contains('6~9시간') &&
                      timeOfUse >= 6.0 &&
                      timeOfUse <= 9.0) ||
                  (busTime.contains('0시간이상') && timeOfUse >= 9.0)));

      if (extraFilter && fishFilter && areaFilter && dateFilter && timeFilter) {
        busList.add(bus);
        print('Added bus: ${bus.id}');
      }
    } catch (e) {
      print('Error processing bus ${bus.id}: $e');
      // 오류가 발생한 문서는 건너뜁니다.
      continue;
    }
  }

  if (busList.isEmpty) {
    print('No buses found matching the criteria');
    return [];
  }

  List<TBFishingBusRecord> busRecords = busList
      .map((doc) {
        try {
          return TBFishingBusRecord.fromSnapshot(doc);
        } catch (e) {
          print('Error creating TBFishingBusRecord from doc ${doc.id}: $e');
          return null;
        }
      })
      .whereType<TBFishingBusRecord>()
      .toList();

  print('Found ${busRecords.length} buses');
  return busRecords;
}
