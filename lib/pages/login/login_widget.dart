import 'package:firebase_auth/firebase_auth.dart';

import '../../components/term_view_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/agreement_for_sign_in_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'login_model.dart';
export 'login_model.dart';

import 'package:salt_water_beta_ver1/reusable/login/loginTextForm.dart';
import 'package:salt_water_beta_ver1/reusable/login/socialButton.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {

  bool dummychange = true;
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());
    actions.initAppLInk();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.initAppLInk();
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.emailAddressCreateTextController ??= TextEditingController();
    _model.emailAddressCreateFocusNode ??= FocusNode();

    _model.passwordCreateTextController ??= TextEditingController();
    _model.passwordCreateFocusNode ??= FocusNode();

    _model.passwordCreateConfirmTextController ??= TextEditingController();
    _model.passwordCreateConfirmFocusNode ??= FocusNode();

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 80.0),
            end: const Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: const Offset(0.0, 20.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> handleEmailAuth() async {
    if (_formKey.currentState == null) return;
    if(_model.emailAddressCreateTextController.text.isEmpty || _model.passwordCreateTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일과 비밀번호를 올바르게 입력해주세요.'),
          duration: Duration(milliseconds: 4000),
        ),
      );
      return;
    }
    
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일과 비밀번호를 올바르게 입력해주세요.'),
          duration: Duration(milliseconds: 4000),
        ),
      );
      return;
    }
    
    try {
    // 1. 로그인 시도
    GoRouter.of(context).prepareAuthEvent(); // 중요: Auth 이벤트 준비


    final  user = await authManager.signInWithEmail(
        context,
        _model.emailAddressCreateTextController.text.trim(),
        _model.passwordCreateTextController.text,
      );
    if (user == null) {
      // 2. 로그인 실패 시 회원가입 시도
      if (!_model.checkboxValue!) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('약관에 동의해주세요!')),
        );
        return;
      }

      GoRouter.of(context).prepareAuthEvent(); // 회원가입 이벤트 준비
      
      final newUser = await authManager.createAccountWithEmail(
        context,
        _model.emailAddressCreateTextController.text.trim(),
        _model.passwordCreateTextController.text,
      );

      if (newUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입에 실패했습니다.')),
        );
        return;
      }

      // 3. 사용자 추가 정보 업데이트
      await maybeCreateUser(newUser as User);
    }

    if (context.mounted) {
      context.goNamedAuth('home1', context.mounted);
    }
  } on FirebaseAuthException catch (e) {
    print('Firebase Auth Error: ${e.code} - ${e.message}');
    String errorMessage;
    
    switch (e.code) {
      case 'invalid-email':
        errorMessage = '올바른 이메일 형식이 아닙니다.';
        break;
      case 'wrong-password':
        errorMessage = '비밀번호가 올바르지 않습니다.';
        break;
      case 'email-already-in-use':
        errorMessage = '이미 사용 중인 이메일입니다.';
        break;
      case 'operation-not-allowed':
        errorMessage = '이메일/비밀번호 로그인이 비활성화되어 있습니다.';
        break;
      case 'weak-password':
        errorMessage = '비밀번호가 너무 약합니다.';
        break;
      default:
        errorMessage = '비밀번호가 올바르지 않거나 인증 오류가 발생했습니다: ${e.message}';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  } catch (e) {
    print('General Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('예기치 않은 오류가 발생했습니다.')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                  child: SizedBox(
                      height: 48,
                      child: Image.asset('assets/images/상단바로고1.png')
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, -1),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        constraints: const BoxConstraints(
                          maxWidth: 530.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: const AlignmentDirectional(0.0, -1.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 16.0, 24.0, 0.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (responsiveVisibility(
                                            context: context,
                                            phone: false,
                                            tablet: false,
                                          ))
                                            Container(
                                              width: 230.0,
                                              height: 16.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .secondaryBackground,
                                              ),
                                            ),
                                          Text(
                                            '회원가입/로그인',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                                              fontFamily:
                                              'PretendardSeries',
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              fontSize: 19.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                  'PretendardSeries'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 4.0, 0.0, 24.0),
                                            child: Text(
                                              '이메일 회원가입/이메일 로그인',
                                              textAlign: TextAlign.start,
                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                fontFamily:
                                                'PretendardSeries',
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                    'PretendardSeries'),
                                              ),
                                            ),
                                          ),
                                          LoginTextForm(
                                            controller: _model
                                                .emailAddressCreateTextController,
                                            focusNode: _model
                                                .emailAddressCreateFocusNode,
                                            labelText: '이메일',
                                            isPassword: false,
                                            autofillHints: const [AutofillHints.email],
                                            icon: null,
                                            keyboardType: TextInputType.emailAddress,
                                            validator: _model
                                                .emailAddressCreateTextControllerValidator
                                                .asValidator(context),
                                          ),
                                          LoginTextForm(
                                            controller: _model
                                                .passwordCreateTextController,
                                            focusNode: _model.passwordCreateFocusNode,
                                            labelText: '비밀번호',
                                            isPassword: true,
                                            autofillHints: const [AutofillHints.password],
                                            icon: Icon(
                                              _model.passwordCreateConfirmVisibility
                                                  ? Icons
                                                  .visibility_outlined
                                                  : Icons
                                                  .visibility_off_outlined,
                                              color:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .secondaryText,
                                              size: 20.0,
                                            ),
                                              validator: _model
                                                  .passwordCreateTextControllerValidator
                                                  .asValidator(context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 0.0, 0.0, 12.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity
                                                              .compact,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    4.0),
                                                      ),
                                                    ),
                                                    unselectedWidgetColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                            .checkboxValue ??=
                                                        FFAppState()
                                                                .termsAgreement
                                                                .serviceTerms ==
                                                            true,
                                                    onChanged: ((FFAppState()
                                                            .termsAgreement
                                                            .personalData ==
                                                        false) ||
                                                    (FFAppState()
                                                            .termsAgreement
                                                            .serviceTerms ==
                                                        false) ||
                                                    (FFAppState()
                                                            .termsAgreement
                                                            .geoBased ==
                                                        false) ||
                                                    (FFAppState()
                                                            .termsAgreement
                                                            .phoneAuth ==
                                                        false))
                                                        ? null
                                                        : (newValue) async {
                                                            safeSetState(() =>
                                                                _model.checkboxValue =
                                                                    newValue!);

                                                            if (!newValue!) {
                                                              FFAppState()
                                                                      .termsAgreement =
                                                                  SignInAgreementStruct();
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          },
                                                    side: BorderSide(
                                                      width: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                    ),
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    checkColor: ((FFAppState()
                                                            .termsAgreement
                                                            .personalData ==
                                                        false) ||
                                                    (FFAppState()
                                                            .termsAgreement
                                                            .serviceTerms ==
                                                        false) ||
                                                    (FFAppState()
                                                            .termsAgreement
                                                            .geoBased ==
                                                        false) ||
                                                    (FFAppState()
                                                            .termsAgreement
                                                            .phoneAuth ==
                                                        false))
                                                        ? null
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors
                                                                .transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return WebViewAware(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus(),
                                                              child: Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    const AgreementForSignInWidget(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() =>
                                                              _model.allAgree =
                                                                  value));

                                                      safeSetState(() {
                                                        _model.checkboxValue =
                                                            _model.allAgree!;
                                                      });

                                                      safeSetState(() {});
                                                    },
                                                    child: Text(
                                                      '약관 동의하기',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily:
                                                        'PretendardSeries',
                                                        color: FlutterFlowTheme.of(context)
                                                            .secondaryText,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                            'PretendardSeries'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: const AlignmentDirectional(
                                                0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 16.0),
                                              child: FFButtonWidget(
                                                onPressed: handleEmailAuth,
                                                text: '가입하고 시작하기!',
                                                //버튼 크기 바꾸는 중이었음
                                                options: FFButtonOptions(
                                                  width: 230.0,
                                                  height: 44.0,
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(context)
                                                                    .titleSmallFamily),
                                                      ),
                                                  elevation: 3.0,
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.0, 0.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 16.0),
                                                  child: Wrap(
                                                    spacing: 16.0,
                                                    runSpacing: 0.0,
                                                    alignment:
                                                        WrapAlignment.center,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    direction:
                                                        Axis.horizontal,
                                                    runAlignment:
                                                        WrapAlignment.center,
                                                    verticalDirection:
                                                        VerticalDirection
                                                            .down,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      socialButton(
                                                        onPressed: () async {
                                                          GoRouter.of(
                                                              context)
                                                              .prepareAuthEvent();
                                                          final user =
                                                          await authManager
                                                              .signInWithGoogle(
                                                              context);
                                                          if (user ==
                                                              null) {
                                                            return;
                                                          }

                                                          context.goNamedAuth(
                                                              'home1',
                                                              context
                                                                  .mounted);
                                                        },
                                                        text: '구글 회원가입',
                                                        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                        icon: const FaIcon(
                                                          FontAwesomeIcons
                                                              .google,
                                                          size: 20.0,
                                                        ),
                                                        textColor: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                      isAndroid
                                                          ? Container()
                                                          :
                                                      socialButton(
                                                        onPressed:  () async {
                                                          GoRouter.of(
                                                              context)
                                                              .prepareAuthEvent();
                                                          final user =
                                                          await authManager
                                                              .signInWithApple(context);
                                                          if (user ==
                                                              null) {
                                                            return;
                                                          }

                                                          context.goNamedAuth(
                                                              'home1',
                                                              context
                                                                  .mounted);
                                                        },
                                                        text: '애플 회원가입',
                                                        backgroundColor: const Color(0xffCAF1FA),
                                                        icon: const FaIcon(
                                                          FontAwesomeIcons
                                                              .apple,
                                                          size: 20.0,
                                                        ),
                                                        textColor: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                      socialButton(
                                                        onPressed: () async {
                                                          await actions
                                                              .loginKakao();
                                                        },
                                                        text: '카카오 회원가입',
                                                        backgroundColor: const Color(
                                                            0xFFFFE700),
                                                        icon: Icon(
                                                          Icons
                                                          .chat_bubble_outlined,
                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                          size: 20.0,
                                                        ),
                                                        textColor: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                      socialButton(
                                                        onPressed: () async {
                                                          await actions
                                                              .signInWithNaver();
                                                        },
                                                        text: '네이버 회원가입',
                                                        backgroundColor: const Color(
                                                            0xFF00CC66),
                                                        icon: Icon(
                                                          Icons
                                                          .chat_bubble_outlined,
                                                          size: 20.0,
                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                        ),
                                                        textColor: FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor: Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return WebViewAware(
                                                        child: Padding(
                                                          padding: MediaQuery.viewInsetsOf(context),
                                                          child: const TermViewWidget(
                                                            termsType:
                                                            "서비스 이용 약관",
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  '로그인/회원가입 시\n이용약관, 개인정보 취급방침에 동의하게 됩니다.',
                                                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                                                    fontFamily:
                                                    'PretendardSeries',
                                                    color: FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w400,
                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                        'PretendardSeries'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ).animateOnPageLoad(animationsMap[
                                        'columnOnPageLoadAnimation1']!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
