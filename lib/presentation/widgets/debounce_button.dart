import 'dart:async';
import 'package:flutter/material.dart';

class DebouncedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Duration debounceDuration;

  DebouncedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.debounceDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  DebouncedButtonState createState() => DebouncedButtonState();
}

class DebouncedButtonState extends State<DebouncedButton> {
  bool _isProcessing = false;
  Timer? _debounceTimer;

  void handleTap() {
    if (_isProcessing) return;

    _isProcessing = true;
    widget.onPressed();

    _debounceTimer = Timer(widget.debounceDuration, () {
      _isProcessing = false;
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleTap,
      child: widget.child,
    );
  }
}
