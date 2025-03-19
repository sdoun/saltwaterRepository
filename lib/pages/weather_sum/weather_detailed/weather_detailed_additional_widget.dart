import '../../../models/weatherModels.dart';
import '../../../reusable/common/basicScaffold.dart';
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
import 'package:fl_chart/fl_chart.dart';
import 'package:sunrise_sunset_calc/sunrise_sunset_calc.dart';

class WeatherDetailedAdditional extends StatefulWidget {
  const WeatherDetailedAdditional({
    super.key,
    required this.weatherRef,
  });

  final DocumentReference? weatherRef;

  @override
  State<WeatherDetailedAdditional> createState() => _WeatherDetailedAdditionalState();
}

class _WeatherDetailedAdditionalState extends State<WeatherDetailedAdditional> {
  late WeatherDetailedModel _model;
  bool isLoading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<int> showingTooltipOnSpots = [1, 3, 5];

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
  Future<void> loadTidData(TBWeatherPointRecord record) async{
    setState(() {
      isLoading = true;
    });
    try{
      final result = await TidalFcstCall.call(
        date: _model.tidDateString,
        dataType: 'tideObsPreTab',
        obsCode: record.tidObsCode,
        resultType: 'json',
      );
      _model.tidalFcstResponse = result;
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print('Error detected while calling tidApi $e');
    setState(() {
      isLoading = false;
    });
    }
    return;
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
          numOfRows: 580,
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
        _model.skyModelList = SkyModel.createSkyList(_model.fcstWeatherResponse?.jsonBody);
        _model.windDirectionModelList = SkyModel.createWindDirectionList(_model.fcstWeatherResponse?.jsonBody);
        _model.tmpModelList = SkyModel.createTmpList(_model.fcstWeatherResponse?.jsonBody);
        _model.wsdModelList = SkyModel.createWsdList(_model.fcstWeatherResponse?.jsonBody);
        _model.pcpModelList = SkyModel.createPcpList(_model.fcstWeatherResponse?.jsonBody);
        _model.popModelList = SkyModel.createPopList(_model.fcstWeatherResponse?.jsonBody);
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
  FlSpot createFlSpot(SkyModel data){
    double dataX = data.itemNum.toDouble();//double.parse(data.fcstDate + data.fcstTime);
    FlSpot spot = FlSpot(dataX, double.parse(data.fcstValue));
    return spot;
  }

  List<FlSpot> createGraphDot(List<SkyModel> dataList){
    List<FlSpot> result = [];

    final data = dataList;
    for(SkyModel item in data){
      result.add(createFlSpot(item));
    }
    return result;
  }

  BarChartGroupData createBar(SkyModel data){
    return BarChartGroupData(
      x: data.itemNum,
      barRods: [BarChartRodData(toY: double.parse(data.fcstValue), color: FlutterFlowTheme.of(context).primary, borderRadius: BorderRadius.circular(0), width: 16)],
      showingTooltipIndicators: [0],
    );
  }
  List<BarChartGroupData> createBarList(List<SkyModel> data){
    List<BarChartGroupData> result = [];
    for(final item in data){
      final bar = createBar(item);
      result.add(bar);
    }
    return result;
  }

  BarChartGroupData createWSDBar(SkyModel data){
    return BarChartGroupData(
      x: data.itemNum,
      barRods: [BarChartRodData(toY: double.parse(data.fcstValue), color: const Color(0xffDDEFFF), borderRadius: BorderRadius.circular(0), width: 16)],
      showingTooltipIndicators: [0],
    );
  }
  List<BarChartGroupData> createWSDBarList(List<SkyModel> data){
    List<BarChartGroupData> result = [];
    for(final item in data){
      final bar = createWSDBar(item);
      result.add(bar);
    }
    return result;
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TBWeatherPointRecord>(
      stream: TBWeatherPointRecord.getDocument(widget.weatherRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Basicscaffold(
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
        final tmpGraphDots = createGraphDot(_model.tmpModelList ?? []);
        final lineBarsData =
          LineChartBarData(
              dotData: FlDotData(show: true),
              showingIndicators: [0,1,2,3,4,5,6,7,8,9],
              color: FlutterFlowTheme.of(context).secondaryText,
              spots: tmpGraphDots,
              belowBarData: BarAreaData(show: false),
              aboveBarData: BarAreaData(show:false),
          );
        final wsdBarData = createBarList(_model.wsdModelList);
        final pcpBarData = createBarList(_model.pcpModelList);


        return Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Basicscaffold(
                key: scaffoldKey,
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
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
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
                                          const SizedBox(
                                              width: 16
                                          ),
                                          InkWell(
                                            onTap: ()async{
                                              context.goNamed('weatherDetailed', queryParameters: {
                                                'weatherRef': serializeParam(
                                                  weatherDetailedTBWeatherPointRecord.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,);
                                            },
                                            child: Text(
                                              '날씨 간략히보기',
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
                                                    .primary,
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                decoration: TextDecoration.underline,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterFlowTheme
                                                        .of(
                                                        context)
                                                        .bodyMediumFamily),
                                              ),
                                            ),
                                          )
                                        ],
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
                                                )?[3] ?? '15'}℃',
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
                          if(!isLoading)

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '날씨',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                      color: const Color(0xFF1E2224),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                                          FlutterFlowTheme.of(context).bodyMediumFamily),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: _model.skyModelList == null || _model.skyModelList!.isEmpty
                                        ? Text(
                                        "데이터가 없습니다.",
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                        color: const Color(0xFF1E2224),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                      ),
                                    )
                                        : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              height: 120,
                                              width: 52*_model.skyModelList!.length.toDouble()-16,
                                              child: LineChart(
                                                LineChartData(
                                                  borderData: FlBorderData(show: false),
                                                  minY: double.parse(_model.tmpModelList![0].fcstValue) - 12,
                                                  maxY: double.parse(_model.tmpModelList![0].fcstValue) + 12,
                                                  lineBarsData: [lineBarsData],
                                                  titlesData: FlTitlesData(
                                                      topTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: true,
                                                          reservedSize: 30,
                                                          getTitlesWidget: (value, meta) {
                                                            if (value >= 0 && value < _model.tmpModelList!.length) {
                                                              return Text(
                                                                double.parse(_model.tmpModelList![value.toInt()].fcstValue).toString() + '℃',
                                                                style: FlutterFlowTheme.of(context).bodyMedium
                                                                    .override(
                                                                  fontFamily: 'PretendardSeries',
                                                                  fontSize: 14.0,
                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight: FontWeight.w500,
                                                                  useGoogleFonts: GoogleFonts
                                                                      .asMap()
                                                                      .containsKey(
                                                                      'PretendardSeries'),
                                                                ),
                                                              );
                                                            }
                                                            return Text('2');
                                                          },
                                                        ),
                                                      ),
                                                    leftTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: true,
                                                          getTitlesWidget: (value, meta){
                                                              return Text(
                                                              ' ℃',
                                                              style: FlutterFlowTheme.of(context).bodyMedium
                                                                  .override(
                                                                fontFamily: 'PretendardSeries',
                                                                fontSize: 14.0,
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight: FontWeight.w500,
                                                                useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                    .containsKey(
                                                                    'PretendardSeries'),
                                                              ),
                                                            );

                                                          }
                                                        )
                                                    ),
                                                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))
                                                  ),
                                                  lineTouchData: LineTouchData(
                                                    touchTooltipData: LineTouchTooltipData(
                                                      getTooltipColor: (LineBarSpot touchedBarSpot){
                                                        return FlutterFlowTheme.of(context).primaryBackground;
                                                      },
                                                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                                        return touchedBarSpots.map((barSpot) {
                                                          final flSpot = barSpot;
                                                          return LineTooltipItem(
                                                            '${flSpot.y.toStringAsFixed(2)}℃',
                                                              FlutterFlowTheme.of(context).bodyMedium
                                                                  .override(
                                                                fontFamily: 'PretendardSeries',
                                                                fontSize: 14.0,
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight: FontWeight.w500,
                                                                useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                    .containsKey(
                                                                    'PretendardSeries'),
                                                              ),
                                                          );
                                                        }).toList();
                                                      },
                                                    ),
                                                    touchCallback: (_, __) {},
                                                    handleBuiltInTouches: true,
                                                  ),
                                                    showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                                                      return ShowingTooltipIndicators(
                                                         [
                                                           LineBarSpot(lineBarsData, index, tmpGraphDots[index])
                                                         ]
                                                      );
                                                    }).toList(),
                                                  gridData: FlGridData(show: false),
                                                )
                                              ),
                                            ),
                                            Row(
                                              children:
                                              List.generate(
                                              _model.skyModelList!.length,
                                                  (skyListIndex){
                                                final skyItem = _model.skyModelList![skyListIndex];
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 36,
                                                        height: 36,
                                                        child: Image.network(functions.skyToImageLinkCopy(skyItem.fcstValue.toString())[0]),
                                                      ),
                                                      Text(
                                                          functions.fcstDetailTime(skyItem),
                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                            color: const Color(0xFF1E2224),
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.w500,
                                                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                FlutterFlowTheme.of(context).bodyMediumFamily),
                                                          ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                                                                  ),
                                                                                ),
                                          ],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          if(!isLoading)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '바람',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                      color: const Color(0xFF1E2224),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                                          FlutterFlowTheme.of(context).bodyMediumFamily),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('풍속',
                                                  style: FlutterFlowTheme.of(context).bodyMedium
                                                      .override(
                                                    fontFamily: 'PretendardSeries',
                                                    fontSize: 16.0,
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
                                                Text('', style: FlutterFlowTheme.of(context).bodyMedium
                                                    .override(
                                                  fontFamily: 'PretendardSeries',
                                                  fontSize: 14.0,
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                  letterSpacing:
                                                  0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                      'PretendardSeries'),
                                                ),
                                                ),
                                                SizedBox(height: 8,),
                                              ],
                                            ),
                                            Container(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              height: 80,
                                              width: 64*_model.skyModelList!.length.toDouble()+32,
                                              child: BarChart(
                                                BarChartData(
                                                  backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                    barTouchData: BarTouchData(
                                                      touchTooltipData: BarTouchTooltipData(
                                                        getTooltipColor: (group) => Colors.transparent,
                                                        tooltipPadding: EdgeInsets.zero,
                                                        tooltipMargin: 8,
                                                        getTooltipItem: (
                                                            BarChartGroupData group,
                                                            int groupIndex,
                                                            BarChartRodData rod,
                                                            int rodIndex,
                                                            ) {
                                                          return BarTooltipItem(
                                                            rod.toY.round().toString() + 'm/s',
                                                            FlutterFlowTheme.of(context).bodyMedium
                                                                .override(
                                                              fontFamily: 'PretendardSeries',
                                                              fontSize: 14.0,
                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                              letterSpacing:
                                                              0.0,
                                                              fontWeight: FontWeight.w500,
                                                              useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                                  .containsKey(
                                                                  'PretendardSeries'),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    gridData: FlGridData(show: false),
                                                  maxY: wsdBarData[0].barRods[0].toY + 16,
                                                  barGroups: wsdBarData,
                                                    titlesData: FlTitlesData(show: false),
                                                  borderData: FlBorderData(show:  false)
                                                )
                                              )
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '풍향',
                                              style: FlutterFlowTheme.of(context).bodyMedium
                                                  .override(
                                                fontFamily: 'PretendardSeries',
                                                fontSize: 16.0,
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
                                            SizedBox(
                                                width: 16
                                            ),
                                            Row(
                                              children:
                                              List.generate(
                                                  _model.windDirectionModelList!.length,
                                                      (skyListIndex){
                                                    final vecItem = _model.windDirectionModelList![skyListIndex];
                                                    return Padding(
                                                      padding: EdgeInsets.fromLTRB(15.8, 0, 0, 0),
                                                      child: Container(
                                                        width: 48,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              height: 24,
                                                              child: Image.network(functions.vecStringToImage(functions.vecToString(vecItem.fcstValue))),
                                                            ),
                                                            Text(
                                                              functions.vecToString(vecItem.fcstValue),
                                                              style: FlutterFlowTheme.of(context).bodyMedium
                                                                  .override(
                                                                fontFamily: 'PretendardSeries',
                                                                fontSize: 14.0,
                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight: FontWeight.w500,
                                                                useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                    .containsKey(
                                                                    'PretendardSeries'),
                                                              ),
                                                            ),
                                                            Text(
                                                              functions.fcstDetailTime(vecItem),
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                color: const Color(0xFF1E2224),
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.w500,
                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                    FlutterFlowTheme.of(context).bodyMediumFamily),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if(!isLoading)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '강수',
                                    style: FlutterFlowTheme.of(context).bodyMedium
                                        .override(
                                      fontFamily: 'PretendardSeries',
                                      fontSize: 16.0,
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
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: [
                                          Container(
                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                              height: 96,
                                              width: 64*_model.skyModelList!.length.toDouble()+32,
                                              child: BarChart(
                                                  BarChartData(
                                                      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                      barTouchData: BarTouchData(
                                                        touchTooltipData: BarTouchTooltipData(
                                                          getTooltipColor: (group) => Colors.transparent,
                                                          tooltipPadding: EdgeInsets.zero,
                                                          tooltipMargin: 8,
                                                          getTooltipItem: (
                                                              BarChartGroupData group,
                                                              int groupIndex,
                                                              BarChartRodData rod,
                                                              int rodIndex,
                                                              ) {
                                                            return BarTooltipItem(
                                                              rod.toY.round().toString() + 'mm',
                                                              FlutterFlowTheme.of(context).bodyMedium
                                                                  .override(
                                                                fontFamily: 'PretendardSeries',
                                                                fontSize: 14.0,
                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight: FontWeight.w500,
                                                                useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                    .containsKey(
                                                                    'PretendardSeries'),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      gridData: FlGridData(show: false),
                                                      maxY: wsdBarData[0].barRods[0].toY + 100,
                                                      barGroups: pcpBarData,
                                                      titlesData: FlTitlesData(show: false),
                                                      borderData: FlBorderData(show:  false)
                                                  )
                                              )
                                          ),
                                          Row(
                                            children: List.generate(
                                                _model.skyModelList!.length,
                                                (index){
                                                  final popItem = _model.popModelList[index];
                                                  return Padding(
                                                    padding: EdgeInsets.fromLTRB(15.8, 0, 0, 0),
                                                    child: Container(
                                                      width: 48,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            popItem.fcstValue + '%',
                                                            style: FlutterFlowTheme.of(context).bodyMedium
                                                              .override(
                                                            fontFamily: 'PretendardSeries',
                                                            fontSize: 14.0,
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FontWeight.w500,
                                                            useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                                .containsKey(
                                                                'PretendardSeries'),
                                                          ),
                                                          ),
                                                          Text(
                                                            functions.fcstDetailTime(popItem),
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                              color: const Color(0xFF1E2224),
                                                              fontSize: 14.0,
                                                              fontWeight: FontWeight.w500,
                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                  FlutterFlowTheme.of(context).bodyMediumFamily),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                ),
                                          )
                                        ],
                                      ),
                                  )
                                ],
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
                                              _model.getWaterTime(_model.getLunarDate(DateTime.parse(_model.tidDateString!))),
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
                                                loadTidData(weatherDetailedTBWeatherPointRecord);
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
                                                loadTidData(weatherDetailedTBWeatherPointRecord);
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
