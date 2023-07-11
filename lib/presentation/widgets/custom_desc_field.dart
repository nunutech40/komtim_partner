import 'package:flutter/material.dart';

import '../../common/styles.dart';

class CustomDescriptionField extends StatefulWidget {
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const CustomDescriptionField({
    Key? key,
    required this.label,
    required this.hint,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  _CustomDescriptionFieldState createState() => _CustomDescriptionFieldState();
}

class _CustomDescriptionFieldState extends State<CustomDescriptionField> {
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
        widget.errorText != null && widget.errorText!.isNotEmpty
            ? errorColor
            : (_hasFocus ? primaryColor : Colors.grey);

    return SingleChildScrollView(
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: borderColor,
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
            color: borderColor,
            fontSize: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
