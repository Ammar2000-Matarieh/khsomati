import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/auth/auth_cubit.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/translation/app_translation.dart';
import 'package:khsomati/router/route_string.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final t = context.read<LocalizationCubit>().translate;
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Verification Code",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 80),
                  Lottie.asset("assets/lotties/OTP Verification.json"),
                  Text(
                    t(AppTranslation.weHaveSentAnOTPOnYourNumber),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004445),
                    ),
                  ),

                  SizedBox(height: 30),

                  Center(
                    child: Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,

                      onCompleted: (value) {
                        print("OTP: $value");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Code Entered: $value")),
                        );
                      },

                      defaultPinTheme: PinTheme(
                        height: 60,
                        width: 50,
                        textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // if()
                        //context.read<AuthCubit>().verifyCode(
                        //   verificationId: widget.verificationId,
                        //   smsCode: pinController.text,
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.teal,
                      ),
                      child: BlocConsumer<AuthCubit, AuthState>(
                        builder: (BuildContext context, AuthState state) {
                          if (state is AuthLoading) {
                            return CircularProgressIndicator(
                              color: AppColors.white,
                            );
                          } else {
                            return Text(
                              t(AppTranslation.confirmcode),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                        listener: (BuildContext context, AuthState state) {
                          if (state is AuthLogedIn) {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteString.layout,
                            );
                          } else if (state is AuthUserNotExists) {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteString.personaldetails,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
