import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  static const Color primary = Color(0xFF004445);
  final String phone = "0799999999"; // رقم الاتصال
  final String whatsapp = "0799999999"; // رقم الواتساب
  final String email = "support@example.com";

  // ===== Launch WhatsApp =====
  Future<void> openWhatsApp() async {
    final Uri url = Uri.parse("https://wa.me/962$whatsapp");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw "Could not open WhatsApp";
    }
  }

  // ===== Phone Call =====
  Future<void> makePhoneCall() async {
    final status = await Permission.phone.request();
    if (status.isGranted) {
      final Uri url = Uri.parse("tel:+962$phone");
      await launchUrl(url);
    } else {
      throw "Permission Denied";
    }
  }

  // ===== Email =====
  Future<void> sendEmail() async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Support Request&body=Hello, I need help about...',
    );

    if (!await launchUrl(url)) {
      throw "Could not send email";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء
      appBar: AppBar(
        title: const Text("Support"),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            _buildButton(
              icon: Icons.chat,
              label: "WhatsApp Support",
              color: Colors.green,
              onTap: openWhatsApp,
            ),
            const SizedBox(height: 20),
            _buildButton(
              icon: Icons.call,
              label: "Call Support",
              color: Colors.blue,
              onTap: makePhoneCall,
            ),
            const SizedBox(height: 20),
            _buildButton(
              icon: Icons.email,
              label: "Email Support",
              color: Colors.red,
              onTap: sendEmail,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              offset: const Offset(0, 5),
              blurRadius: 10,
            ),
          ],
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
