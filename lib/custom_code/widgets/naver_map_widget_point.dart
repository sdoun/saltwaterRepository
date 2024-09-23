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

class NaverMapWidgetPoint extends StatefulWidget {
  const NaverMapWidgetPoint({
    super.key,
    this.width,
    this.height,
    this.initLat,
    this.initLng,
    this.pointList,
    required this.onClickMarker,
    this.basicIcon,
    required this.currentUser,
  });

  final double? width;
  final double? height;
  final double? initLat;
  final double? initLng;
  final List<TBPointRecord>? pointList;
  final Future Function(TBPointRecord markerDoc) onClickMarker;
  final FFUploadedFile? basicIcon;
  final DocumentReference currentUser;

  @override
  State<NaverMapWidgetPoint> createState() => _NaverMapWidgetPointState();
}

class _NaverMapWidgetPointState extends State<NaverMapWidgetPoint> {
  Set<NMarker> markerList = {};
  var pointLength;
  Completer<NaverMapController> mapControllerCompleter = Completer();
  @override
  void initState() {
    super.initState();
    pointLength = (widget.pointList ?? []).length;
    initializeNaverMap();
    markerList = _createMarkers();
  }

  Future<void> initializeNaverMap() async {
    await NaverMapSdk.instance.initialize(
      clientId: '0q1kaenxe1', // 클라이언트 ID 설정
      onAuthFailed: (e) => print("네이버맵 인증오류: $e"),
    );
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
        setState(() async {
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

  @override
  void didUpdateWidget(NaverMapWidgetPoint oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pointList != oldWidget.pointList) {
      pointLength = widget.pointList?.length ?? 0;
      updateMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        mapType: NMapType.hybrid,
        minZoom: 3,
        maxZoom: 16,
        extent: NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
        initialCameraPosition: NCameraPosition(
            target: NLatLng(widget.initLat ?? 37.0, widget.initLng ?? 127.0),
            zoom: 5,
            bearing: 0,
            tilt: 0),
        rotationGesturesEnable: false,
        tiltGesturesEnable: false,
      ),
      onMapReady: (NaverMapController controller) async {
        mapControllerCompleter.complete(controller);
        controller.clearOverlays();
        controller.addOverlayAll(markerList);
        print('맵 로딩됨');
      },
    );
  }
}
