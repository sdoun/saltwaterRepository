import 'package:app_version_update/app_version_update.dart';
import 'package:salt_water_beta_ver1/backend/schema/TBPointThemeRecord.dart';
import 'package:salt_water_beta_ver1/backend/schema/TBniceFishing.dart';
import 'package:salt_water_beta_ver1/components/chatFAB.dart';
import 'package:salt_water_beta_ver1/reusable/home1/pointAdsPageview.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../flutter_flow/custom_functions.dart' as functions;
import '../../reusable/common/appOffBottomSheet.dart';
import '../../reusable/common/basicScaffold.dart';
import '../../reusable/common/pulsatingImage.dart';
import '../../reusable/common/report_bottomsheet.dart';
import '../point_explore_sum/review_bottomsheet/review_edit_view.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/point_explore_sum/point_category/point_category_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home1_model.dart';
export 'home1_model.dart';

import 'package:salt_water_beta_ver1/reusable/home1/pointButton.dart';
import 'package:salt_water_beta_ver1/reusable/home1/fishButton.dart';
import 'package:salt_water_beta_ver1/reusable/home1/homeAdsPageView.dart';

class Home1Widget extends StatefulWidget {
  const Home1Widget({super.key});

  @override
  State<Home1Widget> createState() => _Home1WidgetState();
}

class _Home1WidgetState extends State<Home1Widget> {


  late Home1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  final _adsLength = 5;
  final _themeLength = 5;

