import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:salt_water_beta_ver1/reusable/common/pulsatingImage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/nav/serialization_util.dart';

class PointAdsPageview extends StatefulWidget {
  PointAdsPageview({super.key, this.loadingAlert, this.data});

  final loadingAlert;
  QuerySnapshot<Object?>? data;

  @override
  State<PointAdsPageview> createState() => _PointAdsPageviewState();
}

class _PointAdsPageviewState extends State<PointAdsPageview> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  static const int _pageSize = 5;
  String? _error;

  List<Widget> _pages = [

  ];
  Timer? timer;
  PageController adsController = PageController(
    initialPage: 0,
  );

  Widget buildPages(Map<String, dynamic>? data) {
    print("buildPages called with data: $data");
    if (data != null && data['ads_image'] != null) {
      return GestureDetector(
        onTap: () async {
          print('pointRef is : ${data['ads_pointRef']}');
          if (data['ads_pointRef'] != null) {
            await context.pushNamed(
              'point_detailed',
              queryParameters: {
                'pointRefSW': serializeParam(
                  data['ads_pointRef'],
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );
          }
          else{
            return;
          }
        },
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: 16 / 9, // 이미지 비율 설정 (예: 16:9)
                child: Image.network(
                  data['ads_image'] ?? 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%88%98%EC%A0%95%ED%8E%98%EC%9D%B4%EC%A7%80%2F%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%9D%B4%EB%AF%B8%EC%A7%80%EC%97%86%EC%9D%8C.png?alt=media&token=b357c611-3df0-4134-bf83-6d72fa96b82e',
                  fit: BoxFit.contain, // cover 대신 contain 사용
                  errorBuilder: (context, error, stackTrace) {
                    print('Image error: $error');
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: Text('이미지를 불러올 수 없습니다')),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: PulsatingImage(),
                    );
                  },
                ),
              ),
            )
        ),
      );
    } else {
      return Center(
        child: Container(
          color: Colors.cyan,
          child: const Center(child: Text('광고 이미지 없음')),
        ),
      );
    }
  }

  Future<void> loadData() async {
    if (_pages.isNotEmpty) return;
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {

      Query query = _firestore.collection('TB_pointAds').orderBy('timestamp', descending: true).limit(_pageSize);

      QuerySnapshot querySnapshot = await query.get();
      print('Query completed. Document count: ${querySnapshot.docs.length}');

      setState(() {

        if (querySnapshot.docs.isNotEmpty) {
          print('Document query is not empty, Data Counted ${querySnapshot.docs.length}');
          _pages = querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return buildPages(data);
          }).toList();
          print("_pages updated, length: ${_pages.length}");
          _isLoading = false;
        }
        else{
          _pages = querySnapshot.docs.map((doc) => buildPages(doc.data() as Map<String, dynamic>)).toList();
          print('Document query is empty');
          _isLoading = false;
        }

      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if(FFAppState().pointAds == null){
      loadData();
    }
    else{
      _pages = FFAppState().pointAds!.docs.map((doc){
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return buildPages(data);
      }).toList();
    }
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {

        int currentPage = adsController.page!.toInt();
        int nextPage = (currentPage + 1) % _pages.length;
        print(nextPage);
        adsController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        setState(() {});

    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
    print('Building PageView, _pages length: ${_pages.length}, _isLoading is $_isLoading');
    if (_isLoading == true) {
      print('Query is waiting');
      return const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      return Center(child: Text('Error: $_error'));
    } else {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * (9/16),
                child: PageView(
                  controller: adsController,
                  children: _pages,
                ),
              ),
              const SizedBox(
                height: 36,
              )
            ],
          ),
          SmoothPageIndicator(
            controller: adsController,
            count: _pages.length,
            axisDirection: Axis.horizontal,
            effect: ExpandingDotsEffect(
              dotColor: FlutterFlowTheme.of(context).secondaryBackground,
              activeDotColor: FlutterFlowTheme.of(context).primary,
            ),
            onDotClicked: (i) async {
              await adsController.animateToPage(
                i,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
              safeSetState(() {});
            },
          ),
        ],
      );
    }
  }
}
