import 'package:flutter/material.dart';
import 'package:lingopanda/res/color.dart';

class CustomTextField extends StatefulWidget {
   final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final FormFieldValidator<String> validator;
  const CustomTextField(
      {required this.controller,
      required this.hintText,
      this.isPassword = false,
      required this.validator,
      super.key});


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? true : false,
      style: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(size.width * 0.02),
          ),
          filled: true,
          fillColor: AppColors.frontColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.textColor)),
      validator: widget.validator,
    );
  }
}