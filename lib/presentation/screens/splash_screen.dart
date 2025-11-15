import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_constant.dart';
import 'package:khsomati/constants/translation/app_translation.dart';
import 'package:khsomati/router/route_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteString.onBoarding);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMovingText(String text) {
    List<Widget> animatedLetters = text.split('').asMap().entries.map((entry) {
      int index = entry.key;
      String letter = entry.value;

      Animation<double> delayedAnimation = Tween<double>(begin: 0.0, end: 1.0)
          .animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                (index * 0.1),
                0.5 + (index * 0.1),
                curve: Curves.easeOut,
              ),
            ),
          );

      return FadeTransition(
        opacity: delayedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(delayedAnimation),
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blue, //  تغيير اللون
            ),
          ),
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: animatedLetters,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.read<LocalizationCubit>().translate;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _controller,
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(AppConstant.logoApp, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 80),

            SpinKitCircle(color: AppColors.primary),
            const SizedBox(height: 10),
             Text(
              t(AppTranslation.welcome),
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
