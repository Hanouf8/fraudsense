import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.keyboardType,
    this.controller,
    this.validator,
    this.maxLines,
    this.fillColor,
    required this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.inputFormatters,
  });

  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final Color? fillColor;
  final String hintText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: inputFormatters,
        obscureText: obscureText ?? false,
        maxLines: maxLines,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          fillColor: fillColor ?? Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 203, 240, 179),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 203, 240, 179),
              )),
        ));
  }
}
