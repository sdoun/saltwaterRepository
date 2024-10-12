import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/nav/serialization_util.dart';

class PointAdsPageview extends StatefulWidget {
  const PointAdsPageview({super.key});

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
            height: MediaQuery.of(context).size.height * 0.20,
            child:  Column(
              children: [
                Image.network(
                  data['ads_image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black,
                      child: const Center(child: Text('Image load failed')),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(
                  height: 32,
                )
              ]
            )
          )
        ),
      );
    } else {
      return Container(
        color: Colors.cyan,
        child: const Center(child: Text('광고 이미지 없음')),
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

    loadData();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (adsController.hasClients) {
        int currentPage = adsController.page!.toInt();
        int nextPage = (currentPage + 1) % _pages.length;
        adsController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
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
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.32,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: adsController,
              children: _pages,
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
        ),
      );
    }
  }
}
