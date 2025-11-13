import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/cubit/auth_cubit.dart';
import 'package:khsomati/presentation/widget/text_form_felid.dart';
import 'package:khsomati/router/route_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKay = GlobalKey<FormState>();
    TextEditingController phoneNumber = TextEditingController();

    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKay,
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome To Khosomati Sales',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Enter Mobile Number',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.05),

                  CustemTextFormFelid(
                    controller: phoneNumber,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Phone Number';
                      } else if (value.length < 9) {
                        return 'Phone number too short';
                      }
                      return null;
                    },
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.phone, color: Colors.grey),
                  ),

                  SizedBox(height: h * 0.05),
                  SizedBox(
                    height: 55,
                    width: w,

                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKay.currentState!.validate()) {
                          context.read<AuthCubit>().sendCode(
                            phone: phoneNumber.text.trim(),
                          );
                        }
                      },
                      child: BlocConsumer<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return CircularProgressIndicator();
                          } else {
                            return Text("Login");
                          }
                        },
                        listener: (BuildContext context, AuthState state) {
                          if (state is AuthLogedIn) {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteString.home,
                            );
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            print(state.message);
                          } else if (state is CodeSentState) {
                          //  Navigator.pushReplacementNamed(
                          //     context,
                          //     RouteString.otpScreen,
                          //   );
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
