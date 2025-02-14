import 'package:flutter/material.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_theme.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

class Homeadspageview extends StatefulWidget {
  const Homeadspageview({super.key, });


  @override
  State<Homeadspageview> createState() => _HomeadspageviewState();
}

class _HomeadspageviewState extends State<Homeadspageview> {

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
  // 상품 이미지 페이지뷰 컨트롤러 설정하던 중이었음. productImages 호출 성공함

  Widget buildPages(Map<String, dynamic>? data) {
    if (data != null && data['ads_image'] != null) {
      return SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.25,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                if (data['productRef'] != null) {
                  await context.pushNamed(
                    'productDetail',
                    queryParameters: {
                      'product': serializeParam(
                        data['productRef'],
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                }
                else{
                  return;
                }
              },
              child: Image.network(
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
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.cyan,
        child: const Center(child: Text('No image available')),
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

      Query query = _firestore.collection('TB_productAds').orderBy('timestamp', descending: true).limit(_pageSize);

      QuerySnapshot querySnapshot = await query.get();


      setState(() {

        if (querySnapshot.docs.isNotEmpty) {
          _pages = querySnapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return buildPages(data);
          }).toList();

          _isLoading = false;
        }
        else{
            _pages = querySnapshot.docs.map((doc) => buildPages(doc.data() as Map<String, dynamic>)).toList();
            _isLoading = false;
        }

      });
    } catch (e) {
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
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
    if (_isLoading == true) {
      return const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      return Center(child: Text('Error: $_error'));
    } else {
      return SizedBox(
        height: 200,
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
