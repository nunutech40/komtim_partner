import 'package:flutter/material.dart';

import '../../common/styles.dart';

class CustomPasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;

  const CustomPasswordField({
    Key? key,
    required this.label,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;
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
      onChanged: widget.onChanged,
      obscureText: _obscureText,
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
        suffixIcon: IconButton(
          icon: _obscureText
              ? Image.asset('assets/images/ic_eye-slash.png')
              : Image.asset('assets/images/ic_eye.png'),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
