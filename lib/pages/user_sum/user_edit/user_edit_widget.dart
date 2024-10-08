import 'package:salt_water_beta_ver1/components/new_profile_image.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/components/image_upload_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'user_edit_model.dart';
export 'user_edit_model.dart';

class UserEditWidget extends StatefulWidget {
  const UserEditWidget({
    super.key,
    required this.userRef,
  });

  final DocumentReference? userRef;

  @override
  State<UserEditWidget> createState() => _UserEditWidgetState();
}

class _UserEditWidgetState extends State<UserEditWidget> {
  late UserEditModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserEditModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Text(
              '프로필 수정',
              style: FlutterFlowTheme.of(
                  context)
                  .headlineMedium
                  .override(
                fontFamily:
                'PretendardSeries',
                color: FlutterFlowTheme
                    .of(context)
                    .primaryText,
                fontSize: 19.0,
                letterSpacing: 0.0,
                fontWeight:
                FontWeight.w700,
                useGoogleFonts:
                GoogleFonts
                    .asMap()
                    .containsKey(
                    'PretendardSeries'),
              ),
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 88.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.07, -0.96),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: 72.0,
                                  height: 72.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    FFAppState().newProfileImage != ''
                                        ? FFAppState().newProfileImage
                                        : currentUserPhoto,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.22, 0.49),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return WebViewAware(
                                        child: GestureDetector(
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: const NewProfileImage(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 28.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '새로운 닉네임 설정',
                              style: FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme
                                    .of(context)
                                    .primaryText,
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight:
                                FontWeight.w700,
                                useGoogleFonts:
                                GoogleFonts
                                    .asMap()
                                    .containsKey(
                                    'PretendardSeries'),
                              ),
                            ),
                            TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: true,
                              obscureText: false,
                              initialValue: currentUserDisplayName,
                              decoration: InputDecoration(
                                labelText: '여기에 입력하세요',
                                labelStyle: FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color: FlutterFlowTheme
                                      .of(context)
                                      .secondaryText,
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.w500,
                                  useGoogleFonts:
                                  GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                                hintStyle: FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color: FlutterFlowTheme
                                      .of(context)
                                      .secondaryText,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.w400,
                                  useGoogleFonts:
                                  GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              style: FlutterFlowTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme
                                    .of(context)
                                    .secondaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight:
                                FontWeight.w400,
                                useGoogleFonts:
                                GoogleFonts
                                    .asMap()
                                    .containsKey(
                                    'PretendardSeries'),
                              ),
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ].divide(const SizedBox(height: 8.0)),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 1.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await widget.userRef!
                                    .update(createUsersRecordData(
                                  displayName: _model.textController.text,
                                  photoUrl: FFAppState().newProfileImage,
                                ));
                                FFAppState().newProfileImage = '';
                                safeSetState(() {});
                                context.safePop();
                              },
                              text: '확인',
                              options: FFButtonOptions(
                                height: 30.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(
                                    context)
                                    .titleSmall
                                    .override(
                                  fontFamily:
                                  'PretendardSeries',
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight:
                                  FontWeight.w600,
                                  useGoogleFonts:
                                  GoogleFonts
                                      .asMap()
                                      .containsKey(
                                      'PretendardSeries'),
                                ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              FFAppState().newProfileImage = '';
                              safeSetState(() {});
                              context.safePop();
                            },
                            text: '취소하기',
                            options: FFButtonOptions(
                              height: 30.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(
                                  context)
                                  .titleSmall
                                  .override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight:
                                FontWeight.w600,
                                useGoogleFonts:
                                GoogleFonts
                                    .asMap()
                                    .containsKey(
                                    'PretendardSeries'),
                              ),
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).secondaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ].divide(const SizedBox(width: 12.0)),
                      ),
                    ].divide(const SizedBox(height: 8.0)),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.customNavbarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: const CustomNavbarWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
