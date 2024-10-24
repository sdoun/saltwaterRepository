import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salt_water_beta_ver1/pages/point_explore_sum/review_bottomsheet/review_edit_model.dart' as model;

import '../../../backend/schema/t_b_user_review_point_record.dart';

class ReviewEditController{



  final _model = model.ReviewEditModel();
  late DocumentReference? reviewRef;

  get titleController => _model.titleController1;
  get titleFocusNode => _model.titleFieldFocusNode;
  get titleValidator => _model.titleController1Validator;

  get contentController => _model.contentController;
  get contetnFocusNode => _model.contentFocusNode;
  get contentValidator => _model.contentControllerValidator;

  ReviewEditController({required this.reviewRef}){
    print('reviewRef: $reviewRef');
  }
  void updateModelByController({String? initialTitle, String? initialContent}){
    _model.updateInitialValue(initialTitle: initialTitle, initialContent: initialContent);
  }

  void updatePointReview(){
    _model.updateReview(reviewRef, _model.titleController1?.text, _model.contentController?.text);
  }
  void deletePointReview(){
    _model.deleteReview(reviewRef);
  }
}