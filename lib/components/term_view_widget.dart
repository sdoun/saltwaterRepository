import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'term_view_model.dart';
export 'term_view_model.dart';

class TermViewWidget extends StatefulWidget {
  const TermViewWidget({
    super.key,
    required this.termsType,
  });

  final String termsType;

  @override
  State<TermViewWidget> createState() => _TermViewWidgetState();
}

class _TermViewWidgetState extends State<TermViewWidget> {
  late TermViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermViewModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TBServiceTermsRecord>>(
      stream: queryTBServiceTermsRecord(
        queryBuilder: (q) => q.where('terms_title', isEqualTo: widget.termsType),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final terms = snapshot.data!;
        if (terms.isEmpty) {
          return Container(
            width: double.infinity,
            height: 360.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: const Center(
              child: Text('약관을 불러올 수 없습니다.'),
            ),
          );
        }

        final term = terms.first;
        return Container(
          width: double.infinity,
          height: 360.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Text(
                          term.termsTitle ?? '',
                          style: FlutterFlowTheme.of(context).titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 16.0, 0.0),
                        child: Text(
                          term.termsContent ?? '',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1.0, -1.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 8.0, 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
