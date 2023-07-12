import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komtim_partner/common/styles.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool onlyNumbers;
  final String textValue;
  final bool isEnable;

  const CustomTextField(
      {Key? key,
      required this.label,
      required this.hint,
      this.onChanged,
      this.errorText,
      this.onlyNumbers = false,
      this.textValue = '',
      this.isEnable = true})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
    _textEditingController = TextEditingController(text: widget.textValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        widget.errorText != null && widget.errorText!.isNotEmpty
            ? errorColor
            : (_hasFocus ? primaryColor : Colors.grey);

    List<TextInputFormatter>? inputFormatters;
    if (widget.onlyNumbers) {
      inputFormatters = <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ];
    }

    return TextField(
      enabled: widget.isEnable,
      controller: _textEditingController,
      focusNode: _focusNode,
      onChanged: (value) {
        if (widget.onlyNumbers) {
          final newValue = value.replaceAll(RegExp('[^0-9]'), '');
          if (newValue != value) {
            widget.onChanged?.call(newValue);
          }
        } else {
          widget.onChanged?.call(value);
        }
      },
      inputFormatters: inputFormatters,
      keyboardType:
          widget.onlyNumbers ? TextInputType.number : TextInputType.text,
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
    );
  }
}
