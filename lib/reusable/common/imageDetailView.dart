import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salt_water_beta_ver1/backend/api_requests/api_calls.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:photo_view/photo_view.dart';

class Imagedetailview extends StatefulWidget {
  const Imagedetailview({super.key, required this.imageList});
  final List<String>? imageList;

  @override
  State<Imagedetailview> createState() => _ImagedetailviewState();
}

class _ImagedetailviewState extends State<Imagedetailview> {
  final PageController pageController = PageController(initialPage: 0);

  int nDown = 0;
  int nUp = 0;

  bool isEnableScroll = true;

  @override
  Widget build(BuildContext context) {
    final imageList = widget.imageList!.toList();
    var onDownEVT = (PointerDownEvent e){
      nDown = e.pointer;
      if(nDown - nUp > 1){
        setState(() {
          isEnableScroll = false;
        });
      }
      else{
        setState(() {
          isEnableScroll = true;
        });
      }
    };
    var onUpEVT = (PointerUpEvent e){
      nUp = e.pointer;
      if(nDown - nUp < 1){
        setState(() {
          isEnableScroll = true;
        });
      }
      else{
        setState(() {
          isEnableScroll = false;
        });
      }
    };
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
            children: [
              Expanded(  // PageView를 Expanded로 감싸 남은 공간을 모두 차지하도록 함
                child: GestureDetector(
                  onTapDown: (e){
                    onDownEVT(e as PointerDownEvent);
                  },
                  onTapUp: (e){
                    onUpEVT(e as PointerUpEvent);
                  },
                  child: PageView.builder(
                    physics: isEnableScroll ? const PageScrollPhysics() : const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemCount: imageList.isEmpty ? 1 : imageList.length,  // 리스트가 비어있을 때도 최소 1개의 아이템을 표시
                    itemBuilder: (context, index) {
                      if (imageList.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,  // 세로 중앙 정렬
                          children: [
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%88%98%EC%A0%95%ED%8E%98%EC%9D%B4%EC%A7%80%2F%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%9D%B4%EB%AF%B8%EC%A7%80%EC%97%86%EC%9D%8C.png?alt=media&token=b357c611-3df0-4134-bf83-6d72fa96b82e',
                              fit: BoxFit.contain,  // 이미지가 잘리지 않도록 contain으로 변경
                              height: 200,  // 이미지 높이 제한
                            ),
                            const SizedBox(height: 20),  // 이미지와 텍스트 사이 간격
                             const Text(
                              'image list is empty',
                              style: TextStyle(color: Colors.white, fontSize: 18),  // 텍스트 스타일 지정
                            ),
                          ],
                        );
                      } else {
                        return //PhotoView(imageProvider: NetworkImage(imageList[index]));
                          Listener(
                            onPointerDown: onDownEVT,
                            onPointerUp: onUpEVT,
                            child: InteractiveViewer(child: Image.network(
                              imageList[index],
                              fit: BoxFit.contain,  // 이미지가 잘리지 않도록 contain으로 변경
                              errorBuilder: (context, error, stackTrace) {
                                print('Image error: $error');
                                return Center(  // 에러 메시지를 중앙에 표시
                                  child: Text(
                                    'Image load failed: $error',
                                    style: TextStyle(color: Colors.white),  // 텍스트 색상 지정
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            )),
                          );
                      /*

                       */

                      }
                    },
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: imageList.isEmpty ? 1 : imageList.length,  // 리스트가 비어있을 때도 인디케이터 표시
                effect: const WormEffect(activeDotColor: Colors.white),  // 인디케이터 스타일 지정
              ),
              const SizedBox(height: 20),  // 인디케이터 아래 여백
            ],
          ),
        )
    );
  }
}