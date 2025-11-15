import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/layout/layout_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/presentation/widget/custom_drawer.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final GlobalKey<ScaffoldState> open = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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

          bottomNavigationBar: NavigationBar(
            selectedIndex: currentIndex,
            indicatorColor: AppColors.primary.withOpacity(0.8),
            surfaceTintColor: Colors.white,
            animationDuration: const Duration(milliseconds: 400),
            // onDestinationSelected: cubit.changeNavBar,
            onDestinationSelected: (index) {
              context.read<LayoutCubit>().changeNavigationBar(index);
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
                label: "Test",
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
        );
      },
    );
  }
}
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
