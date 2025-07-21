import 'package:app_version_update/app_version_update.dart';
import 'package:firebase_core/firebase_core.dart';

import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void verifyVersion(BuildContext context) async {

  await AppVersionUpdate.checkForUpdates(
    //앱 ID는 환경변수로 사용하는 방법 고려할 것
    appleId: 'id6745240398',
    playStoreId: 'com.mycompany.saltwaterbetaver1',
    country: 'kr',
  ).then((result) async {
    if (result.canUpdate! || true) {
      print('업데이트 가능: $result'); // 업데이트 가능한 경우 메시지 출력
      await AppVersionUpdate.showAlertUpdate(
          appVersionResult: result,

          context: context,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          title: '새로운 업데이트가 있습니다!',
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          content: '스토어로 이동하여 업데이트를 진행해주세요!',
          contentTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
          updateButtonText: '업데이트',
          cancelButtonText: '취소',
          cancelTextStyle: TextStyle(color: Colors.black),
          cancelButtonStyle: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white12),
          ));
    } else {
      print('업데이트 불가: $result'); // 업데이트 불가능한 경우 메시지 출력
    }
  });
}


void main() async {
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
 FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await Firebase.initializeApp(
  );
  await initFirebase();

  // Start initial custom actions code
  await actions.inintKakao();
  // End initial custom actions code

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    //verifyVersion(context);
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier, observer);
    userStream = saltWaterBetaVer1FirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});

    // 앱 초기화가 완료된 후 스플래시 화면을 제거합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }
  Future<void> _initializeApp() async {
    // 여기에 추가적인 초기화 작업을 넣을 수 있습니다.
    //await Future.delayed(const Duration(seconds: 3)); // 예시로 3초 대기

    // 모든 초기화 작업이 완료된 후 스플래시 화면을 제거합니다.
    FlutterNativeSplash.remove();
    _appStateNotifier.stopShowingSplashImage();
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'saltWater-beta-ver1',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    
    );
  }
}
