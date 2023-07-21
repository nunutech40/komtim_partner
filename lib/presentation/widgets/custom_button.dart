import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/styles.dart';
import 'debounce_button.dart';

class CustomButton extends DebouncedButton {
  final String text;

  CustomButton({
    Key? key,
    required this.text,
    required VoidCallback onPressed,
    Duration debounceDuration = const Duration(milliseconds: 500),
  }) : super(
          key: key,
          onPressed: onPressed,
          debounceDuration: debounceDuration,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends DebouncedButtonState {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(
            vertical: 11.0, horizontal: 24.0), // Add padding here
      ),
      child: widget.child,
    );
  }
}
