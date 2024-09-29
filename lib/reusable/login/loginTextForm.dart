import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class LoginTextForm extends StatefulWidget {
  LoginTextForm({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.isPassword,
    required this.autofillHints,
    this.keyboardType,
    this.validator,
    required this.icon});

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final bool isPassword;
  final List<String> autofillHints;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? icon;


  @override
  State<LoginTextForm> createState() => _LoginTextFormState();
}

class _LoginTextFormState extends State<LoginTextForm> {

  bool obscureText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isPassword){
      bool obscureText = true;
    }
    return Padding(
      padding: const EdgeInsetsDirectional
          .fromSTEB(
          0.0, 0.0, 0.0, 16.0),
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: true,
          autofillHints: const [
            AutofillHints.email
          ],
          obscureText: false,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: FlutterFlowTheme.of(context).bodyLarge.override(
              fontFamily:
              'PretendardSeries',
              color: FlutterFlowTheme.of(context)
                  .secondaryText,
              fontSize: 15.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w400,
              useGoogleFonts: GoogleFonts.asMap().containsKey(
                  'PretendardSeries'),
            ),
            enabledBorder:
            OutlineInputBorder(
              borderSide: BorderSide(
                color:
                FlutterFlowTheme.of(
                    context)
                    .primaryText,
                width: 2.0,
              ),
              borderRadius:
              BorderRadius.circular(
                  12.0),
            ),
            focusedBorder:
            OutlineInputBorder(
              borderSide: BorderSide(
                color:
                FlutterFlowTheme.of(
                    context)
                    .primary,
                width: 2.0,
              ),
              borderRadius:
              BorderRadius.circular(
                  12.0),
            ),
            errorBorder:
            OutlineInputBorder(
              borderSide: BorderSide(
                color:
                FlutterFlowTheme.of(
                    context)
                    .error,
                width: 2.0,
              ),
              borderRadius:
              BorderRadius.circular(
                  12.0),
            ),
            focusedErrorBorder:
            OutlineInputBorder(
              borderSide: BorderSide(
                color:
                FlutterFlowTheme.of(
                    context)
                    .error,
                width: 2.0,
              ),
              borderRadius:
              BorderRadius.circular(
                  12.0),
            ),
            contentPadding:
            const EdgeInsets.all(20.0),
            suffixIcon: widget.isPassword ?
            InkWell(
              onTap: (){
                setState((){
                  obscureText = !obscureText;
                });
              },
              child: widget.icon,
            ) : null,
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
            fontFamily:
            'PretendardSeries',
            color: FlutterFlowTheme.of(context)
                .secondaryText,
            fontSize: 15.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w400,
            useGoogleFonts: GoogleFonts.asMap().containsKey(
                'PretendardSeries'),
          ),
          keyboardType: widget.keyboardType ?? TextInputType
              .emailAddress,
          cursorColor:
          FlutterFlowTheme.of(
              context)
              .primary,
          validator: widget.validator,
        ),
      ),
    );
  }
}