  void verifyVersion(BuildContext context) async {


    await AppVersionUpdate.checkForUpdates(
      //앱 ID는 환경변수로 사용하는 방법 고려할 것
      appleId: '6745240398',
      playStoreId: 'com.mycompany.saltwaterbetaver1',
      country: 'kr',
    ).then((result) async {
      print('id: ${result.playStoreId}');
      if (result.canUpdate!) {
        print('업데이트 가능: ${result.storeUrl}'); // 업데이트 가능한 경우 메시지 출력

        await AppVersionUpdate.showAlertUpdate(
            appVersionResult: result,
            context: context,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            title: '새로운 업데이트가 있습니다!',
            titleTextStyle: FlutterFlowTheme.of(context)
                .headlineSmall
                .override(
              fontFamily:
              'PretendardSeries',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 15.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w800,
              useGoogleFonts: GoogleFonts
                  .asMap()
                  .containsKey(
                  'PretendardSeries'),
            ),
            content: '스토어로 이동하여 업데이트를 진행해주세요!',
            contentTextStyle: FlutterFlowTheme.of(context)
                .bodyMedium
                .override(
              fontFamily:
              'PretendardSeries',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 12.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
              useGoogleFonts: GoogleFonts
                  .asMap()
                  .containsKey(
                  'PretendardSeries'),
            ),
            updateButtonText: '업데이트',
            updateButtonStyle: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(FlutterFlowTheme.of(context).primaryBackground)
            ),
            updateTextStyle:
            FlutterFlowTheme.of(context)
                .headlineSmall
                .override(
              fontFamily:
              'PretendardSeries',
              color: FlutterFlowTheme.of(context).primary,
              fontSize: 15.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w800,
              useGoogleFonts: GoogleFonts
                  .asMap()
                  .containsKey(
                  'PretendardSeries'),
            ),
            cancelButtonText: '취소',
            cancelTextStyle: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText
            ),
            cancelButtonStyle: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white12),
            ));
      } else {
        print('업데이트 불가: $result'); // 업데이트 불가능한 경우 메시지 출력
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getReviewStream() {

    final snapshots = FirebaseFirestore.instance.collection('TB_userReview_point')
        .orderBy('timestamp', descending: false).snapshots();
    return snapshots;
  }

  @override
  void initState() {
    super.initState();
    verifyVersion(context);
    _model = createModel(context, () => Home1Model());
    FFAppState().fishes.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    loadPointAds();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> loadPointAds() async{
    setState(() {
      _isLoading = true;
    });

    Query query = _firestore.collection('TB_pointAds').orderBy('timestamp', descending: true).limit(_adsLength);
    QuerySnapshot querySnapshot = await query.get();
    FFAppState().pointAds = querySnapshot;
    setState(() {
      _isLoading = false;
    });
  }
  Future<QuerySnapshot> fetchThemes() async{

    print('start fetching themes');
    if(FFAppState().pointThemes == null || FFAppState().pointThemes!.docs.isEmpty){
      setState(() {
        _isLoading = true;
      });
      final allThemes = await FirebaseFirestore.instance.collection('/TB_pointTheme').where('theme_active', isEqualTo: true).get();
      print('theme query snapshot $allThemes');
      FFAppState().pointThemes = allThemes;
      setState(() {
        _isLoading = false;
      });
      return allThemes;
    }
    else{
      return Future.value(FFAppState().pointThemes);
    }
  }

  Future<QuerySnapshot> fetchFishings() async{

    if(FFAppState().niceFishings == null || FFAppState().niceFishings!.docs.isEmpty){
      setState(() {
        _isLoading = true;
      });
      final allFishings = await FirebaseFirestore.instance.collection('/TB_niceFishing').where('active', isEqualTo: true).get();
      print('fishing query snapshot docs ${allFishings.docs}');
      FFAppState().niceFishings = allFishings;
      return allFishings;

    }
    else{
      return Future.value(FFAppState().niceFishings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
          final shouldpop = await showModalBottomSheet<bool>(
          context: context,
          builder: (context){
            return const WebViewAware(
                child: Appoffbottomsheet()
            );
          }
        );
          return shouldpop ?? false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Basicscaffold(
          key: scaffoldKey,

          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leadingWidth: 180.0,
            leading: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  12, 0, 0, 0
              ),
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 48,
                        child: Image.asset('assets/images/상단바로고1.png')
                    ),
                  ],
                ),
              ),
            ),
            title: const Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
              ),
            ),
            actions: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed('service_is_not_ready');
                    },
                    child: Container(
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                              child: Image.asset(
                                'assets/images/q3052_.png',
                                height: 36,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: badges.Badge(
                                  badgeContent: Text(
                                    '0',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      fontSize: 12,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                                          FlutterFlowTheme.of(context)
                                              .titleSmallFamily),
                                    ),
                                  ),
                                  showBadge: true,
                                  shape: badges.BadgeShape.circle,
                                  badgeColor: FlutterFlowTheme.of(context).primary,
                                  elevation: 4.0,
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(3.0, 3.0, 3.0, 3.0),
                                  position: badges.BadgePosition.topEnd(),
                                  animationType: badges.BadgeAnimationType.scale,
                                  toAnimate: true,
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed('service_is_not_ready');
                    },
                    child: Container(
                      width: 36.0,
                      height: 36.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/aqdbq_.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.menu,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('menu');
                    },
                  ),
                ],
              ),
            ],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                        child: InkWell(
                          onTap: () async {
                            safeSetState(() {});
                            context.pushNamed('homeSearchPage');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border: Border(
                                    top: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                    left: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                    right: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                    bottom: BorderSide(color: FlutterFlowTheme.of(context).primary)
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 8, 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      safeSetState(() {});
                                      context.pushNamed('homeSearchPage');
                                    },
                                    child: Text(
                                      '검색어를 입력해주세요.',
                                      style: FlutterFlowTheme.of(context).bodyMedium
                                          .override(
                                        fontFamily: 'PretendardSeries',
                                        fontSize: 14.0,
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        letterSpacing:
                                        0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: GoogleFonts
                                            .asMap()
                                            .containsKey(
                                            'PretendardSeries'),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      safeSetState(() {});
                                      context.pushNamed('homeSearchPage', queryParameters: {'searchText':_model.textController.text});
                                    },
                                    child: Container(
                                      width: 32.0,
                                      height: 32.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/images/검색옅은색.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: queryTBUserReviewPointRecord(
                            limit: 3,
                            queryBuilder: (record){
                              return record.orderBy('timestamp', descending: true);
                            }
                          ),//getReviewStream(),
                          builder: (context, snapshot){
                            if(snapshot.hasError){
                              return SizedBox(height: 20,);
                            }
                            else if(!snapshot.hasData){
                              return SizedBox(height: 20,);
                            }
                            else{
                              //print('docs: ${snapshot.data!}');
                              var reviewList = snapshot.data!;
                              //reviewList.sort(())
                              /*
                              var reviewList = snapshot.data!.map((snap){
                                return TBUserReviewPointRecord.fromSnapshot(snap);
                              }).toList();
                               */
                              //print('initialReviewList: ${reviewList}');
                              reviewList = reviewList.where((item){
                                return !(item.reviewReportedBy.contains(currentUserReference));
                              }).toList();
                              print('review length: ${reviewList.length}');
                              //print(reviewList);
                             return Padding(
                               padding: EdgeInsetsGeometry.directional(start: 20, top: 20, end: 20, bottom: 20),
                               child: Column(
                                 children: List.generate(3, (index){
                                   final review = reviewList[index];
                                   return FutureBuilder(
                                       future: TBPointRecord.getDocumentOnce(review.parentReference),
                                       builder: (context, asyncSnapshot) {
                                         if(!asyncSnapshot.hasData){
                                           return SizedBox(height: 20,);
                                         }
                                         final point = asyncSnapshot.data!;
                                         return StreamBuilder(
                                           //여기서 BadState: No Element 에러 발생함
                                             stream: UsersRecord.getDocument(review.reviewWrittenBy!),
                                             builder: (context, snapshot){
                                               if(snapshot.hasError){
                                                 print('snapshot error: ${snapshot.error}');
                                                 return SizedBox(height: 8,);
                                               }
                                               else if(!snapshot.hasData){
                                                 return SizedBox(height: 8,);
                                               }
                                               final containerUsersRecord = snapshot.data!;
                                               return Container(
                                                 width: double.infinity,
                                                 height: 100.0,
                                                 decoration: BoxDecoration(
                                                   color: FlutterFlowTheme.of(context)
                                                       .primaryBackground,),
                                                 child: Padding(
                                                   padding: const EdgeInsetsDirectional.fromSTEB(
                                                       0.0, 0.0, 8.0, 8.0),
                                                   child: InkWell(
                                                     onTap: (){

                                                       if(point.pointCategories == '체험낚시배' || point.pointCategories == '낚시배'){
                                                         context.pushNamed(
                                                           'boat_detailed',
                                                           queryParameters: {
                                                             'pointRefSW': serializeParam(
                                                               point.reference,
                                                               ParamType.DocumentReference,
                                                             ),
                                                           }.withoutNulls,
                                                         );
                                                       }
                                                       else {
                                                         context.pushNamed('point_detailed', queryParameters: {
                                                           'pointRefSW': serializeParam(point.reference, ParamType.DocumentReference)
                                                         }.withoutNulls);
                                                       }

                                                       /*
                                                       context.pushNamed('reviewDetailed',
                                                        queryParameters: {'reviewRef': review.reference.path}
                                                       );
                                                        */
                                                     },
                                                     child: Row(
                                                       crossAxisAlignment: CrossAxisAlignment.center,
                                                       children: [
                                                         Padding(
                                                           padding: const EdgeInsets.only(right: 8.0),
                                                           child: Container(
                                                             height: 88,
                                                             width: 88,
                                                             decoration: BoxDecoration(
                                                                 borderRadius: BorderRadius.circular(12)
                                                             ),
                                                             clipBehavior: Clip.antiAlias,
                                                             child: Image.network(
                                                               review.reviewImages.first,
                                                               fit: BoxFit.cover,
                                                             ),
                                                           ),
                                                         ),
                                                         Column(
                                                           mainAxisSize: MainAxisSize.min,
                                                           crossAxisAlignment:
                                                           CrossAxisAlignment.start,
                                                           children: [
                                                             Row(
                                                               children: [
                                                                 Row(
                                                                   children: [
                                                                     Text(
                                                                        point.pointName,
                                                                       style: FlutterFlowTheme.of(context)
                                                                           .bodyMedium
                                                                           .override(
                                                                         fontFamily:
                                                                         'PretendardSeries',
                                                                         fontSize: 16.0,
                                                                         letterSpacing: 0.0,
                                                                         fontWeight: FontWeight.w600,
                                                                         useGoogleFonts: GoogleFonts
                                                                             .asMap()
                                                                             .containsKey(
                                                                             'PretendardSeries'),
                                                                       ),
                                                                     ),
                                                                     PopupMenuButton(
                                                                       icon: Image.asset('assets/images/댓글메뉴.png'),
                                                                       itemBuilder: (context) => <PopupMenuEntry>[
                                                                         PopupMenuItem(
                                                                           child: ListTile(
                                                                             leading: Image.asset('assets/images/댓글메뉴.png'),
                                                                             title: Text('신고'),
                                                                           ),
                                                                         )
                                                                       ],
                                                                     ),
                                                                   ],
                                                                 ),
                                                                 /*
                                                                 PopupMenuButton(
                                                                   icon: Image.asset('assets/images/댓글메뉴.png'),
                                                                   itemBuilder: (context) => <PopupMenuEntry>[
                                                                     PopupMenuItem(
                                                                       child: ListTile(
                                                                         leading: Image.asset('assets/images/댓글메뉴.png'),
                                                                         title: Text('신고'),
                                                                       ),
                                                                     )
                                                                   ],
                                                                 ),
                                                                  */
                                                                 const SizedBox(
                                                                     width: 16
                                                                 ),
                                                                 /*
                                                           Row(
                                                             children: [
                                                               Visibility(
                                                                   visible: currentUserReference == containerUsersRecord.reference,
                                                                   child: Row(
                                                                     children: [
                                                                       InkWell(
                                                                         onTap: () async {
                                                                           await showModalBottomSheet(
                                                                             isScrollControlled: true,
                                                                             backgroundColor: Colors.transparent,
                                                                             enableDrag: false,
                                                                             context: context,
                                                                             builder: (context) {
                                                                               return WebViewAware(
                                                                                 child: GestureDetector(
                                                                                   onTap: () =>
                                                                                       FocusScope.of(context).unfocus(),
                                                                                   child: Padding(
                                                                                     padding:
                                                                                     MediaQuery.viewInsetsOf(context),
                                                                                     child: SizedBox(
                                                                                         height: 520.0,
                                                                                         child: ReviewEditView(
                                                                                           reviewRef: review.reference,
                                                                                         )
                                                                                     ),
                                                                                   ),
                                                                                 ),
                                                                               );
                                                                             },
                                                                           ).then((value) => safeSetState(() {}));
                                                                         },
                                                                         child: SizedBox(
                                                                           height: 24,
                                                                           child: Image.asset('assets/images/리뷰수정.png'),
                                                                         ),
                                                                       ),
                                                                       InkWell(
                                                                         onTap: (){
                                                                           review.deleteRecord(review.reference);
                                                                         },
                                                                         child:
                                                                         SizedBox(
                                                                           height: 24,
                                                                           child: Image.asset('assets/images/리뷰삭제.png'),
                                                                         ),
                                                                       ),
                                                                     ],
                                                                   )
                                                               ),
                                                               InkWell(
                                                                   onTap: () async {
                                                                     await showModalBottomSheet(
                                                                       isScrollControlled: true,
                                                                       backgroundColor: Colors.transparent,
                                                                       enableDrag: false,
                                                                       context: context,
                                                                       builder: (context) {
                                                                         return WebViewAware(
                                                                           child: GestureDetector(
                                                                             onTap: () =>
                                                                                 FocusScope.of(context).unfocus(),
                                                                             child: Padding(
                                                                               padding:
                                                                               MediaQuery.viewInsetsOf(context),
                                                                               child: SizedBox(
                                                                                 height: 520.0,
                                                                                 child: ReportBottomsheet(
                                                                                   reviewRef: review.reference,
                                                                                 ),
                                                                               ),
                                                                             ),
                                                                           ),
                                                                         );
                                                                       },
                                                                     ).then((value) => safeSetState(() {}));
                                                                   },
                                                                   child: SizedBox(
                                                                       height: 24,
                                                                       child: Image.asset('assets/images/낚시경보.png')
                                                                   )
                                                               )
                                                             ],
                                                           ),
                                                            */
                                                               ],
                                                             ),
                                                             Column(
                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                               children: [
                                                                 Text(
                                                                   review
                                                                       .reviewTitle,
                                                                   style: FlutterFlowTheme.of(context)
                                                                       .bodyMedium
                                                                       .override(
                                                                     fontFamily:
                                                                     'PretendardSeries',
                                                                     color: FlutterFlowTheme.of(context).primaryText,
                                                                     fontSize: 13.0,
                                                                     letterSpacing: 0.0,
                                                                     fontWeight: FontWeight.w400,
                                                                     useGoogleFonts: GoogleFonts
                                                                         .asMap()
                                                                         .containsKey(
                                                                         'PretendardSeries'),

                                                                   ),
                                                                   maxLines: 3,
                                                                 ),
                                                                 SizedBox(
                                                                   height: 4,
                                                                 ),
                                                                 Row(
                                                                   mainAxisSize: MainAxisSize.max,
                                                                   children: [
                                                                     Container(
                                                                       width: 32.0,
                                                                       height: 32.0,
                                                                       clipBehavior: Clip.antiAlias,
                                                                       decoration: const BoxDecoration(
                                                                         shape: BoxShape.circle,
                                                                       ),
                                                                       child: Image.network(
                                                                         functions.basicProfile(containerUsersRecord.photoUrl),
                                                                         fit: BoxFit.cover,
                                                                       ),
                                                                     ),
                                                                     const SizedBox(
                                                                       width: 12,
                                                                     ),
                                                                     Text(
                                                                       '${containerUsersRecord
                                                                           .displayName} | ${review
                                                                           .timestamp?.year} - ${review
                                                                           .timestamp?.month} - ${review
                                                                           .timestamp?.day}',
                                                                       style:
                                                                       FlutterFlowTheme.of(context)
                                                                           .bodyMedium
                                                                           .override(
                                                                         fontFamily:
                                                                         'PretendardSeries',
                                                                         color: FlutterFlowTheme.of(context).secondaryText,
                                                                         fontSize: 14,
                                                                         fontWeight: FontWeight.w400,
                                                                         letterSpacing: 0.0,
                                                                         useGoogleFonts:
                                                                         GoogleFonts
                                                                             .asMap()
                                                                             .containsKey(
                                                                             'PretendardSeries'),
                                                                       ),
                                                                     ),
                                                                   ],
                                                                 ),
                                                               ],
                                                             ),

                                                           ].divide(const SizedBox(height: 8.0)),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                 ),
                                               );
                                             }
                                         );
                                       }
                                   );
                                 })
                                 .addToEnd(
                                   InkWell(
                                     onTap: (){
                                       context.pushNamed('reviewList');
                                     },
                                     child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(24),
                                         border: Border(
                                           top: BorderSide(color: FlutterFlowTheme.of(context).secondaryText),
                                           left: BorderSide(color: FlutterFlowTheme.of(context).secondaryText),
                                           bottom: BorderSide(color: FlutterFlowTheme.of(context).secondaryText),
                                           right: BorderSide(color: FlutterFlowTheme.of(context).secondaryText)
                                         )
                                       ),
                                       child: Padding(
                                         padding: const EdgeInsets.fromLTRB(12, 8.0, 12, 8),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                           Text(
                                             '최근 조황과 리뷰',
                                             style: FlutterFlowTheme
                                                 .of(context)
                                                 .bodyMedium
                                                 .override(
                                               fontFamily:
                                               'PretendardSeries',
                                               color: FlutterFlowTheme.of(context).secondaryText,
                                               fontSize:
                                               14.0,
                                               letterSpacing:
                                               0.0,
                                               fontWeight:
                                               FontWeight
                                                   .w700,
                                               useGoogleFonts: GoogleFonts
                                                   .asMap()
                                                   .containsKey(
                                                   'PretendardSeries'),
                                             ),
                                           ),
                                             SizedBox(
                                               width: 4,
                                             ),
                                             Text(
                                                 '더보기',
                                               style: FlutterFlowTheme
                                                   .of(context)
                                                   .bodyMedium
                                                   .override(
                                                 fontFamily:
                                                 'PretendardSeries',
                                                 color: FlutterFlowTheme.of(context).secondaryText,
                                                 fontSize:
                                                 13.0,
                                                 letterSpacing:
                                                 0.0,
                                                 fontWeight:
                                                 FontWeight
                                                     .w500,
                                                 useGoogleFonts: GoogleFonts
                                                     .asMap()
                                                     .containsKey(
                                                     'PretendardSeries'),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   )
                                 ),
                               )
                             );
                            }
                          },
                      ),
                      Container(
                        //width: 100.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                          const AlignmentDirectional(-1.0, -1.0),
                                          child: Text(
                                            '포인트별 검색하기',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                              fontFamily:
                                              'PretendardSeries',
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w800,
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  'PretendardSeries'),
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/포인트별검색2.png',
                                          width: 24,
                                          height: 24,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 16.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0x00F4F6FF),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                pointButton(
                                                  text: '방파제',
                                                  secondText: '선착장',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'exploreMapSW');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/1007방파제.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                pointButton(
                                                  text: '낚시공원',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'fishingParkMap');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/1007낚시공원.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                pointButton(
                                                  text: '해변',
                                                  secondText: '갯바위',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'exploreMapOcean');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/1007해변.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                pointButton(
                                                  text: '해상펜션',
                                                  secondText: '좌대',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'exploreMap_stand');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/1007해상펜션.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                /*
                                                pointButton(
                                                  text: '체험',
                                                  secondText: '낚시배',
                                                  image: Image.asset(
                                                    'assets/images/낚시배.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                  ontap: () async{
                                                    context.pushNamed('exploreMapBoat');
                                                  },
                                                ),
                                                 */

                                                pointButton(
                                                  text: '낚시펜션',
                                                  secondText: '민박',
                                                  ontap: () async {
                                                    context.pushNamed(
                                                        'exploreMapFishingPension');
                                                  },
                                                  image: Image.asset(
                                                    'assets/images/1007민박.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ].divide(const SizedBox(height: 7.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 12.0, 12.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            '테마별 검색하기',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                            fontFamily:
                                            'PretendardSeries',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w800,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/전문가용낚시.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 12.0),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.12,
                                          //120, +MediaQuery.of(context).size.height*0.05,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0x00ffffff),
                                        ),
                                        alignment: Alignment.center,
                                        child: FutureBuilder(
                                            future: fetchThemes(),
                                            builder: (context, snapshot){
                                              if(snapshot.hasData){
                                                final themes = snapshot.data!.docs;
                                                print('theme length is ${themes.length}');
                                                return ListView.builder(
                                                  controller: ScrollController(initialScrollOffset: 0.0),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  //itemCount: min(themes.length, _themeLength),
                                                    itemCount: themes.length,
                                                    itemBuilder: (context, index){
                                                      final theme = TBPointThemeRecord.fromSnapshot(themes[index]);
                                                      return Padding(
                                                        padding: const EdgeInsets.only(right: 12.0),
                                                        child: InkWell(
                                                          onTap: () async{
                                                            context.pushNamed('pointExploreTheme', queryParameters: {
                                                              'themeRef' : serializeParam(theme.reference, ParamType.DocumentReference)
                                                            }.withoutNulls);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: MediaQuery
                                                                      .sizeOf(
                                                                      context)
                                                                      .width *
                                                                      0.12,
                                                                  width: MediaQuery
                                                                      .sizeOf(
                                                                      context)
                                                                      .width *
                                                                      0.14,
                                                                  child: Image.network(theme.themeImagePath),
                                                              ),
                                                              AutoSizeText(
                                                                theme.themeName ??'no themeName',
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'PretendardSeries',
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  useGoogleFonts: GoogleFonts
                                                                      .asMap()
                                                                      .containsKey(
                                                                      'PretendardSeries'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                );
                                              }
                                              if(snapshot.hasError){
                                                return Center(
                                                  child: Text(
                                                    '테마를 불러오지 못했습니다.',
                                                    style: FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                      fontFamily:
                                                      'PretendardSeries',
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w800,
                                                      useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                          .containsKey(
                                                          'PretendardSeries'),
                                                    ),
                                                  ),
                                                );
                                              }
                                              else{
                                                return Center(
                                                  child: Text(
                                                    '표시 지정된 테마가 없습니다.',
                                                    style: FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                      fontFamily:
                                                      'PretendardSeries',
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w800,
                                                      useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                          .containsKey(
                                                          'PretendardSeries'),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                        )
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '지금 잘잡히는 곳',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                            fontFamily:
                                            'PretendardSeries',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w800,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/1758787554180.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 12.0),
                                      child: Container(
                                          height: MediaQuery.of(context).size.height * 0.12,
                                          //120, +MediaQuery.of(context).size.height*0.05,
                                          width: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00ffffff),
                                          ),
                                          alignment: Alignment.center,
                                          child: FutureBuilder(
                                            future: fetchFishings(),
                                            builder: (context, snapshot){
                                              if(snapshot.hasData){
                                                final themes = snapshot.data!.docs;
                                                //print('theme length is ${themes.length}');
                                                return ListView.builder(
                                                    controller: ScrollController(initialScrollOffset: 0.0),
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    //itemCount: min(themes.length, _themeLength),
                                                    itemCount: themes.length,
                                                    itemBuilder: (context, index){
                                                      final fishing = TBniceFishingRecord.fromSnapshot(themes[index]);
                                                      return Padding(
                                                        padding: const EdgeInsets.only(right: 12.0),
                                                        child: InkWell(
                                                          onTap: () async{
                                                            context.pushNamed('pointExploreFishing', queryParameters: {
                                                              'fishingRef' : serializeParam(fishing.reference, ParamType.DocumentReference)
                                                            }.withoutNulls);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: MediaQuery
                                                                    .sizeOf(
                                                                    context)
                                                                    .width *
                                                                    0.12,
                                                                width: MediaQuery
                                                                    .sizeOf(
                                                                    context)
                                                                    .width *
                                                                    0.14,
                                                                child: Image.network(fishing.themeImagePath),
                                                              ),
                                                              AutoSizeText(
                                                                fishing.themeName ??'no themeName',
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme
                                                                    .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'PretendardSeries',
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  useGoogleFonts: GoogleFonts
                                                                      .asMap()
                                                                      .containsKey(
                                                                      'PretendardSeries'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                );
                                              }
                                              if(snapshot.hasError){
                                                return Center(
                                                  child: Text(
                                                    '테마를 불러오지 못했습니다.',
                                                    style: FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                      fontFamily:
                                                      'PretendardSeries',
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w800,
                                                      useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                          .containsKey(
                                                          'PretendardSeries'),
                                                    ),
                                                  ),
                                                );
                                              }
                                              else{
                                                return Center(
                                                  child: Text(
                                                    '표시 지정된 테마가 없습니다.',
                                                    style: FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .override(
                                                      fontFamily:
                                                      'PretendardSeries',
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w800,
                                                      useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                          .containsKey(
                                                          'PretendardSeries'),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            /*
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 36.0, 12.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                          const AlignmentDirectional(-1.0, -1.0),
                                          child: Text(
                                            '어종별 검색하기',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                              fontFamily:
                                              'PretendardSeries',
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w800,
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  'PretendardSeries'),
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/전문가용낚시.png',
                                          width: 30,
                                          height: 30,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 32.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0x00F4F6FF),
                                        ),
                                        alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Fishbutton(
                                              text: '돔',
                                              image: Image.asset('assets/images/감성돔_리사이즈.png'),
                                            ),
                                            Fishbutton(
                                              text: '두족류',
                                              image: Image.asset('assets/images/무늬오징어_리사이즈.png'),
                                            ),
                                            Fishbutton(
                                              text: '중상층',
                                              image: Image.asset('assets/images/전갱이_리사이즈.png'),
                                            ),
                                            Fishbutton(
                                              text: '원투낚시',
                                              image: Image.asset('assets/images/광어_리사이즈.png'),
                                            ),
                                          ].divide(const SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                             */

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 36),
                        child: PointAdsPageview(
                          data: FFAppState().pointAds,
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
                if(_isLoading)
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Opacity(
                      opacity: 0.6,
                      child: Container(
                        color: FlutterFlowTheme.of(context).primaryText,
                        child: const Center(
                          child: SizedBox(
                            height: 200,
                            child: PulsatingImage(),
                          ),
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
