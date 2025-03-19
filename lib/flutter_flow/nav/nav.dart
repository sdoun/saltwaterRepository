import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_water_beta_ver1/pages/home1/home_searchResult.dart';
import 'package:salt_water_beta_ver1/pages/manager_chat/chat_room.dart';
import 'package:salt_water_beta_ver1/pages/point_explore_sum/point_detailed/storeBoat_detailed.dart';
import 'package:salt_water_beta_ver1/pages/point_explore_sum/point_explore_boat/explore_map_boat.dart';
import 'package:salt_water_beta_ver1/pages/point_explore_sum/point_explore_store/explore_map_store.dart';
import 'package:salt_water_beta_ver1/pages/point_explore_sum/point_explore_theme/point_explore_theme.dart';
import 'package:salt_water_beta_ver1/reusable/common/imageDetailView.dart';
import 'package:salt_water_beta_ver1/reusable/common/photoViewPage.dart';
import '../../pages/home1/home_searchPage.dart';
import '../../pages/weather_sum/weather_detailed/weather_detailed_additional_widget.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier, FirebaseAnalyticsObserver observer) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const Home1Widget() : const LoginWidget(),
      routes: [
        FFRoute(name: 'photoViewPage', path: '/photoViewPage',
            builder: (context, params) => PhotoViewPage(imageList: params.getParam<String>('imageList', ParamType.String, isList: true),
                currentIndex: params.getParam('currentIndex', ParamType.int))),
        FFRoute(name: 'exploreMapStore', path: '/exploreMapStore', builder: (context, params) => ExploreMapStore()),
        FFRoute(name: 'exploreMapBoat', path: '/exploreMapBoat', builder: (context, params) => ExploreMapBoat()),
        FFRoute(
          name: 'pointExploreTheme',
          path: '/pointExploreTheme',
          builder: (context, params) => PointExploreTheme(themeRef: params.getParam('themeRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['TB_pointTheme']
          ))
        ),
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const Home1Widget() : const LoginWidget(),
        ),
        FFRoute(
          name: 'home1',
          path: '/home1',
          builder: (context, params) => const Home1Widget(),
        ),
        FFRoute(
          name: 'exploreMapSW',
          path: '/exploreMapSW',
          builder: (context, params) => const ExploreMapSWWidget(),
        ),
        FFRoute(
          name: 'shoppingHome',
          path: '/shoppingHome',
          builder: (context, params) => const ShoppingHomeWidget(),
        ),
        FFRoute(
          name: 'loading1',
          path: '/loading1',
          builder: (context, params) => const Loading1Widget(),
        ),
        FFRoute(
          name: 'login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'imageDetailView',
          path: '/imageDetailView',
          builder: (context, params) => Imagedetailview(imageList: params.getParam<String>('imageList', ParamType.String, isList: true)),
        ),
        FFRoute(
          name: 'googlemapErrorSolve',
          path: '/googlemapErrorSolve',
          builder: (context, params) => const GooglemapErrorSolveWidget(),
        ),
        FFRoute(
          name: 'point_detailed',
          path: '/pointDetailed',
          builder: (context, params) => PointDetailedWidget(
            pointRefSW: params.getParam(
              'pointRefSW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['TB_point'],
            ),
          ),
        ),
        FFRoute(
          name: 'boat_detailed',
          path: '/boatDetailed',
          builder: (context, params) => StoreboatDetailed(
            pointRefSW: params.getParam(
              'pointRefSW',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['TB_point'],
            ),
          ),
        ),
        FFRoute(
          name: 'productDetail',
          path: '/productDetail',
          builder: (context, params) => ProductDetailWidget(
            product: params.getParam(
              'product',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['TB_shoppingProduct'],
            ),
          ),
        ),
        FFRoute(
          name: 'managerChatRoom',
          path: '/managerChatRoom',
          builder: (context, params) {
            print('builder work');
            return const ChatRoom();
          },
        ),
        FFRoute(
          name: 'userPage',
          path: '/userPage',
          builder: (context, params) => const UserPageWidget(),
        ),
        FFRoute(
          name: 'homeSearchPage',
          path: '/homeSearchPage',
          builder: (context, params) => HomeSearchpage(

          ),
        ),
        FFRoute(
          name: 'homeSearchResult',
          path: '/homeSearchResult',
          builder: (context, params) => HomeSearchresult(
            searchText: params.getParam('searchText', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'weatherMap',
          path: '/weatherMap',
          builder: (context, params) => const WeatherMapWidget(),
        ),
        FFRoute(
          name: 'weatherDetailed',
          path: '/weatherDetailed',
          builder: (context, params) => WeatherDetailedWidget(
            weatherRef: params.getParam(
              'weatherRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['TB_weatherPoint'],
            ),
          ),
        ),
        FFRoute(
          name: 'weatherDetailedAdditional',
          path: '/weatherDetailedAdditional',
          builder: (context, params) => WeatherDetailedAdditional(
            weatherRef: params.getParam(
              'weatherRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['TB_weatherPoint'],
            ),
          ),
        ),
        FFRoute(
          name: 'fishingBusList',
          path: '/fishingBusList',
          builder: (context, params) => const FishingBusListWidget(),
        ),
        FFRoute(
          name: 'exploreMapOcean',
          path: '/exploreMapOcean',
          builder: (context, params) => const ExploreMapOceanWidget(),
        ),
        FFRoute(
          name: 'like',
          path: '/like',
          builder: (context, params) => const LikeWidget(),
        ),
        FFRoute(
          name: 'Checkout1',
          path: '/checkout1',
          builder: (context, params) => const Checkout1Widget(),
        ),
        FFRoute(
          name: 'userEdit',
          path: '/userEdit',
          builder: (context, params) => UserEditWidget(
            userRef: params.getParam(
              'userRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['users'],
            ),
          ),
        ),
        FFRoute(
          name: 'exploreMapFishingPension',
          path: '/exploreMapFishingPension',
          builder: (context, params) => const ExploreMapFishingPensionWidget(),
        ),
        FFRoute(
          name: 'guideContentHome',
          path: '/guideContentHome',
          builder: (context, params) => const GuideContentHomeWidget(),
        ),
        FFRoute(
          name: 'guideContent',
          path: '/guideContent',
          builder: (context, params) => GuideContentWidget(
            content: params.getParam(
              'content',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['TB_guideContent'],
            ),
          ),
        ),
        FFRoute(
          name: 'fishingParkMap',
          path: '/fishingParkMap',
          builder: (context, params) => const FishingParkMapWidget(),
        ),

        FFRoute(
          name: 'exploreMap_travel',
          path: '/exploreMapTravel',
          builder: (context, params) => const ExploreMapTravelWidget(),
        ),
        FFRoute(
          name: 'travel_list',
          path: '/travelList',
          builder: (context, params) => const TravelListWidget(),
        ),
        FFRoute(
          name: 'shoppingGuide',
          path: '/shoppingGuide',
          builder: (context, params) => const ShoppingGuideWidget(),
        ),
        FFRoute(
          name: 'fishingBusMap',
          path: '/fishingBusMap',
          builder: (context, params) => const FishingBusMapWidget(),
        ),
        FFRoute(
          name: 'exploreMap_stand',
          path: '/exploreMapStand',
          builder: (context, params) => const ExploreMapStandWidget(),
        ),
        FFRoute(
          name: 'assetTest',
          path: '/assetTest',
          builder: (context, params) => const AssetTestWidget(),
        ),
        FFRoute(
          name: 'chargeResult',
          path: '/chargeResult',
          builder: (context, params) => const ChargeResultWidget(),
        ),
        FFRoute(
          name: 'chargePortone',
          path: '/chargePortone',
          builder: (context, params) => const ChargePortoneWidget(),
        ),
        FFRoute(
          name: 'menu',
          path: '/menu',
          builder: (context, params) => const MenuWidget(),
        ),
        FFRoute(
          name: 'home_buttons',
          path: '/homeButtons',
          builder: (context, params) => const HomeButtonsWidget(),
        ),
        FFRoute(
          name: 'service_is_not_ready',
          path: '/serviceIsNotReady',
          builder: (context, params) => const ServiceIsNotReadyWidget(),
        ),
        FFRoute(
          name: 'point_detialed_unused',
          path: '/pointDetialedUnused',
          builder: (context, params) => const PointDetialedUnusedWidget(),
        ),
        FFRoute(
          name: 'weatherMapCopy',
          path: '/weatherMapCopy',
          builder: (context, params) => const WeatherMapCopyWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver, observer],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
    name: name,
    path: path,
    redirect: (context, state) {
      if (appStateNotifier.shouldRedirect) {
        final redirectLocation = appStateNotifier.getRedirectLocation();
        appStateNotifier.clearRedirectLocation();
        return redirectLocation;
      }

      if (requireAuth && !appStateNotifier.loggedIn) {
        appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
        return '/login';
      }
      return null;
    },
    pageBuilder: (context, state) {
      fixStatusBarOniOS16AndBelow(context);
      final ffParams = FFParameters(state, asyncParams);
      final page = ffParams.hasFutures
          ? FutureBuilder(
        future: ffParams.completeFutures(),
        builder: (context, _) => builder(context, ffParams),
      )
          : builder(context, ffParams);
      final child = appStateNotifier.loading
          ? Container(
        color: Colors.white,
        child: SizedBox(
          height: 300,
          child: Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.fitWidth,
          ),
        )
      )
          : PushNotificationsHandler(child: page);

      final transitionInfo = state.transitionInfo;
      return transitionInfo.hasTransition
          ? CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionDuration: transitionInfo.duration,
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) =>
            PageTransition(
              type: transitionInfo.transitionType,
              duration: transitionInfo.duration,
              reverseDuration: transitionInfo.duration,
              alignment: transitionInfo.alignment,
              child: child,
            ).buildTransitions(
              context,
              animation,
              secondaryAnimation,
              child,
            ),
      )
          : MaterialPage(key: state.pageKey, child: child);
    },
    routes: routes,
  );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
