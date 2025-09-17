import 'package:salt_water_beta_ver1/flutter_flow/upload_data.dart';

import '../../../backend/firebase_storage/storage.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'review_bottomsheet_model.dart';
export 'review_bottomsheet_model.dart';
import '/flutter_flow/custom_functions.dart' as functions;

import 'package:salt_water_beta_ver1/reusable/pointDetailed/review_textform.dart';

class ReviewBottomsheetWidget extends StatefulWidget {
  const ReviewBottomsheetWidget({
    super.key,
    required this.reviewPointRef,
  });

  final DocumentReference? reviewPointRef;

  @override
  State<ReviewBottomsheetWidget> createState() =>
      _ReviewBottomsheetWidgetState();
}

class _ReviewBottomsheetWidgetState extends State<ReviewBottomsheetWidget> {
  late ReviewBottomsheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReviewBottomsheetModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.shortBioTextController ??= TextEditingController();
    _model.shortBioFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 370.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: Container(
                        width: 50.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Text(
                    '  리뷰 작성하기',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                      'PretendardSeries',
                      color: FlutterFlowTheme.of(context)
                          .primaryText,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          'PretendardSeries'),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 120.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Image.network(
                          functions.basicProfile(currentUserPhoto),
                          width: 40.0,
                          height: 40.0,
                          fit: BoxFit.cover,
                        ),
                        
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Text(
                            currentUserDisplayName,
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily:
                              'PretendardSeries',
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  'PretendardSeries'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ReviewTextform(
                  controller: _model.textController1,
                  focusNode: _model.textFieldFocusNode,
                  validator: _model.textController1Validator.asValidator(context),
                  hintText: '제목을 입력해주세요.',
                ),
                InkWell(
                  onTap: () async{
                      final selectedMedia = await selectMedia(
                        maxWidth: 640.00,
                        maxHeight: 1280.00,
                        multiImage: true,
                      );
                      if(selectedMedia != null && selectedMedia.every((m)
                          => validateFileFormat(m.storagePath, context)
                      )){
                        safeSetState((){
                          _model.isImageUploaing = true;
                        });
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        List<String> downloadUrls = <String>[];
                        try{

                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                            name: m.storagePath.split('/').last,
                            bytes: m.bytes,
                            height: m.dimensions?.height ?? 144,
                            width: m.dimensions?.width ?? 144,
                            blurHash: m.blurHash ?? '',
                          )).toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                                  (m) async => await uploadData(m.storagePath, m.bytes),
                            ),
                          )).where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        }finally {
                          _model.isImageUploaing = false;
                        }
                        if (selectedUploadedFiles.length == selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          print(selectedUploadedFiles);
                          safeSetState(() {
                            _model.uploadedImages += selectedUploadedFiles;
                            _model.uploadedImageUrls += downloadUrls;
                          });
                        } else {
                          safeSetState(() {});
                          return;
                        }
                        print('업로드 이미지 길이${_model.uploadedImages.length}');
                      }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    width: 108,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_open,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                '이미지 추가',
                                  style: GoogleFonts.getFont(
                                    'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.0,
                                    //height: 1.3,
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if(_model.uploadedImageUrls.isNotEmpty)
                SizedBox(
                  height: 144,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListView.builder(
                    itemCount: _model.uploadedImageUrls.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      final imageUrlLIst = _model.uploadedImageUrls;
                      final imageUrl = imageUrlLIst[index];
                      return Row(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                  height: 144,
                                  //width: 144,
                                  child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.fitHeight
                                  )
                              ),
                              Padding(
                                padding: EdgeInsetsGeometry.all(0),
                                child: InkWell(
                                  onTap: () {
                                    print('uploded Images ${_model.uploadedImages}');
                                    if(_model.uploadedImages.isNotEmpty
                                        && _model.uploadedImageUrls.isNotEmpty){
                                      safeSetState((){
                                        _model.uploadedImages.removeAt(index);
                                        _model.uploadedImageUrls.removeAt(index);
                                      });
                                    }

                                  },
                                  child: Icon(
                                    Icons.highlight_remove,
                                    size: 36,
                                    color: FlutterFlowTheme.of(context).error,
                                  ),
                                )
                              )
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: ReviewTextform(
                    controller: _model.shortBioTextController,
                    focusNode: _model.shortBioFocusNode,
                    validator: _model.shortBioTextControllerValidator.asValidator(context),
                    hintText: '내용을 입력해주세요.',
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 44.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await TBUserReviewPointRecord.createDoc(
                                  widget.reviewPointRef!)
                              .set(createTBUserReviewPointRecordData(
                            reviewTitle: _model.textController1.text,
                            reviewWrittenBy: currentUserReference,
                            reviewText: _model.shortBioTextController.text,
                            timestamp: Timestamp.fromDate(DateTime.now()),
                            reviewImages: _model.uploadedImageUrls.isEmpty ?
                              ['https://firebasestorage.googleapis.com/v0/b/salt-water-beta-ver1-4dujup.appspot.com/o/%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%88%98%EC%A0%95%ED%8E%98%EC%9D%B4%EC%A7%80%2F%ED%8F%AC%EC%9D%B8%ED%8A%B8%EC%9D%B4%EB%AF%B8%EC%A7%80%EC%97%86%EC%9D%8C.png?alt=media&token=b357c611-3df0-4134-bf83-6d72fa96b82e']
                              : _model.uploadedImageUrls
                          ));
                          Navigator.pop(context);
                        },
                        text: '작성 완료',
                        options: FFButtonOptions(
                          width: 150.0,
                          height: 30.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                            'PretendardSeries',
                            color: Colors.white,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                'PretendardSeries'),
                          ),
                          elevation: 3.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ].divide(const SizedBox(height: 8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
