import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/components/new_profile_image_model.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/upload_data.dart';

class NewProfileImage extends StatefulWidget {
  const NewProfileImage({super.key});

  @override
  State<NewProfileImage> createState() => _NewProfileImageState();
}

class _NewProfileImageState extends State<NewProfileImage> {
  late NewProfileImageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewProfileImageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }
  Widget uplodedImageView(bool uploaded){
    if(uploaded){
      return Container(
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,

        ),
        clipBehavior: Clip.antiAlias,
        height: 80,
        width: 80,
        child: Image.network(FFAppState().newProfileImage,
          fit: BoxFit.cover,
        ),
      );
    }
    else{
    }
    return Container(
      height: 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
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
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              uplodedImageView((FFAppState().newProfileImage.isNotEmpty)),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      final selectedMedia = await selectMedia(
                        maxWidth: 640.00,
                        maxHeight: 1280.00,
                        multiImage: false,
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every(
                                  (m) => validateFileFormat(m.storagePath, context))) {
                        safeSetState(() => _model.isDataUploading1 = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        List<String> downloadUrls = <String>[];
                        try {
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                            name: m.storagePath.split('/').last,
                            bytes: m.bytes,
                            height: m.dimensions?.height,
                            width: m.dimensions?.width,
                            blurHash: m.blurHash,
                          ))
                              .toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                                  (m) async => await uploadData(m.storagePath, m.bytes),
                            ),
                          ))
                              .where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        } finally {
                          _model.isDataUploading1 = false;
                        }
                        if (selectedUploadedFiles.length == selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          safeSetState(() {
                            _model.uploadedLocalFile1 = selectedUploadedFiles.first;
                            _model.uploadedFileUrl1 = downloadUrls.first;
                          });
                        } else {
                          safeSetState(() {});
                          return;
                        }
                      }

                      FFAppState().newProfileImage = _model.uploadedFileUrl1;
                      safeSetState(() {});
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                          Text(
                            '카메라',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      final selectedMedia = await selectMedia(
                        mediaSource: MediaSource.photoGallery,
                        multiImage: false,
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every(
                                  (m) => validateFileFormat(m.storagePath, context))) {
                        safeSetState(() => _model.isDataUploading2 = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];

                        var downloadUrls = <String>[];
                        try {
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                            name: m.storagePath.split('/').last,
                            bytes: m.bytes,
                            height: m.dimensions?.height,
                            width: m.dimensions?.width,
                            blurHash: m.blurHash,
                          ))
                              .toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                                  (m) async => await uploadData(m.storagePath, m.bytes),
                            ),
                          ))
                              .where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        } finally {
                          _model.isDataUploading2 = false;
                        }
                        if (selectedUploadedFiles.length == selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          safeSetState(() {
                            _model.uploadedLocalFile2 = selectedUploadedFiles.first;
                            _model.uploadedFileUrl2 = downloadUrls.first;
                          });
                        } else {
                          safeSetState(() {});
                          return;
                        }
                      }

                      FFAppState().newProfileImage = _model.uploadedFileUrl2;;
                      safeSetState(() {});
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_open,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                          Text(
                            '파일 업로드',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ].divide(const SizedBox(width: 12.0)),
              ),
            ]
          )
        ),
      ),
    );
  }
}
