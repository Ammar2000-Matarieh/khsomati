import 'package:flutter/material.dart';
import 'package:khsomati/presentation/screens/home_screen.dart';
import 'package:khsomati/presentation/screens/splash_screen.dart';
import 'package:khsomati/router/route_string.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  RouteString.splash: (context) => SplashScreen(),
  RouteString.home: (context) => HomeScreen(),
};
