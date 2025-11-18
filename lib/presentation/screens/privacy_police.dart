import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  final String htmlContent = """
  <h1 style="color:#004445;">سياسة الخصوصية</h1>
  <p style="font-size:16px; color:#333333;">
    نحن نحترم خصوصيتك وملتزمون بحماية بياناتك الشخصية عند استخدام تطبيقنا.
  </p>
  <h2 style="color:#004445;">المعلومات التي نجمعها</h2>
  <ul style="font-size:16px; color:#333333;">
    <li>اسم المستخدم والبريد الإلكتروني.</li>
    <li>تفضيلات الخصومات والعروض.</li>
    <li>الموقع الجغرافي لتحسين تجربة العروض.</li>
  </ul>
  <h2 style="color:#004445;">كيفية استخدام المعلومات</h2>
  <p style="font-size:16px; color:#333333;">
    تُستخدم المعلومات لتخصيص العروض، تحسين تجربة المستخدم، وإرسال إشعارات بالعروض المهمة فقط.
  </p>
  <h2 style="color:#004445;">مشاركة المعلومات</h2>
  <p style="font-size:16px; color:#333333;">
    لن نشارك بياناتك مع أي طرف ثالث بدون موافقتك، إلا إذا كان ذلك مطلوبًا قانونيًا.
  </p>
  <h2 style="color:#004445;">أمان البيانات</h2>
  <p style="font-size:16px; color:#333333;">
    نستخدم أحدث معايير الأمان لحماية بياناتك من الوصول غير المصرح به أو التسريب.
  </p>
  <p style="font-size:16px; color:#333333;">
    باستخدامك للتطبيق، أنت توافق على هذه السياسة وتفهم كيفية تعاملنا مع بياناتك.
  </p>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سياسة الخصوصية"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7F7), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            shadowColor: Colors.teal.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Html(
                data: htmlContent,
                style: {
                  "h1": Style(
                    fontSize: FontSize.xxLarge,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  "h2": Style(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w600,
                    // margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  "p": Style(
                    fontSize: FontSize.medium,
                    lineHeight: LineHeight.number(1.5),
                  ),
                  "li": Style(
                    fontSize: FontSize.medium,
                    // margin: EdgeInsets.symmetric(vertical: 4),
                  ),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
