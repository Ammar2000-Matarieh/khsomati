import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutTheApp extends StatefulWidget {
  const AboutTheApp({super.key});

  @override
  State<AboutTheApp> createState() => _AboutTheAppState();
}

class _AboutTheAppState extends State<AboutTheApp> {
  String appVersion = '';

  final String htmlContent = """
  <h1 style="color:#004445;">عن تطبيق الخصومات</h1>
  <p style="font-size:16px; color:#333333;">
    يساعد هذا التطبيق المستخدمين على الحصول على أفضل العروض والخصومات في المتاجر والمطاعم القريبة منهم.
  </p>
  <h2 style="color:#004445;">مميزات التطبيق</h2>
  <ul style="font-size:16px; color:#333333;">
    <li>عرض الخصومات اليومية.</li>
    <li>متابعة العروض الجديدة باستمرار.</li>
    <li>إشعارات بالعروض المهمة لضمان عدم تفويت أي خصم.</li>
  </ul>
  <p style="font-size:16px; color:#333333;">
    هدفنا هو تسهيل تجربة التسوق وتوفير الوقت والمال لكل مستخدم.
  </p>
  """;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo
          .version; // أو packageInfo.version + "+" + packageInfo.buildNumber
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عن التطبيق"),
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
              child: Column(
                children: [
                  Html(
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
                        // margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      "p": Style(
                        fontSize: FontSize.medium,
                        lineHeight: LineHeight.number(1.5),
                      ),
                      "li": Style(
                        fontSize: FontSize.medium,
                        // margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    },
                  ),
                  const SizedBox(height: 20),
                  if (appVersion.isNotEmpty)
                    Text(
                      "الإصدار: $appVersion",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
