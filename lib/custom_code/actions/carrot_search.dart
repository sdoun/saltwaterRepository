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

Future<List<TBCarrotPostRecord>> carrotSearch(
  String? searchText,
  List<TBCarrotPostRecord>? carrotPosts,
) async {
  // Add your function code here!
  List<TBCarrotPostRecord>? result = [];

  if (carrotPosts == null) {
    return result;
  }

  if (searchText == null && carrotPosts != null) {
    return carrotPosts;
  }

  for (var post in carrotPosts) {
    var postTitle = post.postTitle;
    var postCategory = post.postCategory;
    if (postTitle.contains(searchText!) || postCategory.contains(searchText)) {
      result.add(post);
    }
  }
  return result;
}
