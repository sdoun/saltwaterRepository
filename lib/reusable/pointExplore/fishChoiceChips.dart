import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';

import '../../app_state.dart';
import '../../flutter_flow/flutter_flow_choice_chips.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/form_field_controller.dart';

class Fishchoicechips extends StatefulWidget {
  const Fishchoicechips({super.key, this.controller, this.onChanged, this.chipValues});

  final controller;
  final onChanged;
  final List<String>? chipValues;

  @override
  State<Fishchoicechips> createState() => _FishchoicechipsState();
}

class _FishchoicechipsState extends State<Fishchoicechips> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: FlutterFlowChoiceChips(
        options: const [
          ChipData('돔'),
          ChipData('두족류'),
          ChipData('중상층'),
          ChipData('원투낚시')
        ],
        onChanged: widget.onChanged,
        selectedChipStyle: ChipStyle(
          backgroundColor:
          const Color(0xff949494),
          textStyle: FlutterFlowTheme.of(context)
              .labelLarge
              .override(
            fontFamily: 'PretendardSeries',
            color: FlutterFlowTheme.of(context)
                .primaryBackground,
            letterSpacing: 0.0,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            useGoogleFonts: GoogleFonts.asMap()
                .containsKey('PretendardSeries'),
          ),
          iconColor: const Color(0xff949494),
          iconSize: 18.0,
          elevation: 0.0,
          borderColor: const Color(0xff949494),
          borderRadius: BorderRadius.circular(15.0),
        ),
        unselectedChipStyle: ChipStyle(
          backgroundColor:
          FlutterFlowTheme.of(context)
              .primaryBackground,
          textStyle: FlutterFlowTheme.of(context)
              .bodyMedium
              .override(
            fontFamily: 'PretendardSeries',
            fontSize: 12,
            color: Colors.black,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
            useGoogleFonts: GoogleFonts.asMap()
                .containsKey('PretendardSeries'),
          ),
          iconColor: const Color(0xff666666),
          iconSize: 18.0,
          elevation: 0.0,
          borderColor: const Color(0xff949494),
          borderWidth: 1.0,
          borderRadius: BorderRadius.circular(15.0),
        ),
        chipSpacing: 15.0,
        rowSpacing: 12.0,
        multiselect: true,
        initialized: widget.chipValues != null,
        alignment: WrapAlignment.start,
        controller: widget.controller,
        wrapped: true,
      ),
    );
  }
}
