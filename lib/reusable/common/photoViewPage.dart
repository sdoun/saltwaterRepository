import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class PhotoViewPage extends StatefulWidget {
  PhotoViewPage({super.key, required this.imageList, required this.currentIndex});

  final List<String >imageList;
  final int currentIndex;

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {

  int currentPhotoIndex = 0;
  late PageController _pageController;

  @override
  void initState(){
    currentPhotoIndex = widget.currentIndex;
    _pageController = PageController(initialPage: widget.currentIndex);
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: context.pop,
            icon: Icon(
              Icons.close,
              color: FlutterFlowTheme.of(context).primaryBackground,
            )
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 4,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: PhotoViewGallery.builder(
                    pageController: _pageController,
                    itemCount: widget.imageList.length,
                    onPageChanged: (index){
                      setState(() {
                        currentPhotoIndex = index;
                      });
                    },
                    builder: (context, index){
                      return PhotoViewGalleryPageOptions(
                          maxScale: PhotoViewComputedScale.covered * 3,
                          minScale: PhotoViewComputedScale.contained,
                          imageProvider: NetworkImage(widget.imageList[index])
                      );
                    },loadingBuilder: (context, event){
                    return Center(
                      child: Text(event.toString()),
                    );
                  },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 44,
                child: Column(
                  children: [
                    SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.imageList.length,
                      effect: const WormEffect(activeDotColor: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
