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
        body: Form(
          key: _formKay,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 100),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Welcome To Khosomati Sales',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF004445),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Enter Mobile Number',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF004445),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '+962',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: CustemTextFormFelid(
                                controller: phoneNumber,
                                keyboardType: TextInputType.number,
                                hintText: 'Enter your phone number',
                                labelText: 'Enter your phone number',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Phone Number';
                                  } else if (value.length < 9) {
                                    return 'Phone number too short';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKay.currentState!.validate()) {
                              context.read<AuthCubit>().sendCode(
                                phone: phoneNumber.text.trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF004445),
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
                                  color: Colors.white,
                                );
                              } else {
                                return Text("Login");
                              }
                            },
                            listener: (context, state) {
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
        ),
      ),
    );
  }
}
