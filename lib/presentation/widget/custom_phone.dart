import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:khsomati/constants/app_colors.dart';

class CustomPhoneTextField extends StatelessWidget {
  const CustomPhoneTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: IntlPhoneField(
        controller: controller,
        initialCountryCode: "JO",
        showDropdownIcon: true,
        dropdownIconPosition: IconPosition.trailing,
        invalidNumberMessage: "Invalid phone number",

        decoration: InputDecoration(
          hintText: "Mobile Number",
          // labelText: "Mobile Number",
          labelStyle: TextStyle(color: AppColors.primary),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),

        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),

        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),
    );
  }
}
