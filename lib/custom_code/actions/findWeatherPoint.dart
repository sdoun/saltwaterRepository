

import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/backend.dart';
import '../../flutter_flow/lat_lng.dart';

Future<DocumentReference> findWeatherPoint(double baseLat, double baseLng) async{
  final firestoreInstance = FirebaseFirestore.instance;

  // Create a reference to the collection
  final collectionReference = firestoreInstance.collection('TB_weatherPoint');
  final querysnapshot = await collectionReference.get();
  List<double> distances = [];
  List<DocumentSnapshot> docs = querysnapshot.docs;
  for(final documentSnapshot in querysnapshot.docs){
    if(documentSnapshot.data().containsKey('latlng')){
      final weatherLocation = documentSnapshot.get('latlng');
      double x = weatherLocation.latitude - baseLat;
      x = x * x;
      double y = weatherLocation.longitude - baseLng;
      y = y * y;
      distances.add(x+y);
      print(documentSnapshot.data().containsKey('name'));
    }
  }
  int minIndex = 0;
  for (int i = 0; i < distances.length; i++) {
    if (distances[i] < distances[minIndex]) {
      minIndex = i;
    }
  }
  print('weatherpoint string is: ${docs[minIndex].toString()}');
  return docs[minIndex].reference;
}