import 'dart:async';

import 'serialization_util.dart';
import '../backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({super.key, required this.child});

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => const ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'home1': ParameterData.none(),
  'exploreMapSW': ParameterData.none(),
  'shoppingHome': ParameterData.none(),
  'loading1': ParameterData.none(),
  'login': ParameterData.none(),
  'googlemapErrorSolve': ParameterData.none(),
  'point_detailed': (data) async => ParameterData(
        allParams: {
          'pointRefSW': getParameter<DocumentReference>(data, 'pointRefSW'),
        },
      ),
  'productDetail': (data) async => ParameterData(
        allParams: {
          'product': getParameter<DocumentReference>(data, 'product'),
        },
      ),
  'carrotHome': ParameterData.none(),
  'carrotPost': (data) async => ParameterData(
        allParams: {
          'carrotPost': getParameter<DocumentReference>(data, 'carrotPost'),
        },
      ),
  'carrot_create': ParameterData.none(),
  'carrot_chatHome': ParameterData.none(),
  'carrot_chatRoom': (data) async => ParameterData(
        allParams: {
          'chatRoom': getParameter<DocumentReference>(data, 'chatRoom'),
        },
      ),
  'userPage': ParameterData.none(),
  'weatherMap': ParameterData.none(),
  'weatherDetailed': (data) async => ParameterData(
        allParams: {
          'weatherRef': getParameter<DocumentReference>(data, 'weatherRef'),
        },
      ),
  'fishingBusList': ParameterData.none(),
  'exploreMapOcean': ParameterData.none(),
  'like': ParameterData.none(),
  'Checkout1': ParameterData.none(),
  'userEdit': (data) async => ParameterData(
        allParams: {
          'userRef': getParameter<DocumentReference>(data, 'userRef'),
        },
      ),
  'exploreMapFishingPension': ParameterData.none(),
  'guideContentHome': ParameterData.none(),
  'guideContent': (data) async => ParameterData(
        allParams: {
          'content': getParameter<DocumentReference>(data, 'content'),
        },
      ),
  'fishingParkMap': ParameterData.none(),
  'carrot_liked': ParameterData.none(),
  'carrot_search': (data) async => ParameterData(
        allParams: {
          'searchText': getParameter<String>(data, 'searchText'),
        },
      ),
  'exploreMap_travel': ParameterData.none(),
  'carrot_searchResult': (data) async => ParameterData(
        allParams: {
          'searchText': getParameter<String>(data, 'searchText'),
        },
      ),
  'travel_list': ParameterData.none(),
  'shoppingGuide': ParameterData.none(),
  'fishingBusMap': ParameterData.none(),
  'exploreMap_stand': ParameterData.none(),
  'assetTest': ParameterData.none(),
  'chargeResult': ParameterData.none(),
  'chargePortone': ParameterData.none(),
  'menu': ParameterData.none(),
  'home_buttons': ParameterData.none(),
  'service_is_not_ready': ParameterData.none(),
  'point_detialed_unused': ParameterData.none(),
  'weatherMapCopy': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
