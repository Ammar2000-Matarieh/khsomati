import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/cubit/auth_cubit.dart';
import 'package:khsomati/business_logic/cubit/layout/layout_cubit.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/firebase_options.dart';
import 'package:khsomati/router/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Khosomati());
}

class Khosomati extends StatelessWidget {
  const Khosomati({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.setSize(
      newWidth: MediaQuery.sizeOf(context).width,
      newHeight: MediaQuery.sizeOf(context).height,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LayoutCubit()),
      ],

      child: MaterialApp(
        title: "Khosomati App",
        debugShowCheckedModeBanner: false,
        routes: routes,
      ),
    );
  }
}
