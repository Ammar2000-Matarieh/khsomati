import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/auth/auth_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/data/models/user_model.dart';
import 'package:khsomati/presentation/widget/text_feild.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().loadUserFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();
          final user = authCubit.userModel;

          if (user == null) {
            return Center(child: CircularProgressIndicator());
          }

          return buildProfileUI(context, user);
        },
      ),
    );
  }

  Widget buildProfileUI(BuildContext context, UserModel user) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: AppColors.primary),
              ),
              SizedBox(height: 12),
              Text(
                "${user.firstName} ${user.lastName}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                user.email ?? "",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),

        SizedBox(height: 25),

        Text(
          "Account Info",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),

        ProfileTile(
          icon: CupertinoIcons.person,
          title: "First Name",
          value: user.firstName ?? "",
          field: "firstName",
        ),
        ProfileTile(
          icon: CupertinoIcons.person,
          title: "Last Name",
          value: user.lastName ?? "",
          field: "lastName",
        ),
        ProfileTile(
          icon: CupertinoIcons.mail,
          title: "Email",
          value: user.email ?? "",
          field: "email",
        ),
        ProfileTile(
          icon: CupertinoIcons.phone,
          title: "Phone",
          value: user.phone ?? "",
          field: "phone",
        ),
      ],
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String field;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 26, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              final controller = TextEditingController(text: value);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Update $title"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFormField(
                          controller: controller,
                          prefixIcon: Icon(icon),
                          hintText: title,
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () async {
                            final authCubit = context.read<AuthCubit>();

                            await authCubit.updateUserField(
                              field: field,
                              value: controller.text.trim(),
                            );

                            Navigator.pop(context);
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.edit, size: 16, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
