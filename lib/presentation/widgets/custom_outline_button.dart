import 'package:flutter/material.dart';
import 'package:komtim_partner/common/styles.dart';

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
          color: errorColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: errorColor, // This sets the text color and icon color
        side: BorderSide(color: errorColor, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 24.0),
      ),
    );
  }
}
