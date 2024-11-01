import '../../../reusable/common/loadingAnimation.dart';
import '../../../reusable/common/pulsatingImage.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'weather_detailed_model.dart';
export 'weather_detailed_model.dart';

import 'package:salt_water_beta_ver1/reusable/weather/tidDateButton.dart';
import 'package:get/get.dart';
import 'package:salt_water_beta_ver1/reusable/common/loadingcontroller.dart';

class WeatherDetailedWidget extends StatefulWidget {
  const WeatherDetailedWidget({
    super.key,
    required this.weatherRef,
  });

  final DocumentReference? weatherRef;

  @override
  State<WeatherDetailedWidget> createState() => _WeatherDetailedWidgetState();
}

class _WeatherDetailedWidgetState extends State<WeatherDetailedWidget> {
  late WeatherDetailedModel _model;
  bool isLoading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeatherDetailedModel());
    print(widget.weatherRef);
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.tidDate =
          functions.datetimeToDateCopy(getCurrentTimestamp.toString());
      _model.tidDateString =
          functions.tidDateButton(false, false, getCurrentTimestamp.toString());
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final weatherRef = widget.weatherRef;
        if (weatherRef != null) {
          TBWeatherPointRecord.getDocument(weatherRef).firstWhere((record) => record != null).then((record) {
            if (mounted) {
              loadAllData(record);
              print(record.name);
            }
          });
        }
      }
    });
  }

  Future<void> loadAllData(TBWeatherPointRecord record) async {
    setState(() {
      isLoading = true;
    });

    try {
      final results = await Future.wait([
        RealtimeWeatherAPICall.call(
          nx: record.nx,
          ny: record.ny,
          numOfRows: 8,
          dataType: 'JSON',
          baseDate: functions.datetimeToTimeString(getCurrentTimestamp.toString()) == '0000'
              ? (functions.datetimeToDateCopy(getCurrentTimestamp.toString()) - 1)
              : functions.datetimeToDateCopy(getCurrentTimestamp.toString()),
          baseTime: functions.datetimeToTimeString(getCurrentTimestamp.toString()) == '0000'
              ? '2300'
              : functions.datetimeToTimeString(getCurrentTimestamp.toString()),
        ),
        FcstWeatherApiCall.call(
            numOfRows: 10,
            pageNo: 1,
            dataType: 'JSON',
            baseDate: functions.datetimeToDateCopyFcst(getCurrentTimestamp.toString()).last,
            baseTime: functions.datetimeToDateCopyFcst(getCurrentTimestamp.toString()).first,
            nx: record.nx,
            ny: record.ny,
        ),
        TidalFcstCall.call(
          date: _model.tidDateString,
          dataType: 'tideObsPreTab',
          obsCode: record.tidObsCode,
          resultType: 'json',
        ),
        MidTmpCall.call(
          regId: record.midRegId,
          tmFc: '0600',
        ),
        MidFcstCall.call(
          numOfRows: 1,
          pageNo: 1,
          dataType: 'JSON',
          regId: functions.midFcstCodeTrans(record.midRegId),
          tmFc: '${functions.datetimeToDateCopy(getCurrentTimestamp.toString()).toString()}0600',
        ),
        RealtimeWtrTmpCall.call(),
      ]);

      setState(() {
        print('api call success!');
        _model.realtimeWeatherResponse = results[0];

        _model.fcstWeatherResponse = results[1];
        _model.tidalFcstResponse = results[2];
        _model.midTmpResponse = results[3];
        _model.midFcstResponse = results[4];
        _model.realtimeWtrTmpResponse = results[5];
        print(results[0].jsonBody);
        print(results[1].jsonBody);
        print(results[2].jsonBody);
        print(results[3].jsonBody);
        print(results[4].jsonBody);
        print(results[5].jsonBody);
        isLoading = false;
      });
    } catch (e) {
      print('데이터 로딩 중 오류 발생: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TBWeatherPointRecord>(
      stream: TBWeatherPointRecord.getDocument(widget.weatherRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme
                .of(context)
                .primaryBackground,
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme
                            .of(context)
                            .primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final weatherDetailedTBWeatherPointRecord = snapshot.data!;

        return Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme
                    .of(context)
                    .primaryBackground,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  leading: Align(
                    alignment: const AlignmentDirectional(-1.0, -3.7),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 0.0, 0.0),
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
                          context.pop();
                        },
                      ),
                    ),
                  ),
                  title: Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      child: Text(
                        '날씨보기',
                        style: FlutterFlowTheme
                            .of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'PretendardSeries',
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w800,
                          useGoogleFonts: GoogleFonts.asMap()
                              .containsKey('PretendardSeries'),
                        ),
                      ),
                    ),
                  ),
                  actions: const [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.transparent,
                        size: 30.0,
                      ),
                    ),
                  ],
                  centerTitle: false,
                  elevation: 2.0,
                ),
                body: SafeArea(
                  top: true,
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme
                                  .of(context)
                                  .primaryBackground,
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 44.0, 16.0, 24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12.0),
                                        bottomRight:
                                        Radius.circular(12.0),
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                        FlutterFlowTheme
                                            .of(context)
                                            .primaryBackground,
                                      ),
                                      child: Text(
                                        weatherDetailedTBWeatherPointRecord
                                            .name,
                                        style: FlutterFlowTheme
                                            .of(
                                            context)
                                            .bodyMedium
                                            .override(
                                          fontFamily:
                                          FlutterFlowTheme
                                              .of(
                                              context)
                                              .bodyMediumFamily,
                                          color: FlutterFlowTheme
                                              .of(
                                              context)
                                              .secondaryText,
                                          fontSize: 23.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w700,
                                          useGoogleFonts: GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              FlutterFlowTheme
                                                  .of(
                                                  context)
                                                  .bodyMediumFamily),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(16.0, 8.0, 16.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        if(!isLoading)
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          child: Container(
                                            width: 115.0,
                                            height: 93.0,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme
                                                  .of(
                                                  context)
                                                  .primaryBackground,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12.0),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  8.0),
                                              child:
                                              Image.network(
                                                functions.skyToImageLinkCopy(
                                                    functions.fcsSkyForTommorow(
                                                        FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList() ?? [],
                                                        functions.datetimeToDateCopy(getCurrentTimestamp.toString()).toString(),
                                                        0
                                                    )?.firstOrNull?.toString() ?? ''
                                                ).firstOrNull ?? 'https://path.to/default/image.png',
                                                width: 300.0,
                                                height: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(!isLoading)
                                        Align(
                                          alignment:
                                          const AlignmentDirectional(
                                              0.0, -1.0),
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional
                                                .fromSTEB(
                                                28.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                '${RealtimeWeatherAPICall
                                                    .dataList(
                                                  _model.realtimeWeatherResponse?.jsonBody,
                                                )?[3]}℃',
                                                '20℃',
                                              ),
                                              style: FlutterFlowTheme
                                                  .of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily:
                                                FlutterFlowTheme
                                                    .of(
                                                    context)
                                                    .bodyMediumFamily,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                FontWeight.w600,
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterFlowTheme
                                                        .of(
                                                        context)
                                                        .bodyMediumFamily),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional
                                              .fromSTEB(
                                              0.0, 0.0, 0.0, 4.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 4.0,
                                            shape:
                                            const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(8.0),
                                                bottomRight:
                                                Radius.circular(8.0),
                                                topLeft:
                                                Radius.circular(8.0),
                                                topRight:
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                              const BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(8.0),
                                                bottomRight:
                                                Radius.circular(8.0),
                                                topLeft:
                                                Radius.circular(8.0),
                                                topRight:
                                                Radius.circular(8.0),
                                              ),
                                              child: Container(
                                                width: MediaQuery
                                                    .sizeOf(
                                                    context)
                                                    .width *
                                                    0.21,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .primaryBackground,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(
                                                          0x33000000),
                                                      offset: Offset(
                                                        0.0,
                                                        2.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                  const BorderRadius
                                                      .only(
                                                    bottomLeft:
                                                    Radius.circular(
                                                        8.0),
                                                    bottomRight:
                                                    Radius.circular(
                                                        8.0),
                                                    topLeft:
                                                    Radius.circular(
                                                        8.0),
                                                    topRight:
                                                    Radius.circular(
                                                        8.0),
                                                  ),
                                                ),
                                                alignment:
                                                const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      '풍향',
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily: FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .bodyMediumFamily,
                                                        color: const Color(
                                                            0xFF1E2224),
                                                        fontSize:
                                                        16.0,
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                        useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                            .containsKey(
                                                            FlutterFlowTheme
                                                                .of(
                                                                context)
                                                                .bodyMediumFamily),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 36.0,
                                                      clipBehavior:
                                                      Clip.antiAlias,
                                                      decoration:
                                                      const BoxDecoration(
                                                        shape: BoxShape
                                                            .rectangle,
                                                      ),
                                                      child:
                                                      Image.network(
                                                        functions
                                                            .vecStringToImage(
                                                            functions
                                                                .vecToString(
                                                                RealtimeWeatherAPICall
                                                                    .dataList(
                                                                  _model.realtimeWeatherResponse?.jsonBody,
                                                                )?[5])),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<
                                                          String>(
                                                        functions
                                                            .vecToString(
                                                            RealtimeWeatherAPICall
                                                                .dataList(
                                                              _model.realtimeWeatherResponse?.jsonBody,
                                                            )?[5]),
                                                        '서버 응답없음',
                                                      ),
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily: FlutterFlowTheme
                                                            .of(
                                                            context)
                                                            .bodyMediumFamily,
                                                        fontSize:
                                                        12.0,
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                        useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                            .containsKey(
                                                            FlutterFlowTheme
                                                                .of(
                                                                context)
                                                                .bodyMediumFamily),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        WeatherInfoBox(
                                          context: context,
                                          title: '풍속',
                                          value: valueOrDefault<String>(
                                            '${valueOrDefault<String>(
                                              RealtimeWeatherAPICall
                                                  .dataList(
                                                _model.realtimeWeatherResponse?.jsonBody,
                                              )?.last,
                                              '0',
                                            )}m/s',
                                            '서버 응답없음',
                                          ),
                                        ),
                                        WeatherInfoBox(
                                          context: context,
                                          title: '파고',
                                          value: valueOrDefault<String>(
                                            '${valueOrDefault<String>(
                                              FcstWeatherApiCall
                                                  .valueList(
                                                _model.fcstWeatherResponse?.jsonBody,
                                              )?[8],
                                              '0',
                                            )}M',
                                            '0M',
                                          ),
                                        ),
                                        WeatherInfoBox(
                                          context: context,
                                          title: '강수량',
                                          value: valueOrDefault<String>(
                                            '${valueOrDefault<String>(
                                              RealtimeWeatherAPICall
                                                  .dataList(
                                                _model.realtimeWeatherResponse?.jsonBody,
                                              )?[2],
                                              '0',
                                            )}mm',
                                            '서버 응답없음',
                                          ),
                                        ),
                                      ].divide(
                                          const SizedBox(width: 8.0)),
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 8.0)),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              Material(
                                color: const Color(0xffDDEFFF),
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                  width: MediaQuery
                                      .sizeOf(context)
                                      .width *
                                      0.8,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffDDEFFF),
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme
                                          .of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  alignment:
                                  const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(28.0, 0.0, 28.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons
                                                  .temperatureFull,
                                              color: FlutterFlowTheme
                                                  .of(
                                                  context)
                                                  .secondary,
                                              size: 36.0,
                                            ),
                                            Text(
                                              '  현재 수온',
                                              style: FlutterFlowTheme
                                                  .of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily:
                                                'PretendardSeries',
                                                color:
                                                FlutterFlowTheme
                                                    .of(
                                                    context)
                                                    .primaryText,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                FontWeight.w700,
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    'PretendardSeries'),
                                              ),
                                            ),
                                          ].divide(
                                              const SizedBox(width: 8.0)),
                                        ),
                                        if(!isLoading)
                                        Text(
                                          '${functions.wrttempFromJson(
                                              functions.findItemFromStacdeLay1(
                                                  RealtimeWtrTmpCall.jsonItems(
                                                    _model.realtimeWtrTmpResponse?.jsonBody)?.toList(),
                                                  weatherDetailedTBWeatherPointRecord
                                                      .staCde))}℃',
                                          style: FlutterFlowTheme
                                              .of(
                                              context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            'PretendardSeries',
                                            color: FlutterFlowTheme
                                                .of(
                                                context)
                                                .primaryText,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                      ].divide(const SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                          ),
                              Container(
                                width: double.infinity,
                                height: 262.0,
                                decoration: const BoxDecoration(
                                    color: Color(0xffF9FAFF)),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 68.0,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '만조 및 간조',
                                              style: FlutterFlowTheme
                                                  .of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily:
                                                'PretendardSeries',
                                                color:
                                                FlutterFlowTheme
                                                    .of(
                                                    context)
                                                    .primaryText,
                                                fontSize: 17.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                FontWeight.w700,
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    'PretendardSeries'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  16.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                '날짜: ${_model
                                                    .tidDateString ==
                                                    functions
                                                        .datetimeToDateCopy(
                                                        getCurrentTimestamp
                                                            .toString())
                                                        .toString()
                                                    ? '오늘'
                                                    : functions
                                                    .formatTidDate(_model
                                                    .tidDateString!)}',
                                                style: FlutterFlowTheme
                                                    .of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  'PretendardSeries',
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .primaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  useGoogleFonts:
                                                  GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                      'PretendardSeries'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(!isLoading)
                                        Builder(
                                          builder: (context) {
                                            final tidList = functions
                                                .tidStructListFromJson(
                                                TidalFcstCall
                                                    .dataList(
                                                  _model.tidalFcstResponse?.jsonBody,
                                                )?.toList())
                                                ?.toList() ??
                                                [];

                                            return SingleChildScrollView(
                                              scrollDirection:
                                              Axis.horizontal,
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: List.generate(
                                                    tidList.length,
                                                        (tidListIndex) {
                                                      final tidListItem =
                                                      tidList[tidListIndex];
                                                      return Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0,
                                                            8.0, 0.0, 8.0),
                                                        child: Material(
                                                          color:
                                                          Colors.transparent,
                                                          elevation: 2.0,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                12.0),
                                                          ),
                                                          child: Container(
                                                            constraints:
                                                            BoxConstraints(
                                                              maxWidth: (MediaQuery
                                                                  .sizeOf(
                                                                  context)
                                                                  .width -
                                                                  52.0) *
                                                                  0.265,
                                                            ),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  blurRadius: 4.0,
                                                                  color: Color(
                                                                      0x33000000),
                                                                  offset: Offset(
                                                                    2.0,
                                                                    2.0,
                                                                  ),
                                                                  spreadRadius:
                                                                  1.0,
                                                                )
                                                              ],
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8.0,
                                                                  8.0,
                                                                  8.0,
                                                                  8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                    const AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                    child: Text(
                                                                      '${functions
                                                                          .formatTidDate(
                                                                          _model
                                                                              .tidDateString!)}',
                                                                      style: FlutterFlowTheme
                                                                          .of(
                                                                          context)
                                                                          .bodyMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'PretendardSeries',
                                                                        fontSize:
                                                                        12,
                                                                        letterSpacing:
                                                                        0.0,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                        useGoogleFonts:
                                                                        GoogleFonts
                                                                            .asMap()
                                                                            .containsKey(
                                                                            'PretendardSeries'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    tidListItem
                                                                        .timeString,
                                                                    style: FlutterFlowTheme
                                                                        .of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'PretendardSeries',
                                                                      fontSize:
                                                                      12,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      useGoogleFonts:
                                                                      GoogleFonts
                                                                          .asMap()
                                                                          .containsKey(
                                                                          'PretendardSeries'),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    tidListItem
                                                                        .tidType,
                                                                    style: FlutterFlowTheme
                                                                        .of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'PretendardSeries',
                                                                      fontSize:
                                                                      13.5,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      useGoogleFonts:
                                                                      GoogleFonts
                                                                          .asMap()
                                                                          .containsKey(
                                                                          'PretendardSeries'),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            8.0),
                                                                        child: Image
                                                                            .network(
                                                                          tidListItem
                                                                              .tidType ==
                                                                              '저조'
                                                                              ? 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%95%84%EC%9D%B4%EC%BD%98%2F%EC%A0%80%EC%A1%B0.png?alt=media&token=e66d459d-2e26-4041-af11-dc7d236bc380'
                                                                              : 'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%95%84%EC%9D%B4%EC%BD%98%2F%EA%B3%A0%EC%A1%B0.png?alt=media&token=b5f1d918-8f87-46fc-a695-ee645f77586e',
                                                                          width:
                                                                          22.0,
                                                                          height:
                                                                          22.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '${tidListItem
                                                                            .tidLevel}cm',
                                                                        style: FlutterFlowTheme
                                                                            .of(
                                                                            context)
                                                                            .bodyMedium
                                                                            .override(
                                                                          fontFamily:
                                                                          'PretendardSeries',
                                                                          color: tidListItem
                                                                              .tidType ==
                                                                              '저조'
                                                                              ? FlutterFlowTheme
                                                                              .of(
                                                                              context)
                                                                              .primary
                                                                              : const Color(
                                                                              0xFFFF0000),
                                                                          fontSize:
                                                                          12.0,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                          letterSpacing:
                                                                          0.0,
                                                                          useGoogleFonts:
                                                                          GoogleFonts
                                                                              .asMap()
                                                                              .containsKey(
                                                                              'PretendardSeries'),
                                                                        ),
                                                                      ),
                                                                    ].divide(
                                                                        const SizedBox(
                                                                            width:
                                                                            4.0)),
                                                                  ),
                                                                ].divide(
                                                                    const SizedBox(
                                                                        height:
                                                                        4.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).divide(const SizedBox(
                                                    width: 4.0)),
                                              ),
                                            );
                                          },
                                        ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 0, 15, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Tiddatebutton(
                                              color:
                                              const Color(0xffF9FAFF),
                                              text: '전날',
                                              borderColor:
                                              const Color(0xff949494),
                                              ontap: () async {
                                                _model.tidDate =
                                                    _model.tidDate! + -1;
                                                _model.tidDateString =
                                                    functions.tidDateButton(
                                                        false,
                                                        true,
                                                        _model
                                                            .tidDateString!);
                                                safeSetState(() {});
                                              },
                                            ),
                                            Tiddatebutton(
                                              color:
                                              const Color(0xffF9FAFF),
                                              text: '다음날',
                                              borderColor:
                                              const Color(0xff949494),
                                              ontap: () async {
                                                _model.tidDate =
                                                    _model.tidDate! + 1;
                                                safeSetState(() {});
                                                _model.tidDateString =
                                                    functions.tidDateButton(
                                                        true,
                                                        false,
                                                        _model
                                                            .tidDateString!);
                                                safeSetState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 8.0)),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 372.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xffFEFFEF),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional
                                      .fromSTEB(
                                      20.0, 12.0, 20.0, 12.0),
                                  child: Column(
                                    mainAxisSize:
                                    MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                        const AlignmentDirectional(
                                            0.0, -1.0),
                                        child: Text(
                                          '일주일 예보',
                                          style: FlutterFlowTheme.of(context).bodyMedium
                                              .override(
                                            fontFamily: 'PretendardSeries',
                                            fontSize: 17.0,
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            letterSpacing:
                                            0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                'PretendardSeries'),
                                          ),
                                        ),
                                      ),
                                      if(!isLoading)
                                        SingleChildScrollView(
                                          scrollDirection:
                                          Axis.horizontal,
                                          child: Row(
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              WeatherForecastCard(
                                                context: context,
                                                day: '1일 후 날씨',
                                                imageUrl: functions.skyToImageLinkCopy(
                                                    (functions.fcsSkyForTommorow(
                                                      FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList() ?? [],
                                                      functions.datetimeToDateCopy(getCurrentTimestamp.toString()).toString(),
                                                      1,
                                                    )?.firstOrNull?.toString()) ?? ''
                                                ).firstOrNull ?? 'default_image_url',
                                                temperature: '${functions.fcsTmpForTommorow(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    functions.datetimeToDateCopy(getCurrentTimestamp.toString()).toString(),
                                                    1
                                                )?.first?.toString() ?? '20'}℃',
                                                precipitation: '강수량: ${functions.fcstListForCategory(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    getCurrentTimestamp.toString(),
                                                    1,
                                                    'PCP'
                                                )?.first?.toString() ?? '0mm'}',
                                                windDirection: '풍향: ${functions.vecToString(functions.fcstListForCategory(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    getCurrentTimestamp.toString(),
                                                    1,
                                                    'VEC'
                                                )?.first?.toString())}',
                                                windSpeed: '풍속: ${functions.fcstListForCategory(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    getCurrentTimestamp.toString(),
                                                    1,
                                                    'WSD'
                                                )?.first?.toString() ?? '10'}m/s',

                                              ),
                                              WeatherForecastCard(
                                                context: context,
                                                day: '2일 후 날씨',
                                                imageUrl: functions.skyToImageLinkCopy(
                                                    (functions.fcsSkyForTommorow(
                                                      FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList() ?? [],
                                                      functions.datetimeToDateCopy(getCurrentTimestamp.toString()).toString(),
                                                      2,
                                                    )?.firstOrNull?.toString()) ?? ''
                                                ).firstOrNull ?? 'default_image_url',
                                                temperature: '${functions.fcsTmpForTommorow(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    functions.datetimeToDateCopy(getCurrentTimestamp.toString()).toString(),
                                                    2
                                                )?.first?.toString() ?? '21'}℃',
                                                precipitation: '강수량: ${functions.fcstListForCategory(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    getCurrentTimestamp.toString(),
                                                    2,
                                                    'PCP'
                                                )?.first?.toString() ?? '0mm'}',
                                                windDirection: '풍향: ${functions.vecToString(functions.fcstListForCategory(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    getCurrentTimestamp.toString(),
                                                    2,
                                                    'VEC'
                                                )?.first?.toString())}',
                                                windSpeed: '풍속: ${functions.fcstListForCategory(
                                                    FcstWeatherApiCall.itemList(_model.fcstWeatherResponse?.jsonBody)?.toList(),
                                                    getCurrentTimestamp.toString(),
                                                    2,
                                                    'WSD'
                                                )?.first?.toString() ?? '10'}m/s',
                                              ),
                                              WeatherForecastCard(
                                                context: context,
                                                day: '3일 후 날씨',
                                                imageUrl: functions.midFcstToImage(MidFcstCall.am3(
                                                  _model.midFcstResponse?.jsonBody,
                                                )),
                                                temperature: MidFcstCall.am3(
                                                  _model.midFcstResponse?.jsonBody ?? '맑음',
                                                ),
                                                precipitation: '강수량:${MidFcstCall.rnSt3Am(
                                                  _model.midFcstResponse?.jsonBody ?? '0',
                                                )?.toString()}mm',
                                                windDirection: '',
                                                windSpeed: '',
                                              ),
                                              WeatherForecastCard(
                                                context: context,
                                                day: '4일 후 날씨',
                                                imageUrl: functions.midFcstToImage(MidFcstCall.am4(
                                                  _model.midFcstResponse?.jsonBody,
                                                )),
                                                temperature: MidFcstCall.am4(
                                                  _model.midFcstResponse?.jsonBody ?? '맑음',
                                                ),
                                                precipitation: '강수량:${MidFcstCall.rnSt4Am(
                                                  _model.midFcstResponse?.jsonBody ?? '0',
                                                )?.toString()}mm',
                                                windDirection: '',
                                                windSpeed: '',
                                              ),
                                              WeatherForecastCard(
                                                context: context,
                                                day: '5일 후 날씨',
                                                imageUrl: functions.midFcstToImage(MidFcstCall.am5(
                                                  _model.midFcstResponse?.jsonBody,
                                                )),
                                                temperature: MidFcstCall.am5(
                                                  _model.midFcstResponse?.jsonBody ?? '맑음',
                                                ),
                                                precipitation: '강수량:${MidFcstCall.rnSt5Am(
                                                  _model.midFcstResponse?.jsonBody ?? '0',
                                                )?.toString()}mm',
                                                windDirection: '',
                                                windSpeed: '',
                                              ),
                                              WeatherForecastCard(
                                                context: context,
                                                day: '6일 후 날씨',
                                                imageUrl: functions.midFcstToImage(MidFcstCall.am6(
                                                  _model.midFcstResponse?.jsonBody,
                                                )),
                                                temperature: MidFcstCall.am6(
                                                  _model.midFcstResponse?.jsonBody ?? '맑음',
                                                ),
                                                precipitation: '강수량:${MidFcstCall.rnSt6Am(
                                                  _model.midFcstResponse?.jsonBody ?? '0',
                                                )?.toString()}mm',
                                                windDirection: '',
                                                windSpeed: '',
                                              ),
                                              WeatherForecastCard(
                                                context: context,
                                                day: '7일 후 날씨',
                                                imageUrl: functions.midFcstToImage(MidFcstCall.am7(
                                                  _model.midFcstResponse?.jsonBody,
                                                )),
                                                temperature: MidFcstCall.am7(
                                                  _model.midFcstResponse?.jsonBody ?? '맑음',
                                                ),
                                                precipitation: '강수량:${MidFcstCall.rnSt7Am(
                                                  _model.midFcstResponse?.jsonBody ?? '0',
                                                )?.toString()}mm',
                                                windDirection: '',
                                                windSpeed: '',
                                              ),
                                            ].divide(const SizedBox(
                                                width: 20.0)),
                                          ),
                                        ),
                                    ].divide(
                                        const SizedBox(height: 12.0)),
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(height: 8.0)),
                          )
                        ].divide(const SizedBox(height: 8.0)),
                      ),
                      if(isLoading)
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              color: FlutterFlowTheme.of(context).primaryText,
                              child: const Center(
                                child: SizedBox(
                                  height: 200,
                                  child: PulsatingImage(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery
                              .sizeOf(context)
                              .height * 0.08,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme
                                .of(context)
                                .primaryBackground,
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: wrapWithModel(
                              model: _model.customNavbarModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const CustomNavbarWidget(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class WeatherInfoBox extends StatelessWidget {
  final String title;
  final String value;
  final BuildContext context;

  const WeatherInfoBox({
    Key? key,
    required this.title,
    required this.value,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsetsDirectional
          .fromSTEB(
          0.0, 0.0, 0.0, 4.0),
      child: Material(
        color: Colors.transparent,
        elevation: 4.0,
        shape:
        const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.only(
            bottomLeft:
            Radius.circular(8.0),
            bottomRight:
            Radius.circular(8.0),
            topLeft:
            Radius.circular(8.0),
            topRight:
            Radius.circular(8.0),
          ),
        ),
        child: ClipRRect(
          borderRadius:
          const BorderRadius.only(
            bottomLeft:
            Radius.circular(8.0),
            bottomRight:
            Radius.circular(8.0),
            topLeft:
            Radius.circular(8.0),
            topRight:
            Radius.circular(8.0),
          ),
          child: Container(
            width: MediaQuery
                .sizeOf(
                context)
                .width *
                0.21,
            height: 100.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme
                  .of(context)
                  .primaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4.0,
                  color: Color(
                      0x33000000),
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                )
              ],
              borderRadius:
              const BorderRadius
                  .only(
                bottomLeft:
                Radius.circular(
                    8.0),
                bottomRight:
                Radius.circular(
                    8.0),
                topLeft:
                Radius.circular(
                    8.0),
                topRight:
                Radius.circular(
                    8.0),
              ),
            ),
            alignment:
            const AlignmentDirectional(
                0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: const Color(0xFF1E2224),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).bodyMediumFamily),
                  ),
                ),
                Text(
                  value,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).bodyMediumFamily),
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

class WeatherForecastCard extends StatelessWidget {
  final String day;
  final String? imageUrl;
  final String? temperature;
  final String? precipitation;
  final String? windDirection;
  final String windSpeed;

  const WeatherForecastCard({
    Key? key,
    required this.day,
    this.imageUrl,
    required this.temperature,
    required this.precipitation,
    required this.windDirection,
    required this.windSpeed,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
      child: Material(
        color: Colors.transparent,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Container(
          width: 124,
          decoration: BoxDecoration(
            color: FlutterFlowTheme
                .of(context)
                .primaryBackground,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4, color: Color(0x33000000), offset: Offset(0, 2))
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: FlutterFlowTheme
                      .of(context)
                      .bodyMedium
                      .override(
                    fontFamily:
                    'PretendardSeries',
                    fontSize: 14.0,
                    color: FlutterFlowTheme
                        .of(
                        context)
                        .primaryText,
                    letterSpacing:
                    0.0,
                    fontWeight:
                    FontWeight
                        .w700,
                    useGoogleFonts: GoogleFonts
                        .asMap()
                        .containsKey(
                        'PretendardSeries'),
                  ),
                ),
                Image.network(
                  imageUrl ??
                      'https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%EB%82%A0%EC%94%A8%EC%9E%84%EC%8B%9C%2F%EB%A7%91%EC%9D%8C.png?alt=media&token=f967054c-0b4c-45ee-8364-3e928f218edf',
                  width: MediaQuery
                      .sizeOf(context)
                      .width * 0.2,
                  height: 73,
                  fit: BoxFit.cover,
                ),
                Text(
                  temperature ?? '예보 응답없음',
                  style: FlutterFlowTheme
                      .of(context)
                      .bodyMedium
                      .override(
                    fontFamily:
                    'PretendardSeries',
                    fontSize: 13.5,
                    color: FlutterFlowTheme
                        .of(
                        context)
                        .primaryText,
                    letterSpacing:
                    0.0,
                    fontWeight:
                    FontWeight
                        .w600,
                    useGoogleFonts: GoogleFonts
                        .asMap()
                        .containsKey(
                        'PretendardSeries'),
                  ),
                ),
                Text(
                  precipitation ?? '예보 응답없음',
                  style: FlutterFlowTheme
                      .of(context)
                      .bodyMedium
                      .override(
                    fontFamily:
                    'PretendardSeries',
                    fontSize: 12.0,
                    color: FlutterFlowTheme
                        .of(
                        context)
                        .primaryText,
                    letterSpacing:
                    0.0,
                    fontWeight:
                    FontWeight
                        .w600,
                    useGoogleFonts: GoogleFonts
                        .asMap()
                        .containsKey(
                        'PretendardSeries'),
                  ),
                ),
                Text(
                  windDirection ?? '예보 응답없음',
                  style: FlutterFlowTheme
                      .of(context)
                      .bodyMedium
                      .override(
                    fontFamily:
                    'PretendardSeries',
                    fontSize: 12.0,
                    color: FlutterFlowTheme
                        .of(
                        context)
                        .primaryText,
                    letterSpacing:
                    0.0,
                    fontWeight:
                    FontWeight
                        .w600,
                    useGoogleFonts: GoogleFonts
                        .asMap()
                        .containsKey(
                        'PretendardSeries'),
                  ),
                ),
                Text(
                  windSpeed,
                  style: FlutterFlowTheme
                      .of(context)
                      .bodyMedium
                      .override(
                    fontFamily:
                    'PretendardSeries',
                    fontSize: 12.0,
                    color: FlutterFlowTheme
                        .of(
                        context)
                        .primaryText,
                    letterSpacing:
                    0.0,
                    fontWeight:
                    FontWeight
                        .w600,
                    useGoogleFonts: GoogleFonts
                        .asMap()
                        .containsKey(
                        'PretendardSeries'),
                  ),
                ),
              ].divide(const SizedBox(height: 4)),
            ),
          ),
        ),
      ),
    );
  }
}
