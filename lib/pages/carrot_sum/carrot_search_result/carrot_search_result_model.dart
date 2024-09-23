import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/carrot_sum/carrot_nav_bar/carrot_nav_bar_widget.dart';
import 'carrot_search_result_widget.dart' show CarrotSearchResultWidget;
import 'package:flutter/material.dart';

class CarrotSearchResultModel
    extends FlutterFlowModel<CarrotSearchResultWidget> {
  ///  Local state fields for this page.

  List<TBCarrotPostRecord> posts = [];
  void addToPosts(TBCarrotPostRecord item) => posts.add(item);
  void removeFromPosts(TBCarrotPostRecord item) => posts.remove(item);
  void removeAtIndexFromPosts(int index) => posts.removeAt(index);
  void insertAtIndexInPosts(int index, TBCarrotPostRecord item) =>
      posts.insert(index, item);
  void updatePostsAtIndex(int index, Function(TBCarrotPostRecord) updateFn) =>
      posts[index] = updateFn(posts[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in carrot_searchResult widget.
  List<TBCarrotPostRecord>? postsQuery;
  // Stores action output result for [Custom Action - carrotSearch] action in carrot_searchResult widget.
  List<TBCarrotPostRecord>? searchResults;
  // Model for carrotNavBar component.
  late CarrotNavBarModel carrotNavBarModel;

  @override
  void initState(BuildContext context) {
    carrotNavBarModel = createModel(context, () => CarrotNavBarModel());
  }

  @override
  void dispose() {
    carrotNavBarModel.dispose();
  }
}
