import 'package:flutter/material.dart';
import 'package:salt_water_beta_ver1/flutter_flow/flutter_flow_util.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '../../pages/point_explore_sum/map_type_select/map_type_select_widget.dart';

class Mapselectbutton extends StatefulWidget {
  const Mapselectbutton({super.key, this.onSelected});
  final onSelected;


  @override
  State<Mapselectbutton> createState() => _MapselectbuttonState();
}

class _MapselectbuttonState extends State<Mapselectbutton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          0.0, 8.0, 8.0, 0.0),
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
                      FocusScope.of(context)
                          .unfocus(),
                  child: Padding(
                    padding:
                    MediaQuery.viewInsetsOf(
                        context),
                    child:
                    MapTypeSelectWidget(
                      onMapSeleted: widget.onSelected,
                    ),
                  ),
                ),
              );
            },
          ).then(
                  (value) => safeSetState(() {}));
        },
        child: Container(
          width:
          MediaQuery.sizeOf(context).width *
              0.08,
          height:
          MediaQuery.sizeOf(context).width *
              0.08,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/지도모드.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
