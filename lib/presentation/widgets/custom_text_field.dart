import 'package:flutter/material.dart';
import 'package:komtim_partner/common/styles.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        _hasFocus ? primaryColor : Colors.grey; // Adjust the border color

    return TextField(
      focusNode: _focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor, // Set the border color
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 2.0,
          ),
        ),
        labelText: widget.label,
        labelStyle: TextStyle(
          color: _hasFocus ? primaryColor : Colors.black,
          fontSize: 16,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: borderColor, // Set the same color as the border
          fontSize: 16,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
