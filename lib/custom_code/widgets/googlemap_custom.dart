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

import 'package:google_maps_flutter/google_maps_flutter.dart'
    as google_maps_flutter;
import '/flutter_flow/lat_lng.dart' as latlng;
import 'dart:async';
export 'dart:async' show Completer;
export 'package:google_maps_flutter/google_maps_flutter.dart' hide LatLng;
export '/flutter_flow/lat_lng.dart' show LatLng;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class GooglemapCustom extends StatefulWidget {
  const GooglemapCustom({
    super.key,
    this.width,
    this.height,
    this.point,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.showLocation,
    required this.showCompass,
    required this.showMaptoolbar,
    required this.showTraffic,
    required this.allowZoom,
    required this.showZoomControls,
    required this.defaultZoom,
    this.onClickMarker,
    required this.currentUserRef,
  });

  final double? width;
  final double? height;
  final List<TBPointRecord>? point;
  final double centerLatitude;
  final double centerLongitude;
  final bool showLocation;
  final bool showCompass;
  final bool showMaptoolbar;
  final bool showTraffic;
  final bool allowZoom;
  final bool showZoomControls;
  final double defaultZoom;
  final Future Function(TBPointRecord? pointData)? onClickMarker;
  final DocumentReference currentUserRef;

  @override
  State<GooglemapCustom> createState() => _GooglemapCustomState();
}

class _GooglemapCustomState extends State<GooglemapCustom> {
  Completer<google_maps_flutter.GoogleMapController> _controller = Completer();
  Map<String, google_maps_flutter.BitmapDescriptor> _customIcons = {};
  Set<google_maps_flutter.Marker> _markers = {};

  late google_maps_flutter.LatLng _center;

  @override
  void initState() {
    super.initState();
    _center = google_maps_flutter.LatLng(
        widget.centerLatitude, widget.centerLongitude);
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _loadMarkerIcons();
    }
  }

  @override
  void didUpdateWidget(GooglemapCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.point != oldWidget.point ||
        widget.centerLatitude != oldWidget.centerLatitude ||
        widget.centerLongitude != oldWidget.centerLongitude ||
        widget.currentUserRef != oldWidget.currentUserRef) {
      _loadMarkerIcons();
    }
  }

  Future<void> _loadMarkerIcons() async {
    Set<String?> uniqueIconPaths = widget.point?.map((data) {
          if (data.pointNotfree) {
            if (data.pointLikedBy.contains(widget.currentUserRef)) {
              return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%95%84%EC%9D%B4%EC%BD%98%2F%EC%B0%9C.png?alt=media&token=6b08a8b2-7113-4106-97a2-497bacc6e89a';
            }
            return 'https://picsum.photos/100/100';
          } else {
            if (data.pointLikedBy.contains(widget.currentUserRef)) {
              return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%95%84%EC%9D%B4%EC%BD%98%2F%EC%B0%9C.png?alt=media&token=6b08a8b2-7113-4106-97a2-497bacc6e89a';
            } else
              return 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%95%84%EC%9D%B4%EC%BD%98%2F%EC%A3%BC%EB%B3%80%EC%9D%B8%EA%B7%BC%EB%82%9A%EC%8B%9C%ED%84%B0.png?alt=media&token=89edf507-6340-496c-9de6-13e482e5c98b';
          }

          return data.pointImagePath;
        }).toSet() ??
        {};

    for (String? path in uniqueIconPaths) {
      if (path != null && path.isNotEmpty) {
        if (path.contains("https")) {
          Uint8List? imageData = await loadNetworkImage(path);
          if (imageData != null) {
            google_maps_flutter.BitmapDescriptor descriptor =
                await google_maps_flutter.BitmapDescriptor.fromBytes(imageData);
            _customIcons[path] = descriptor;
          }
        } else {
          google_maps_flutter.BitmapDescriptor descriptor =
              await google_maps_flutter.BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.5),
            "assets/images/$path",
          );
          _customIcons[path] = descriptor;
        }
      }
    }
    _updateMarkers();
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(ImageStreamListener(
        (ImageInfo info, bool _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void _updateMarkers() {
    setState(() {
      _markers.clear();
      _markers = _createMarkers();
    });
  }

  void _onMapCreated(google_maps_flutter.GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<google_maps_flutter.Marker> _createMarkers() {
    var tmp = <google_maps_flutter.Marker>{};
    for (int i = 0; i < (widget.point ?? []).length; i++) {
      var place = widget.point?[i];
      final latlng.LatLng coordinates = latlng.LatLng(
          place?.pointLatitude ?? 0.0, place?.pointLongitude ?? 0.0);
      final google_maps_flutter.LatLng googleMapsLatLng =
          google_maps_flutter.LatLng(
              coordinates.latitude, coordinates.longitude);

      String iconPath;
      if (place?.pointNotfree == true) {
        iconPath = 'https://picsum.photos/100/100';
      } else if (place?.pointLikedBy is List &&
          place?.pointLikedBy.contains(widget.currentUserRef) == true) {
        iconPath = 'https://picsum.photos/150/100';
      } else {
        iconPath = '';
      }

      google_maps_flutter.BitmapDescriptor icon = _customIcons[iconPath] ??
          google_maps_flutter.BitmapDescriptor.defaultMarker;

      final google_maps_flutter.Marker marker = google_maps_flutter.Marker(
        markerId:
            google_maps_flutter.MarkerId('${place?.pointName ?? "Marker"}_$i'),
        position: googleMapsLatLng,
        icon: icon,
        infoWindow: google_maps_flutter.InfoWindow(
            title: place?.pointName, snippet: place?.pointAddress),
        onTap: () async {
          final callback = widget.onClickMarker;
          if (callback != null) {
            await callback(place);
          }
        },
      );

      tmp.add(marker);
    }
    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    return google_maps_flutter.GoogleMap(
      onMapCreated: _onMapCreated,
      zoomGesturesEnabled: widget.allowZoom,
      zoomControlsEnabled: widget.showZoomControls,
      myLocationEnabled: widget.showLocation,
      compassEnabled: widget.showCompass,
      mapToolbarEnabled: widget.showMaptoolbar,
      trafficEnabled: widget.showTraffic,
      initialCameraPosition: google_maps_flutter.CameraPosition(
        target: _center,
        zoom: widget.defaultZoom,
      ),
      markers: _markers,
    );
  }
}
