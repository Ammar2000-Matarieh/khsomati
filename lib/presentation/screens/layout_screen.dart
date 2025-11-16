import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/layout/layout_cubit.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/translation/app_translation.dart';
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
        // إغلاق الدرج
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      } else {
        // فتح الدرج وفقًا لنوع الجهاز (هاتف/ديسكتوب)
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

  // لم نعد بحاجة إلى GlobalKey<ScaffoldState> لفتح الدرج التقليدي
  // final GlobalKey<ScaffoldState> open = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    final t = context.read<LocalizationCubit>().translate;
    final proNavBar = context.read<LayoutCubit>(); // اختصار للـ LayoutCubit

    return BlocSelector<LayoutCubit, LayoutState, int>(
      selector: (state) => state.currentIndex ?? 0,
      builder: (context, currentIndex) {
        // هنا يتم استخدام الـ Stack لتطبيق تأثير الحركة
        return Stack(
          children: [
            // 👉 Drawer مخصص (يجب وضعه في الجانب الصحيح حسب الاتجاه)
            if (isDrawerOpen)
              Positioned(
                top: 0,
                bottom: 0,
                // يتم تحديد الجانب (left/right) بناءً على اتجاه النص (isRtl)
                left: isRtl ? null : 0,
                right: isRtl ? 0 : null,
                child: const CustomDrawer(),
              ),

            /// 👉 الشاشة الرئيسية (تتحرك عند فتح الدروار)
            GestureDetector(
              // يمكن استخدام GestureDetector لإغلاق الـ Drawer بالنقر على الشاشة الرئيسية
              onTap: isDrawerOpen ? _toggleDrawer : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                // تطبيق التحويلات (Translation, Scale, Rotation)
                transform: Matrix4.translationValues(xOffset, yOffset, 0)
                  ..scale(scaleFactor)
                  // تطبيق دوران خفيف (RotateZ)
                  ..rotateZ(isDrawerOpen ? (isRtl ? 0.05 : -0.05) : 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // إضافة حواف مستديرة عند فتح الدرج
                  borderRadius: isDrawerOpen
                      ? BorderRadius.circular(20)
                      : BorderRadius.circular(0),
                  // إضافة ظل عند فتح الدرج
                  boxShadow: isDrawerOpen
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: ClipRRect(
                  // قص المحتوى لتطبيق الحدود المستديرة بشكل صحيح
                  borderRadius: isDrawerOpen
                      ? BorderRadius.circular(20)
                      : BorderRadius.circular(0),
                  child: Scaffold(
                    // ⚠️ تم تعديل الـ AppBar
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      // زر فتح/إغلاق الـ Drawer
                      leading: IconButton(
                        icon: Icon(
                          isDrawerOpen
                              ? (isRtl
                                    ? Icons.arrow_forward_ios
                                    : Icons.arrow_back_ios)
                              : Icons.menu,
                          size: 20,
                        ),
                        onPressed: _toggleDrawer, // استدعاء _toggleDrawer
                      ),
                      // ... [بقية الأكشنز في الـ AppBar] ...
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => NotificationsScreen(),
                              ),
                            );
                            // notificationPro.clearCount();
                          },
                          icon: Badge(
                            backgroundColor: Colors.red,
                            label: Text("${4}"),
                            textColor: Colors.white,
                            child: const Icon(CupertinoIcons.bell),
                          ),
                        ),
                      ],
                    ),

                    // ⚠️ تم تعديل الـ body
                    body: Stack(
                      children: [
                        // عرض الشاشة الحالية
                        proNavBar.screen(context),

                        // 👉 زر إغلاق إضافي عند فتح Drawer (شريط أسفل الشاشة)
                        // نستخدمه هنا كـ Overlay بسيط فوق الشاشة الرئيسية المتحركة
                        if (isDrawerOpen)
                          Positioned(
                            // 80 لتجنب التداخل مع الـ BottomNavigationBar
                            bottom: 80,
                            left: isRtl ? null : 20,
                            right: isRtl ? 20 : null,
                            child: GestureDetector(
                              onTap: _toggleDrawer,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  isRtl ? 'إغلاق' : 'Close',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // **غطاء خفيف:** لإغلاق الدرج عند النقر خارج الـ Drawer
                        if (isDrawerOpen)
                          ModalBarrier(
                            dismissible:
                                false, // يتم التعامل مع الإغلاق في onTap لـ GestureDetector أعلاه
                            color: Colors
                                .transparent, // اللون الشفاف للسماح بالرؤية
                            onDismiss:
                                _toggleDrawer, // يمكنك إزالة هذا إذا كنت تعتمد على الـ GestureDetector الخارجي
                          ),
                      ],
                    ),

                    // ⚠️ الـ BottomNavigationBar لم يتغير

                    // bottomNavigationBar: NavigationBarTheme(
                    //   data: NavigationBarThemeData(
                    //     labelTextStyle:
                    //         WidgetStateProperty.resolveWith<TextStyle>((
                    //           states,
                    //         ) {
                    //           if (states.contains(WidgetState.selected)) {
                    //             return TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.bold,
                    //               color: AppColors.black,
                    //             );
                    //           }
                    //           return TextStyle(
                    //             fontSize: 16,
                    //             color: Colors.black,
                    //           );
                    //         }),
                    //   ),
                    //   child: NavigationBar(
                    //     selectedIndex: currentIndex,
                    //     indicatorColor: AppColors.primary.withOpacity(0.8),
                    //     surfaceTintColor: Colors.white,
                    //     animationDuration: const Duration(milliseconds: 400),
                    //     onDestinationSelected: (index) {
                    //       context.read<LayoutCubit>().changeNavigationBar(
                    //         index,
                    //       );
                    //     },
                    //     destinations: [
                    //       NavigationDestination(
                    //         label: t(AppTranslation.home),
                    //         icon: const Icon(CupertinoIcons.house),
                    //         selectedIcon: const Icon(
                    //           CupertinoIcons.house_fill,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       NavigationDestination(
                    //         label: t(AppTranslation.notifications),
                    //         icon: const Icon(CupertinoIcons.bell),
                    //         selectedIcon: const Icon(
                    //           CupertinoIcons.bell_fill,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       NavigationDestination(
                    //         label: "Test",
                    //         icon: const Icon(CupertinoIcons.archivebox),
                    //         selectedIcon: Icon(
                    //           CupertinoIcons.archivebox,
                    //           color: AppColors.white,
                    //         ),
                    //       ),
                    //       NavigationDestination(
                    //         label: t(AppTranslation.profile),
                    //         icon: const Icon(CupertinoIcons.profile_circled),
                    //         selectedIcon: Icon(
                    //           CupertinoIcons.profile_circled,
                    //           color: AppColors.white,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    bottomNavigationBar: NavigationBar(
                      //currentIndex
                      selectedIndex: 0,
                      indicatorColor: AppColors.primary.withOpacity(0.8),
                      surfaceTintColor: Colors.white,
                      animationDuration: const Duration(milliseconds: 400),
                      // onDestinationSelected: cubit.changeNavBar,
                      onDestinationSelected: (index) {
                        // context.read<LayoutCubit>().changeNavBar(index);
                      },
                      destinations: [
                        NavigationDestination(
                          label: "Home",
                          icon: const Icon(CupertinoIcons.house),
                          selectedIcon: const Icon(
                            CupertinoIcons.house_fill,
                            color: Colors.white,
                          ),
                        ),
                        NavigationDestination(
                          label: "Notifications",
                          icon: const Icon(Icons.delivery_dining_outlined),
                          selectedIcon: const Icon(
                            Icons.delivery_dining,
                            color: Colors.white,
                          ),
                        ),
                        NavigationDestination(
                          label: "Shop",
                          icon: Icon(CupertinoIcons.archivebox),
                          selectedIcon: Icon(
                            CupertinoIcons.archivebox,
                            color: AppColors.white,
                          ),
                        ),
                        NavigationDestination(
                          label: "Profile",
                          icon: Icon(CupertinoIcons.profile_circled),
                          selectedIcon: Icon(
                            CupertinoIcons.profile_circled,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}



// class LayoutScreen extends StatefulWidget {
//   const LayoutScreen({super.key});

//   @override
//   State<LayoutScreen> createState() => _LayoutScreenState();
// }

// class _LayoutScreenState extends State<LayoutScreen> {
//   double xOffset = 0;
//   double yOffset = 0;
//   double scaleFactor = 1;
//   bool isDrawerOpen = false;

//   void _toggleDrawer() {
//     setState(() {
//       final bool isRtl = Directionality.of(context) == TextDirection.rtl;
//       final bool isDesktop = MediaQuery.of(context).size.width >= 1100;

//       if (isDrawerOpen) {
//         // close drawer :
//         xOffset = 0;
//         yOffset = 0;
//         scaleFactor = 1;
//         isDrawerOpen = false;
//       } else {
//         // open drawer according to type device :
//         final double drawerWidth = isDesktop
//             ? MediaQuery.of(context).size.width * 0.3
//             : MediaQuery.of(context).size.width * 0.66;

//         xOffset = isRtl ? -drawerWidth : drawerWidth;
//         yOffset = isDesktop ? 0 : MediaQuery.of(context).size.height * 0.05;
//         scaleFactor = isDesktop ? 1 : 0.85;
//         isDrawerOpen = true;
//       }
//     });
//   }

//   final GlobalKey<ScaffoldState> open = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     final bool isRtl = Directionality.of(context) == TextDirection.rtl;
//     final t = context.read<LocalizationCubit>().translate;
//     return BlocSelector<LayoutCubit, LayoutState, int>(
//       selector: (state) => state.currentIndex ?? 0,
//       builder: (context, currentIndex) {
//         final cubit = context.read<LayoutCubit>();

//         return Scaffold(
//           key: open,
//           backgroundColor: AppColors.white,
//           drawer: CustomDrawer(),
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
//             leading: Padding(
//               padding: const EdgeInsetsDirectional.only(start: 10),
//               child: Container(
//                 width: 40,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: AppColors.primary,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: IconButton(
//                   onPressed: () => open.currentState!.openDrawer(),
//                   icon: Icon(Icons.menu),
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           body: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 400),
//             switchInCurve: Curves.easeInOut,
//             switchOutCurve: Curves.easeInOut,
//             transitionBuilder: (child, animation) {
//               return FadeTransition(
//                 opacity: animation,
//                 child: SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(0, 0.05),
//                     end: Offset.zero,
//                   ).animate(animation),
//                   child: child,
//                 ),
//               );
//             },
//             child: KeyedSubtree(
//               key: ValueKey(currentIndex),
//               child: cubit.screen(context),
//             ),
//           ),

//           bottomNavigationBar: NavigationBarTheme(
//             data: NavigationBarThemeData(
//               labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
//                 states,
//               ) {
//                 if (states.contains(WidgetState.selected)) {
//                   return TextStyle(
//                     fontSize: 14, // حجم الخط عند التحديد
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.black,
//                   );
//                 }
//                 return TextStyle(
//                   fontSize: 16, // حجم الخط العادي
//                   color: Colors.black,
//                 );
//               }),
//             ),
//             child: NavigationBar(
//               selectedIndex: currentIndex,
//               indicatorColor: AppColors.primary.withOpacity(0.8),
//               surfaceTintColor: Colors.white,
//               animationDuration: const Duration(milliseconds: 400),
//               onDestinationSelected: (index) {
//                 context.read<LayoutCubit>().changeNavigationBar(index);
//               },
//               destinations: [
//                 NavigationDestination(
//                   label: t(AppTranslation.home),
//                   icon: const Icon(CupertinoIcons.house),
//                   selectedIcon: const Icon(
//                     CupertinoIcons.house_fill,
//                     color: Colors.white,
//                   ),
//                 ),
//                 NavigationDestination(
//                   label: t(AppTranslation.notifications),
//                   icon: const Icon(CupertinoIcons.bell),
//                   selectedIcon: const Icon(
//                     CupertinoIcons.bell_fill,
//                     color: Colors.white,
//                   ),
//                 ),
//                 NavigationDestination(
//                   label: "Test",
//                   icon: const Icon(CupertinoIcons.archivebox),
//                   selectedIcon: Icon(
//                     CupertinoIcons.archivebox,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 NavigationDestination(
//                   label: t(AppTranslation.profile),
//                   icon: const Icon(CupertinoIcons.profile_circled),
//                   selectedIcon: Icon(
//                     CupertinoIcons.profile_circled,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


//     return Scaffold(
//       key: open,
//       backgroundColor: AppColors.white,
//       drawer: CustomDrawer(),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   leading: Padding(
      //     padding: const EdgeInsetsDirectional.only(start: 10),
      //     child: Container(
      //       width: 40,
      //       height: 30,
      //       decoration: BoxDecoration(
      //         color: AppColors.primary,
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       child: IconButton(
      //         onPressed: () => open.currentState!.openDrawer(),
      //         icon: Icon(Icons.menu),
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),

//       bottomNavigationBar: NavigationBar(
//         //currentIndex
//         selectedIndex: 0,
//         indicatorColor: AppColors.primary.withOpacity(0.8),
//         surfaceTintColor: Colors.white,
//         animationDuration: const Duration(milliseconds: 400),
//         // onDestinationSelected: cubit.changeNavBar,
//         onDestinationSelected: (index) {
//           // context.read<LayoutCubit>().changeNavBar(index);
//         },
//         destinations: [
//           NavigationDestination(
//             label: "Home",
//             icon: const Icon(CupertinoIcons.house),
//             selectedIcon: const Icon(
//               CupertinoIcons.house_fill,
//               color: Colors.white,
//             ),
//           ),
//           NavigationDestination(
//             label: "Notifications",
//             icon: const Icon(Icons.delivery_dining_outlined),
//             selectedIcon: const Icon(
//               Icons.delivery_dining,
//               color: Colors.white,
//             ),
//           ),
//           NavigationDestination(
//             label: "Shop",
//             icon: Icon(CupertinoIcons.archivebox),
//             selectedIcon: Icon(
//               CupertinoIcons.archivebox,
//               color: AppColors.white,
//             ),
//           ),
//           NavigationDestination(
//             label: "Profile",
//             icon: Icon(CupertinoIcons.profile_circled),
//             selectedIcon: Icon(
//               CupertinoIcons.profile_circled,
//               color: AppColors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
