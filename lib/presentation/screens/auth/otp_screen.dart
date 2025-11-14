import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/cubit/auth_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/router/route_string.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Text(
                    'We Have Sent An OTP On Your Number',
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
                        context.read<AuthCubit>().verifyCode(
                          verificationId: widget.verificationId,
                          smsCode: pinController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
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
                              "confirm code",
                              style: TextStyle(color: AppColors.white),
                            );
                          }
                        },
                        listener: (BuildContext context, AuthState state) {
                          if (state is AuthLogedIn) {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteString.home,
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
