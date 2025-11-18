import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khsomati/business_logic/cubit/auth/auth_cubit.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_cubit.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_state.dart';
import 'package:khsomati/business_logic/cubit/layout/layout_cubit.dart';
import 'package:khsomati/business_logic/cubit/store/store_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/firebase_options.dart';
import 'package:khsomati/notifications_mess.dart';
import 'package:khsomati/router/route.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ===== Background Handler =====
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("🔵 Background Message: ${message.messageId}");
  print("📦 DATA: ${message.data}");
}

// ===== MAIN =====
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LocalizationCubit()),
        BlocProvider(create: (_) => LayoutCubit()),
        BlocProvider(create: (_) => StoreCubit()),
      ],
      child: const Khosomati(),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await _initFirebaseMessaging();
  });
}

// ===== Initialize Messaging After runApp =====
Future<void> _initFirebaseMessaging() async {
  final messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    sound: true,
  );

  await messaging.subscribeToTopic("users");

  await LocalNotificationService().init();

  // Token
  // String? token = await messaging.getToken();
  // print("🔥 FCM Token: $token");

  // Refresh Token
  // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
  //   print("♻️ NEW TOKEN: $newToken");
  // });

  // ===== Foreground Notification =====
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("🟢 Foreground Message");
    print("📌 Title: ${message.notification?.title}");
    print("📌 Body: ${message.notification?.body}");
    print("📌 DATA: ${message.data}");

    // Show local notification
    LocalNotificationService().showNotification(message);
  });

  // ===== Background — User tapped notification =====
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("🟠 Notification Clicked while app in Background");

    final screen = message.data['screen'];
    final orderId = message.data['order_id'];

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(
        screen ?? '/order',
        arguments: orderId,
      );
    }
  });

  // ===== Terminated =====
  RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage();

  if (initialMessage != null) {
    print("🔴 App opened from TERMINATED");
    print(initialMessage.data);

    final screen = initialMessage.data['screen'];
    final orderId = initialMessage.data['order_id'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushNamed(
        screen ?? '/order',
        arguments: orderId,
      );
    });
  }
}

// ===== APP WIDGET =====
class Khosomati extends StatelessWidget {
  const Khosomati({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.setSize(
      newWidth: MediaQuery.sizeOf(context).width,
      newHeight: MediaQuery.sizeOf(context).height,
    );

    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (BuildContext context, LocalizationState state) {
        return MaterialApp(
          navigatorKey: navigatorKey, // navigate screen :
          theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
          locale: state.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: "Khosomati App",
          debugShowCheckedModeBanner: false,
          routes: routes,
        );
      },
    );
  }
}
