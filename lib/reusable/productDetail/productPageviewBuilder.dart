import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class Productpageviewbuilder extends StatefulWidget {
  const Productpageviewbuilder({super.key, required this.productImages});

  final List<String> productImages;

  @override
  State<Productpageviewbuilder> createState() => _ProductpageviewbuilderState();
}

class _ProductpageviewbuilderState extends State<Productpageviewbuilder> {

  List<Widget> _pages = [

  ];
  Timer? timer;
  PageController productImageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    productImageController = PageController(initialPage: 0);
    print('productImages length is ${widget.productImages.length}');
    print('first page is ${widget.productImages[0]}');

    // 타이머 초기화를 initState에서 수행
    timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (productImageController.hasClients) {
        int currentPage = productImageController.page?.toInt() ?? 0;
        int nextPage = (currentPage + 1) % widget.productImages.length;
        productImageController.animateToPage(
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
    productImageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                0.0, 0.0, 0.0, 40.0),
            child: PageView.builder(
              itemCount: widget.productImages.length,
              controller: productImageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                var item = widget.productImages[index];

                return Image.network(item);
              },
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  16.0, 0.0, 0.0, 16.0),
              child: SmoothPageIndicator(
                controller:
                  productImageController,
                count: widget.productImages.length,
                axisDirection: Axis.horizontal,
                onDotClicked: (i) async {
                  await productImageController
                      .animateToPage(
                    i,
                    duration:
                    const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  safeSetState(() {});
                },
                effect: const ExpandingDotsEffect(
                  expansionFactor: 3.0,
                  spacing: 8.0,
                  radius: 16.0,
                  dotWidth: 16.0,
                  dotHeight: 8.0,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blueAccent,
                  paintStyle: PaintingStyle.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
