import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/cubit/auth_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/router/route_string.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKay = GlobalKey<FormState>();
  TextEditingController phoneEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Form(
          key: _formKay,
          child: SingleChildScrollView(
            //s physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    'Welcome To',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      // fontSize: 14,
                      fontSize: w * 0.06,
                      height: 1.0,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    'Khosomati',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      //fontSize: 22.39 ,
                      fontSize: w * 0.1,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                      letterSpacing: 0,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.4),
                Container(
                  width: w,
                  height: h * 0.4,
                  padding: EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                    color: AppColors.primary,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.1),
                      CustomPhoneTextField(controller: phoneEditingController),
                      SizedBox(height: h * 0.05),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKay.currentState!.validate()) {
                              context.read<AuthCubit>().sendCode(
                                phone: phoneEditingController.text.trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            backgroundColor: AppColors.white,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                          ),
                          child: BlocConsumer<AuthCubit, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return CircularProgressIndicator(
                                  color: AppColors.primary,
                                );
                              } else {
                                return Text(
                                  "Login",
                                  style: TextStyle(color: AppColors.primary),
                                );
                              }
                            },
                            listener: (context, state) {
                              if (state is CodeSentState) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteString.otp,
                                  arguments: state.verificationId,
                                );
                              } else if (state is AuthError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPhoneTextField extends StatelessWidget {
  const CustomPhoneTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      cursorColor: AppColors.white,
      controller: controller,
      initialCountryCode: "JO",
      showDropdownIcon: true,
      dropdownIconPosition: IconPosition.trailing,
      invalidNumberMessage: "Invalid phone number",
      decoration: InputDecoration(
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        hint: Text("Mobile Number", style: TextStyle(color: AppColors.white)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.white),
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
}
