import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/layout/layout_cubit.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/translation/app_translation.dart';
import 'package:khsomati/data/models/notifications_model.dart';
import 'package:khsomati/presentation/screens/notifications_screen.dart';
import 'package:khsomati/presentation/widget/custom_drawer.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      final bool isRtl = Directionality.of(context) == TextDirection.rtl;
      final bool isDesktop = MediaQuery.of(context).size.width >= 1100;

      if (isDrawerOpen) {
        // close drawer :
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      } else {
        // open drawer according to type device :
        final double drawerWidth = isDesktop
            ? MediaQuery.of(context).size.width * 0.3
            : MediaQuery.of(context).size.width * 0.66;

        xOffset = isRtl ? -drawerWidth : drawerWidth;
        yOffset = isDesktop ? 0 : MediaQuery.of(context).size.height * 0.05;
        scaleFactor = isDesktop ? 1 : 0.85;
        isDrawerOpen = true;
      }
    });
  }

  final GlobalKey<ScaffoldState> open = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    final t = context.read<LocalizationCubit>().translate;
    return BlocSelector<LayoutCubit, LayoutState, int>(
      selector: (state) => state.currentIndex ?? 0,
      builder: (context, currentIndex) {
        final cubit = context.read<LayoutCubit>();

        return Scaffold(
          key: open,
          backgroundColor: AppColors.white,
          drawer: CustomDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () => open.currentState!.openDrawer(),
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => ComingSoonScreen(),
                    ),
                  );
                },
                icon: Badge(
                  backgroundColor: Colors.red,
                  label: Text("${5}"),
                  textColor: Colors.white,
                  child: const Icon(CupertinoIcons.bell),
                ),
              ),
            ],
          ),

          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.05),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: KeyedSubtree(
              key: ValueKey(currentIndex),
              child: cubit.screen(context),
            ),
          ),

          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  );
                }
                return TextStyle(
                  fontSize: 16, // حجم الخط العادي
                  color: Colors.black,
                );
              }),
            ),
            child: NavigationBar(
              selectedIndex: currentIndex,
              indicatorColor: AppColors.primary.withOpacity(0.8),
              surfaceTintColor: Colors.white,
              animationDuration: const Duration(milliseconds: 400),
              onDestinationSelected: (index) {
                context.read<LayoutCubit>().changeNavigationBar(index);
              },
              destinations: [
                NavigationDestination(
                  label: t(AppTranslation.home),
                  icon: const Icon(CupertinoIcons.house),
                  selectedIcon: const Icon(
                    CupertinoIcons.house_fill,
                    color: Colors.white,
                  ),
                ),
                NavigationDestination(
                  label: t(AppTranslation.notifications),
                  icon: const Icon(CupertinoIcons.bell),
                  selectedIcon: const Icon(
                    CupertinoIcons.bell_fill,
                    color: Colors.white,
                  ),
                ),
                NavigationDestination(
                  label: t(AppTranslation.profile),
                  icon: const Icon(CupertinoIcons.profile_circled),
                  selectedIcon: Icon(
                    CupertinoIcons.profile_circled,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
