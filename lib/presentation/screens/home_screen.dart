import 'package:flutter/material.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/presentation/widget/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> open = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
