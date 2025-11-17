import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_constant.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/constants/translation/app_translation.dart';
import 'package:khsomati/router/route_string.dart';

class CustomPopUpChangeLanguage extends StatelessWidget {
  const CustomPopUpChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            final cubit = context.read<LocalizationCubit>();
            cubit.loadLanguage('ar');
          },
          child: Text("Arabic"),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            final cubit = context.read<LocalizationCubit>();
            cubit.loadLanguage('en');
          },
          child: Text("English"),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {},
        isDestructiveAction: true,
        child: Text("Cancel"),
      ),
    );
  }
}

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
    final t = context.read<LocalizationCubit>().translate;
    return Column(
      children: [
        SizedBox(height: AppSize.height * 0.06),
        const DrawerHeaderWidget(),

        SizedBox(height: AppSize.height * 0.03),

        const Divider(color: Colors.grey),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTileWidget(
                text: t(AppTranslation.profile),
                leading: Icons.person_outline,
                onTap: () {},
              ),

              SizedBox(height: 10),

              ListTileWidget(
                leading: Icons.language,
                title: Row(
                  children: [
                    Text(
                      t(AppTranslation.languages),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(t(AppTranslation.english)),
                  ],
                ),
                // onTap: () {},
                onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (ctx) => CustomPopUpChangeLanguage(),
                ),
              ),

              SizedBox(height: 10),
              ListTileWidget(
                text: t(AppTranslation.addProducts),
                leading: CupertinoIcons.add_circled,
                onTap: () => Navigator.of(
                  context,
                ).pushNamed(RouteString.addProductsRoute),
              ),

              ListTileWidget(
                text: t(AppTranslation.support),
                leading: CupertinoIcons.question_circle,
                onTap: () {},
              ),

              SizedBox(height: 10),
              ListTileWidget(
                text: t(AppTranslation.notifications),
                leading: CupertinoIcons.bell,
                onTap: () {},
              ),

              SizedBox(height: 10),

              ListTileWidget(
                text: t(AppTranslation.privacypolices),
                leading: Icons.privacy_tip_outlined,
                onTap: () {},
              ),

              SizedBox(height: 10), // مسافة أقل
              ListTileWidget(
                text: t(AppTranslation.aboutTheApp),
                leading: Icons.app_settings_alt,
                onTap: () {},
              ),

              SizedBox(height: 20), // زيادة بسيطة قبل زر تسجيل الخروج

              ListTileWidget(
                isLogout: true,
                text: t(AppTranslation.logOut),
                leading: Icons.logout,
                onTap: () {
                  _showLogoutDialog(context, t);
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

  void _showLogoutDialog(BuildContext context, Function(String) t) {
    // الكود الخاص بالـ AwesomeDialog الذي وضعناه في الخطوة الأولى
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: t(AppTranslation.logOut) ?? 'تسجيل الخروج',
      desc: t(AppTranslation.logOut) ?? 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
      btnCancelText: t(AppTranslation.logOut) ?? 'إلغاء',
      btnCancelColor: Colors.grey,
      btnCancelOnPress: () {},
      btnOkText: t(AppTranslation.logOut) ?? 'خروج',
      btnOkColor: Colors.red,
      btnOkOnPress: () {
        // منطق تسجيل الخروج
      },
    ).show();
  }
}

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
        // side: BorderSide(color: AppColors.primary, width: 1),
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
