// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_naver_map/flutter_naver_map.dart';
import '/flutter_flow/lat_lng.dart' as latlng;
import 'dart:async';
import 'package:salt_water_beta_ver1/reusable/pointExplore/mapSelectButton.dart';
import 'package:geolocator/geolocator.dart';

class NaverMapWidgetPointCopy extends StatefulWidget {
  const NaverMapWidgetPointCopy({
    super.key,
    this.width,
    this.height,
    this.initLat,
    this.initLng,
    this.pointList,
    required this.onClickMarker,
    this.basicIcon,
    required this.currentUser,
    required this.mapType,
  });

  final double? width;
  final double? height;
  final double? initLat;
  final double? initLng;
  final List<TBPointRecord>? pointList;
  final Future Function(TBPointRecord markerDoc) onClickMarker;
  final FFUploadedFile? basicIcon;
  final DocumentReference currentUser;
  final String mapType;

  @override
  State<NaverMapWidgetPointCopy> createState() =>
      _NaverMapWidgetPointCopyState();
}

class _NaverMapWidgetPointCopyState extends State<NaverMapWidgetPointCopy> {
  int dummy = 1;
  Set<NMarker> markerList = {};
  var pointLength;
  Completer<NaverMapController> mapControllerCompleter = Completer();


  double? mapCenterLat;
  double? mapCenterLng;

  @override
  void initState() {
    super.initState();
    pointLength = (widget.pointList ?? []).length;
    initializeNaverMap();
    markerList = _createMarkers();
    setMapCenter();
  }

  Future<void> initializeNaverMap() async {
    await NaverMapSdk.instance.initialize(
      clientId: '0q1kaenxe1', // 클라이언트 ID 설정
      onAuthFailed: (e) => print("네이버맵 인증오류: $e"),
    );
  }

  void setMapCenter() async{
      getGeoData();
      setState(() {
        mapCenterLat = mapCenterLat ?? widget.initLat ?? 34.9;
        mapCenterLng = mapCenterLng ?? widget.initLng ?? 128.5;
      });
  }
  Future<void> moveCamera() async{
    final cameraUpdate = NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(mapCenterLat!, mapCenterLng!),
        zoom: 14
    );
    if(mapControllerCompleter.isCompleted){
      final controller = await mapControllerCompleter.future;
      controller.updateCamera(cameraUpdate);
    }
  }

  getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }

    Position position =  await Geolocator.getCurrentPosition();
    setState(() {
      mapCenterLat = position.latitude;
      mapCenterLng = position.longitude;
    });
  }

/* 애셋 이미지로 마커 생성 테스트

  NMarker customMarker() {
    NMarker marker = NMarker(
      id: 'test',
      position: NLatLng(35, 125),
    );
    setState(() async {
      NOverlayImage image =
          await NOverlayImage.fromAssetImage('assets/images/a418y_.png');
      marker.setIcon(image);
    });
    return marker;
  }
  */

  NOverlayImage createMarkerIcon(NMarker marker) {
    final pointDoc = widget.pointList![int.parse(marker.info.id)];
    final userRef = widget.currentUser;
    NOverlayImage image;
    if (pointDoc.pointNotfree) {
      if (pointDoc.pointLikedBy.contains(userRef)) {
        return NOverlayImage.fromAssetImage(
            'assets/images/KakaoTalk_20240807_204700306_01.png');
      } else {
        return NOverlayImage.fromAssetImage(
            'assets/images/KakaoTalk_20240807_204700306.png');
      }
    } else {
      if (pointDoc.pointLikedBy.contains(userRef)) {
        return NOverlayImage.fromAssetImage(
            'assets/images/KakaoTalk_20240807_204700306_01.png');
      } else {
        return NOverlayImage.fromAssetImage(
            'assets/images/KakaoTalk_20240807_204700306_02.png');
      }
    }
  }

  Set<NMarker> _createMarkers() {
    if (widget.pointList != null) {
      for (int i = 0; i < pointLength; i++) {
        var place = widget.pointList?[i];

        NLatLng _position =
            NLatLng(place?.pointLatitude ?? 0.0, place?.pointLongitude ?? 0.0);
        NMarker marker = NMarker(
          id: i.toString(),
          position: _position,
          size: const Size(24, 28),
        );
        marker.setOnTapListener((NMarker marker) {
          print("마커가 터치되었습니다. id: ${marker.info.id}");
          widget.onClickMarker
              .call(widget.pointList![int.parse(marker.info.id)]);
        });
        setState((){
          NOverlayImage image;
          image = createMarkerIcon(marker);
          marker.setIcon(image);
        });
        markerList.add(marker);
      }
    }

    return markerList;
  }

  void updateMarkers() {
    setState(() {
      markerList.clear();
      markerList = _createMarkers();

      _updateMapOverlays();
    });
  }

  Future<void> _updateMapOverlays() async {
    if (mapControllerCompleter.isCompleted) {
      final controller = await mapControllerCompleter.future;
      controller.clearOverlays();
      controller.addOverlayAll(markerList);
    }
  }



  NMapType mapTypeSelect(String mapTypeString) {
    NMapType selected = switch (mapTypeString) {
      '일반' => NMapType.basic,
      '위성' => NMapType.satellite,
      '하이브리드' => NMapType.hybrid,
      // TODO: Handle this case.
      String() => NMapType.satellite,
    };
    return selected;
  }

  @override
  void didUpdateWidget(NaverMapWidgetPointCopy oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.mapType != oldWidget.mapType){
      setState(() {
      });
    }
    if (widget.pointList != oldWidget.pointList) {
      pointLength = widget.pointList?.length ?? 0;
      updateMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        NaverMap(
          forceGesture: true,
          options: NaverMapViewOptions(
            mapType: mapTypeSelect(widget.mapType),
            minZoom: 5,
            maxZoom: 21,
            extent: NLatLngBounds(
              southWest: NLatLng(34.43, 125.37),
              northEast: NLatLng(40.35, 132.0),
            ),
            initialCameraPosition: NCameraPosition(
                target: NLatLng(mapCenterLat!, mapCenterLng!),
                zoom: 8.0,
                bearing: 0,
                tilt: 0),
            rotationGesturesEnable: false,
            tiltGesturesEnable: false,
            scrollGesturesEnable: true,
            zoomGesturesEnable: true,

          ),
          onMapReady: (NaverMapController controller) async {
            mapControllerCompleter.complete(controller);
            controller.clearOverlays();
            controller.addOverlayAll(markerList);
            print('맵 로딩됨');
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.08,
                height: MediaQuery.sizeOf(context).width *   0.08,
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    setMapCenter();
                  });
                  moveCamera();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  height: MediaQuery.sizeOf(context).width *   0.08,
                  child: Image.asset('assets/images/내위치.png')
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
