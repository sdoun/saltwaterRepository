// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import '';

class DateTimeRangePicker extends StatefulWidget {
  const DateTimeRangePicker({
    super.key,
    this.width,
    this.height,
    this.initialStartDate,
    this.initialEndDate,
    this.updatePageUI,
    this.fontColor,
    this.backgroundColor,
    this.outlineColor,
    this.outlineWidth,
    this.pickerWidth,
    this.pickerHeight,
    this.dateYear,
  });

  final double? width;
  final double? height;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Future Function()? updatePageUI;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final int? outlineWidth;
  final int? pickerWidth;
  final int? pickerHeight;
  final int? dateYear;

  @override
  State<DateTimeRangePicker> createState() => _DateTimeRangePickerState();
}

class _DateTimeRangePickerState extends State<DateTimeRangePicker> {
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    if (widget.initialEndDate != null && widget.initialStartDate != null) {
      selectedDateRange = DateTimeRange(
          start: widget.initialStartDate!, end: widget.initialEndDate!);
    }
  }

  void showCustomDateRangePicker() async {
    final now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(widget.dateYear ?? now.year - 1),
      lastDate: DateTime(widget.dateYear ?? now.year + 1),
      initialDateRange: selectedDateRange,
      builder: (context, child) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: widget.pickerHeight?.toDouble() ??
                  MediaQuery.of(context).size.height * 0.7,
              maxWidth: widget.pickerWidth?.toDouble() ??
                  MediaQuery.of(context).size.width * 0.9,
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
        FFAppState().startDate = picked.start;
        FFAppState().endDate = picked.end;
      });

      // Use a state management solution instead of directly modifying FFAppState
      // For example, if using Provider:
      // context.read<AppStateProvider>().updateDateRange(picked);

      // Call updatePageUI only if it's not null
      widget.updatePageUI?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: widget.width ?? 100, // 최소 너비
        maxWidth: 300, // 최대 너비
      ),
      height: widget.height ?? 50.0,
      child: ElevatedButton(
        onPressed: showCustomDateRangePicker,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: selectedDateRange != null &&
                  FFAppState().endDate != null &&
                  FFAppState().startDate != null
              ? Text(
                  '${DateFormat('MM-dd').format(selectedDateRange!.start)} ~ ${DateFormat('MM-dd').format(selectedDateRange!.end)}',
                  style: TextStyle(
                    color: widget.fontColor ??
                        Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                )
              : Text(
                  '날짜선택',
                  style: TextStyle(
                    color: widget.fontColor ??
                        Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: widget.outlineColor ?? Colors.black,
              width: widget.outlineWidth?.toDouble() ?? 0,
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
