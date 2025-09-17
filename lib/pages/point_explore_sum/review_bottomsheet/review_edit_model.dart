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
  List<String> imageList = [];

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
  void updateInitialValue({String? initialTitle, String? initialContent, required List<String> initialImages}){
    titleController1 = TextEditingController(text: initialTitle);
    contentController = TextEditingController(text: initialContent);
    imageList = initialImages;
    //['https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%88%98%EC%A0%95%ED%8E%98%EC%9D%B4%EC%A7%80%2F%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%9D%B4%EB%AF%B8%EC%A7%80%EC%97%86%EC%9D%8C.png?alt=media&token=b357c611-3df0-4134-bf83-6d72fa96b82e'] : initialImages;
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
      String? reviewContent,
      List<String> reviewImages
      ) async{
    if(reviewRef != null){
      print(reviewRef);
      reviewRef.update({
        'review_title': reviewTitle,
        'review_text': reviewContent,
        'review_images' : reviewImages
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