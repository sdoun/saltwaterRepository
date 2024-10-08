import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'like_model.dart';
export 'like_model.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget({super.key});

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  late LikeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LikeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            leading: Align(
              alignment: const AlignmentDirectional(-1.0, -3.7),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
              ),
            ),
            actions: const [],
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: const AlignmentDirectional(0.0, 0.8),
                child: Text(
                  '찜',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily:
                    'PretendardSeries',
                    color: FlutterFlowTheme.of(context)
                        .primaryText,
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w700,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        'PretendardSeries'),
                  ),
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
            ),
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 64.0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 20.0,
                              child: Image.asset('assets/images/찜한포인트.png'),
                            ),
                            Text(
                              '  내가 찜한 포인트',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    'PretendardSeries'),
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder<List<TBPointRecord>>(
                          stream: queryTBPointRecord(
                            queryBuilder: (tBPointRecord) =>
                                tBPointRecord.where(
                              'point_liked_by',
                              arrayContains: currentUserReference,
                            ),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<TBPointRecord> columnTBPointRecordList =
                                snapshot.data!;

                            return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                                child:Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                  List.generate(columnTBPointRecordList.length,
                                          (columnIndex) {
                                        final columnTBPointRecord =
                                        columnTBPointRecordList[columnIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'point_detailed',
                                              queryParameters: {
                                                'pointRefSW': serializeParam(
                                                  columnTBPointRecord.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 3.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 85.0,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(
                                                      0.0,
                                                      2.0,
                                                    ),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(12.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 8.0, 12.0, 8.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(8.0),
                                                      child: Image.network(
                                                        columnTBPointRecord.pointImages[0].toString(),
                                                        width: 80.0,
                                                        height: 200.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          columnTBPointRecord.pointName,
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily:
                                                            'PretendardSeries',
                                                            color: FlutterFlowTheme.of(context)
                                                                .primaryText,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w600,
                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                'PretendardSeries'),
                                                          ),
                                                        ),
                                                        Text(
                                                          columnTBPointRecord
                                                              .pointCategories,
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily:
                                                            'PretendardSeries',
                                                            color: FlutterFlowTheme.of(context)
                                                                .primaryText,
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w500,
                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                'PretendardSeries'),
                                                          ),
                                                        ),
                                                        Text(
                                                          columnTBPointRecord
                                                              .pointAddress
                                                              .maybeHandleOverflow(
                                                            maxChars: 15,
                                                            replacement: '…',
                                                          ),
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily:
                                                            'PretendardSeries',
                                                            color: FlutterFlowTheme.of(context)
                                                                .primaryText,
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.w500,
                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                'PretendardSeries'),
                                                          ),
                                                        ),
                                                      ].divide(const SizedBox(height: 4.0)),
                                                    ),
                                                  ].divide(const SizedBox(width: 8.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).divide(const SizedBox(height: 4.0)),
                                )
                            );
                          },
                        ),
                      ].divide(const SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 15,
                              child: Image.asset('assets/images/찜한게시물.png'),
                            ),
                            Text(
                              ' 내가 찜한 게시물',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily:
                                'PretendardSeries',
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                fontSize: 17.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    'PretendardSeries'),
                              ),
                            ),

                          ],
                        ),
                        StreamBuilder<List<TBCarrotPostRecord>>(
                          stream: queryTBCarrotPostRecord(
                            queryBuilder: (tBCarrotPostRecord) =>
                                tBCarrotPostRecord.where(
                              'post_likedBy',
                              arrayContains: currentUserReference,
                            ),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<TBCarrotPostRecord>
                                columnTBCarrotPostRecordList = snapshot.data!;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  columnTBCarrotPostRecordList.length,
                                  (columnIndex) {
                                final columnTBCarrotPostRecord =
                                    columnTBCarrotPostRecordList[columnIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'carrotPost',
                                      queryParameters: {
                                        'carrotPost': serializeParam(
                                          columnTBCarrotPostRecord.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 85.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 8.0, 12.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                columnTBCarrotPostRecord
                                                    .postImage[0].toString(),
                                                width: 80.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    columnTBCarrotPostRecord
                                                        .postTitle
                                                        .toString(),
                                                    '0',
                                                  ).maybeHandleOverflow(
                                                    maxChars: 10,
                                                    replacement: '…',
                                                  ),
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily:
                                                    'PretendardSeries',
                                                    color: FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                        'PretendardSeries'),
                                                  ),
                                                ),
                                                Text(
                                                  columnTBCarrotPostRecord
                                                      .postCategory,
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily:
                                                    'PretendardSeries',
                                                    color: FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                        'PretendardSeries'),
                                                  ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    columnTBCarrotPostRecord
                                                        .postDatetime
                                                        ?.toString(),
                                                    '0',
                                                  ).maybeHandleOverflow(
                                                    maxChars: 15,
                                                    replacement: '…',
                                                  ),
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily:
                                                    'PretendardSeries',
                                                    color: FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                        'PretendardSeries'),
                                                  ),
                                                ),
                                              ].divide(const SizedBox(height: 4.0)),
                                            ),
                                          ].divide(const SizedBox(width: 8.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).divide(const SizedBox(height: 4.0)),
                            );
                          },
                        ),
                      ].divide(const SizedBox(height: 8.0)),
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
              ),
              wrapWithModel(
                model: _model.customNavbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const CustomNavbarWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
