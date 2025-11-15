import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_constant.dart';
import 'package:khsomati/constants/app_size.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: AppSize.width * 0.82,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: SingleChildScrollView(child: CustomComponentsDrawer()),
    );
  }
}

class CustomComponentsDrawer extends StatelessWidget {
  const CustomComponentsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // حافظنا على مسافة كبيرة في الأعلى
        SizedBox(height: AppSize.height * 0.06),
        const DrawerHeaderWidget(),
        // مسافة مناسبة بعد الهيدر
        SizedBox(height: AppSize.height * 0.03),

        const Divider(color: Colors.grey),
        Padding(
          padding: const EdgeInsets.all(10), // استخدام const لتحسين الأداء
          child: Column(
            children: [
              ListTileWidget(
                text: "Profile",
                leading: Icons.person_outline,
                onTap: () {},
              ),
              // مسافة أقل بين العناصر
              SizedBox(height: 10),

              ListTileWidget(
                leading: Icons.language,
                title: Row(
                  children: [
                    Text(
                      "اللغات",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text("English"),
                  ],
                ),
                onTap: () {},
              ),

              SizedBox(height: 10), // مسافة أقل

              ListTileWidget(
                text: "Support",
                leading: CupertinoIcons.question_circle,
                onTap: () {},
              ),

              SizedBox(height: 10), // مسافة أقل
              ListTileWidget(
                text: "Notifications",
                leading: CupertinoIcons.bell,
                onTap: () {},
              ),

              SizedBox(height: 10), // مسافة أقل

              ListTileWidget(
                text: "Privacy & Polices",
                leading: Icons.privacy_tip_outlined,
                onTap: () {},
              ),

              SizedBox(height: 10), // مسافة أقل
              ListTileWidget(
                text: "About The App",
                leading: Icons.app_settings_alt,
                onTap: () {},
              ),

              SizedBox(height: 20), // زيادة بسيطة قبل زر تسجيل الخروج

              ListTileWidget(
                isLogout: true,
                text: "Log Out",
                leading: Icons.logout,
                onTap: () {
                  // showCupertinoDialog(
                  //   context: context,
                  //   builder: (context) => CustomLogoutWidget(),
                  // );
                },
              ),
            ],
          ),
        ),
        // مسافة صغيرة في الأسفل
        SizedBox(height: 10),
      ],
    );
  }
}

// class CustomComponentsDrawer extends StatelessWidget {
//   const CustomComponentsDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: AppSize.height * 0.06),
//         const DrawerHeaderWidget(),
//         SizedBox(height: AppSize.height * 0.03),

//         const Divider(color: Colors.grey),
//         Padding(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             children: [
//               ListTileWidget(
//                 text: "Profile",
//                 leading: Icons.person_outline,
//                 onTap: () {},
//               ),
//               // SizedBox(height: 2),
//               SizedBox(height: AppSize.height * 0.03),
//               ListTileWidget(
//                 leading: Icons.language,
//                 title: Row(
//                   children: [
//                     Text(
//                       "اللغات",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     const Spacer(),
//                     Text(
//                       "English",
//                       // currentLangCode == 'ar' ? '( Arabic )' : '( English )',
//                     ),
//                   ],
//                 ),
//                 onTap: () {},
//                 // onTap: () => showCupertinoModalPopup(
//                 //   context: context,
//                 //   builder: (ctx) => CustomPopUpChangeLanguage(),
//                 // ),
//               ),

//               // SizedBox(height: 2),
//               // SizedBox(height: AppSize.height * 0.01),
//               SizedBox(height: AppSize.height * 0.03),

//               ListTileWidget(
//                 text: "Support",
//                 leading: CupertinoIcons.question_circle,
//                 onTap: () {},
//               ),
//               // SizedBox(height: 2),
//               SizedBox(height: AppSize.height * 0.01),
//               ListTileWidget(
//                 text: "Notifications",
//                 leading: CupertinoIcons.bell,
//                 onTap: () {},
//               ),
//               // SizedBox(height: 2),
//               SizedBox(height: AppSize.height * 0.01),

//               ListTileWidget(
//                 text: "Privacy & Polices",
//                 leading: Icons.privacy_tip_outlined,
//                 onTap: () {},
//               ),
//               // SizedBox(height: 2),
//               SizedBox(height: AppSize.height * 0.01),
//               ListTileWidget(
//                 text: "About The App",
//                 leading: Icons.app_settings_alt,
//                 onTap: () {},
//               ),
//               // SizedBox(height: 2),
//               SizedBox(height: AppSize.height * 0.01),
//               ListTileWidget(
//                 isLogout: true,
//                 text: "Log Out",
//                 leading: Icons.logout,
//                 onTap: () {
//                   // showCupertinoDialog(
//                   //   context: context,
//                   //   builder: (context) => CustomLogoutWidget(),
//                   // );
//                 },
//               ),
//             ],
//           ),
//         ),
//         // SizedBox(height: 2),
//         SizedBox(height: AppSize.height * 0.01),
//       ],
//     );
//   }
// }

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppSize.width * 0.60,
          height: AppSize.height * 0.20,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: AssetImage(AppConstant.logoApp),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    this.text,
    this.title,
    this.onTap,
    this.trailing,
    this.isLogout = false,
    required this.leading,
  });

  final String? text;
  final Widget? title;
  final bool isLogout;
  final IconData leading;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.primary, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      leading: Icon(leading, color: isLogout ? Colors.red : AppColors.primary),
      trailing: isLogout
          ? null
          : trailing ??
                const Icon(CupertinoIcons.forward, color: AppColors.primary),
      title:
          title ??
          Text(
            text!,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: Colors.black),
          ),
    );
  }
}
