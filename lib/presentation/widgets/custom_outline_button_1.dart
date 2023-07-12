import 'package:flutter/material.dart';

class CustomOutlineButton1 extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomOutlineButton1({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey, // text color
        side: const BorderSide(color: Colors.grey, width: 1), // border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 24.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
