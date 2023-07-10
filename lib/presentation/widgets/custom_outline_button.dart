import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget icon;

  const CustomOutlineButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon, // Add your icon here
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        primary: Colors.red, // This sets the text color and icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.red, width: 2), // Add the border here
        ),
        padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 24.0),
      ),
    );
  }
}
