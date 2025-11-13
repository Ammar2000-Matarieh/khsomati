import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khsomati/firebase_options.dart';
import 'package:khsomati/router/route.dart';
import 'package:khsomati/router/route_string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Khosomati());
}

class Khosomati extends StatelessWidget {
  const Khosomati({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Khosomati App",
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
