import 'package:flutter/material.dart';
import 'package:khsomati/presentation/screens/about_the_app.dart';
import 'package:khsomati/presentation/screens/add_product_screen/add_products_screen.dart';
import 'package:khsomati/presentation/screens/auth/login_screen.dart';
import 'package:khsomati/presentation/screens/auth/otp_screen.dart';
import 'package:khsomati/presentation/screens/home_screen.dart';
import 'package:khsomati/presentation/screens/layout_screen.dart';
import 'package:khsomati/presentation/screens/onboarding_screen.dart';
import 'package:khsomati/presentation/screens/personal_details.dart';
import 'package:khsomati/presentation/screens/privacy_police.dart';
import 'package:khsomati/presentation/screens/splash_screen.dart';
import 'package:khsomati/presentation/screens/support_screen.dart';
import 'package:khsomati/presentation/screens/view_product.dart';
import 'package:khsomati/router/route_string.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  RouteString.splash: (context) => SplashScreen(),
  RouteString.onBoarding: (context) => OnBoardingScreen(),
  RouteString.login: (context) => LoginScreen(),
  RouteString.otp: (context) {
    final verificationId = ModalRoute.of(context)!.settings.arguments as String;

    return OtpScreen(verificationId: verificationId);
  },

  RouteString.home: (context) => HomeScreen(),
  RouteString.personaldetails: (context) => PersonalDetails(),
  RouteString.layout: (context) => LayoutScreen(),
  RouteString.addProductsRoute: (context) => AddProductsScreen(),

  RouteString.viewProduct: (context) => ViewProduct(),
  RouteString.mySupport: (context) => SupportScreen(),
  RouteString.aboutTheApp: (context) => AboutTheApp(),
  RouteString.privacyPolice: (context) => PrivacyPolicyScreen(),
};
