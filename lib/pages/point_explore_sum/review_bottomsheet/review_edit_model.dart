import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../backend/schema/t_b_user_review_point_record.dart';

class ReviewEditModel {
  String? initialTitle;
  String? initialContent;
  FocusNode? titleFieldFocusNode = FocusNode();
  TextEditingController? titleController1;
  FormFieldValidator<String>?  titleController1Validator;
  // State field(s) for shortBio widget.
  FocusNode? contentFocusNode = FocusNode();
  TextEditingController? contentController;
  FormFieldValidator<String>? contentControllerValidator;

  static String? defaultValidator(String? value){
    if(value == null || value.isEmpty){
      return '이 필드는 비어있습니다.';
    }
    return null;
  }

  ReviewEditModel({this.initialTitle, this.initialContent}){
    titleController1Validator = defaultValidator;
    contentControllerValidator = defaultValidator;
  }
  void updateInitialValue({String? initialTitle, String? initialContent}){
    titleController1 = TextEditingController(text: initialTitle);
    contentController = TextEditingController(text: initialContent);
  }

  @override
  void initState(BuildContext context) {
    titleController1Validator = defaultValidator;
    contentControllerValidator = defaultValidator;
  }

  @override
  void dispose() {
    titleFieldFocusNode?.dispose();
    titleController1?.dispose();

    contentFocusNode?.dispose();
    contentController?.dispose();
  }

  void updateReview(
      DocumentReference? reviewRef,
      String? reviewTitle,
      String? reviewContent
      ) async{
    if(reviewRef != null){
      print(reviewRef);
      reviewRef.update({
        'review_title': reviewTitle,
        'review_text': reviewContent
      });
    }
    return;
  }
  void deleteReview(
      DocumentReference? reviewRef
      ){
    if(reviewRef != null) {
      reviewRef.delete();
    }
  }
}