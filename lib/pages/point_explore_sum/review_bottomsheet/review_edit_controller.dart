import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salt_water_beta_ver1/pages/point_explore_sum/review_bottomsheet/review_edit_model.dart' as model;

import '../../../backend/schema/t_b_user_review_point_record.dart';
import '../../../flutter_flow/uploaded_file.dart';

class ReviewEditController{



  final _model = model.ReviewEditModel();
  late DocumentReference? reviewRef;

  get titleController => _model.titleController1;
  get titleFocusNode => _model.titleFieldFocusNode;
  get titleValidator => _model.titleController1Validator;

  get contentController => _model.contentController;
  get contetnFocusNode => _model.contentFocusNode;
  get contentValidator => _model.contentControllerValidator;

  get reviewImages => _model.imageList;

  bool isImageUploaing = false;
  List<FFUploadedFile> uploadedImages = [];
  List<String> uploadedImageUrls = [];


  ReviewEditController({required this.reviewRef}){
    print('reviewRef: $reviewRef');
  }
  void updateModelByController({String? initialTitle, String? initialContent, required List<String> images}){
    _model.updateInitialValue(
        initialTitle: initialTitle,
        initialContent: initialContent,
        initialImages: images
    );
  }

  void removeImageAt(int index){
    _model.imageList.removeAt(index);
  }
  void mergeImages(List<String> imageList){
    _model.imageList += imageList;
  }
  void setImages(List<String> data){
    _model.imageList = data;
  }

  void updatePointReview(){
    _model.updateReview(
        reviewRef,
        _model.titleController1?.text,
        _model.contentController?.text,
      _model.imageList
    );
  }
  void deletePointReview(){
    _model.deleteReview(reviewRef);
  }
}