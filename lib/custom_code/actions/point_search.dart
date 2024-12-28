import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

List<TBPointRecord> pointSearch(String? keywords, List<TBPointRecord> points){
  if(keywords == null){
    return points;
  }
  List<TBPointRecord> result = [];
  List<String> keyWordList = [];
  keywords.replaceAll('.', ' ');
  keyWordList = keywords.split(' ');

  for(var keyword in keyWordList){
    for(var item in points){
      if(item.pointName.contains(keyword) || item.pointCategories.contains(keyword) ||
          item.pointAddress.contains(keyword) || item.pointIntroduction.contains(keyword)){
        result.add(item);
      }
    }
  }
  return result;
}