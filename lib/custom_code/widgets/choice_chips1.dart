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

class ChoiceChips1 extends StatefulWidget {
  const ChoiceChips1({
    super.key,
    this.width,
    this.height,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    required this.selectedBorderColor,
    required this.unselectedBorderColor,
    required this.options,
  });

  final double? width;
  final double? height;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final List<String> options;

  @override
  State<ChoiceChips1> createState() => _ChoiceChips1State();
}

class _ChoiceChips1State extends State<ChoiceChips1> {
  List<String> allOptions = [];
  List<String> selectedOptions = [];

  void _handleChoiceChipSelection(String option) {
    setState(() {
      if (option == '전체') {
        if (selectedOptions.contains('전체')) {
          selectedOptions.clear();
        } else {
          selectedOptions = List.from(widget.options);
        }
      } else {
        if (selectedOptions.contains(option)) {
          selectedOptions.remove(option);
        } else {
          selectedOptions.add(option);
        }

        if (selectedOptions.length == widget.options.length - 1 &&
            !selectedOptions.contains('전체')) {
          selectedOptions.add('전체');
        } else if (selectedOptions.length != widget.options.length) {
          selectedOptions.remove('전체');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.options.map((option) {
        bool isSelected = selectedOptions.contains(option);
        return ChoiceChip(
          label: Text(
            option,
            style: TextStyle(
              color: isSelected
                  ? widget.selectedTextColor
                  : widget.unselectedTextColor,
            ),
          ),
          selected: isSelected,
          selectedColor: widget.selectedBackgroundColor,
          backgroundColor: widget.unselectedBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected
                  ? widget.selectedBorderColor
                  : widget.unselectedBorderColor,
            ),
          ),
          onSelected: (selected) {
            _handleChoiceChipSelection(option);
          },
        );
      }).toList(),
    );
  }
}
