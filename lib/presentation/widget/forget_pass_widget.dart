import 'package:flutter/cupertino.dart';
import 'package:khsomati/presentation/widget/text_feild.dart';
import 'package:khsomati/validators/app_validators.dart';

class ForgetPasswordWidget extends StatelessWidget {
  ForgetPasswordWidget({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  // ✅ دالة النسيان، تمرر context حتى تقدر تستخدمه
  void _forgetPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // final email = emailController.text.trim();

      // // استدعاء Cubit
      // context.read<AuthCubit>().forgetPassword(email);

      // // الانتقال إلى شاشة OTP
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => OtpCodeScreen(email: email)),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 4),
              // Container(
              //   width: 100,
              //   height: 20,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(image: Svg(AppAssets.forget)),
              //   ),
              // ),
              SizedBox(height: 6),
              CustomTextFormField(
                controller: emailController,
                hintText: "E-Mail",
                labelText: "E-Mail",
                prefixIcon: const Icon(CupertinoIcons.mail),
                validator: (val) => AppValidator.validateEmail(context, val),
              ),
              SizedBox(height: 4),
              // MainButton(
              //   text: KeysTranslate.send.tr(context),
              //   onPressed: () =>
              //       _forgetPassword(context), // ✅ تمرير الـ context
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
