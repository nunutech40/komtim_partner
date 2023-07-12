import 'package:flutter/material.dart';

import '../../common/styles.dart';

class CustomButtonSmall extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButtonSmall({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(
            vertical: 5.0, horizontal: 24.0), // Add padding here
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
