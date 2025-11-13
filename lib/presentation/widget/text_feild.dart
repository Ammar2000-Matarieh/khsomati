import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khsomati/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.style,
    this.onTap,
    this.filled,
    this.onSaved,
    this.maxLines,
    this.minLines,
    this.textAlign,
    this.fillColor,
    this.hintStyle,
    this.validator,
    this.labelText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.errorMaxLines,
    this.textInputAction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onEditingComplete,
    required this.hintText,
    this.obscureText = false,
    this.obscuringCharacter = '★',
    this.cursorColor = AppColors.primaryColor,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.contentPadding = const EdgeInsets.fromLTRB(20, 10, 20, 10),
  });

  final bool? filled;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final String hintText;
  final Color? fillColor;
  final TextStyle? style;
  final bool obscureText;
  final String? labelText;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? errorMaxLines;
  final TextStyle? hintStyle;
  final TextAlign? textAlign;
  final void Function()? onTap;
  final String obscuringCharacter;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final AutovalidateMode autovalidateMode;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      onTap: onTap,
      onSaved: onSaved,
      minLines: minLines,
      readOnly: readOnly!,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      maxLines: maxLines ?? 1,
      obscureText: obscureText,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      obscuringCharacter: obscuringCharacter,
      textAlign: textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        filled: filled,
        hintText: hintText,
        hintStyle: hintStyle,
        fillColor: fillColor,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorMaxLines: errorMaxLines,
        contentPadding: contentPadding,
      ),
    );
  }
}
