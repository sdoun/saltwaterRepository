import '../../components/custom_navbar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeSearchpage extends StatefulWidget {
  const HomeSearchpage({super.key});


  @override
  State<HomeSearchpage> createState() => _HomeSearchpageState();
}

class _HomeSearchpageState extends State<HomeSearchpage> {
  FocusNode searchTextFieldFocusNode = FocusNode();
  TextEditingController searchTextController = TextEditingController();
  String? Function(BuildContext, String?)? searchTextControllerValidator;

  @override
  void initState(){
    super.setState(() {

    });
    searchTextController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
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
                '검색하기',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily:
                  FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: Colors.black,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineMediumFamily),
                ),
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 2.0,
        ),
        body: SafeArea(
            child: Container(
              color: FlutterFlowTheme.of(context).primaryBackground,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border(
                                      top: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                      left: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                      right: BorderSide(color: FlutterFlowTheme.of(context).primary),
                                      bottom: BorderSide(color: FlutterFlowTheme.of(context).primary)
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 8, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: searchTextController,
                                        focusNode: searchTextFieldFocusNode,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: '검색어를 입력해주세요.',
                                          hintStyle: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent
                                              )
                                          ),
                                          border: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent
                                            )
                                          ),
                                          focusedErrorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context).error,
                                              width: 2.0,
                                            ),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .bodyMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                        ),
                                        validator: searchTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        FFAppState().recentSearch.remove(searchTextController.text);
                                        if(searchTextController.text != '')
                                          FFAppState().insertAtIndexInRecentSearch(
                                              0, searchTextController.text);
                                        safeSetState(() {});
                                        context.pushNamed('homeSearchResult', queryParameters: {
                                          'searchText' : searchTextController.text
                                        });
                                      },
                                      child: Container(
                                        width: 32.0,
                                        height: 32.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/beyv2_.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset('assets/images/최근검색어.png'),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '최근검색어',
                                    style: FlutterFlowTheme.of(context).bodyMedium
                                      .override(
                                    fontFamily: 'PretendardSeries',
                                    fontSize: 14.0,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    letterSpacing:
                                    0.0,
                                    fontWeight: FontWeight.w400,
                                    useGoogleFonts: GoogleFonts
                                        .asMap()
                                        .containsKey(
                                        'PretendardSeries'),
                                  ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child:  Builder(
                                    builder: (context) {
                                      final recentSearch = FFAppState().recentSearch.toList();

                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: List.generate(recentSearch.length,
                                                (recentSearchIndex) {
                                              final recentSearchItem =
                                              recentSearch[recentSearchIndex];
                                              return InkWell(
                                                onTap: (){
                                                  searchTextController.text = recentSearchItem;
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      recentSearchItem,
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
                                                    FlutterFlowIconButton(
                                                      borderColor: Colors.transparent,
                                                      borderRadius: 20.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 32.0,
                                                      fillColor: FlutterFlowTheme.of(context)
                                                          .primaryBackground,
                                                      icon: Icon(
                                                        Icons.block,
                                                        color: FlutterFlowTheme.of(context)
                                                            .primaryText,
                                                        size: 20.0,
                                                      ),
                                                      onPressed: () async {
                                                        FFAppState().removeAtIndexFromRecentSearch(
                                                            recentSearchIndex);
                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).divide(const SizedBox(height: 8.0)),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.08,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: wrapWithModel(
                        model: CustomNavbarModel(),
                        updateCallback: () => safeSetState(() {}),
                        child: const CustomNavbarWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
