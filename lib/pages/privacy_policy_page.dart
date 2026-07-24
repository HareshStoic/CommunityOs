import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Privacy Policy",
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text("Last updated: 1 July 2026",
              style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
          const SizedBox(height: 20),
          _section(theme, "1. Information We Collect",
              "We collect information you provide directly, such as your name, mobile number, email, address, and profile photo, when you create or update your account."),
          _section(theme, "2. How We Use Your Information",
              "Your information is used to provide community services such as amenity booking, visitor management, complaint tracking, and billing."),
          _section(theme, "3. Data Sharing",
              "We do not sell your personal data. Information may be shared with your society's management committee solely for operational purposes."),
          _section(theme, "4. Data Security",
              "We use industry-standard security measures to protect your data from unauthorized access, alteration, or disclosure."),
          _section(theme, "5. Your Rights",
              "You can access, update, or request deletion of your personal information at any time from your Profile page."),
          _section(theme, "6. Contact Us",
              "For any privacy-related questions, please reach out to our support team through the Support section of this app."),
        ],
      ),
    );
  }

  Widget _section(ThemeData theme, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
          const SizedBox(height: 6),
          Text(body,
              style: TextStyle(fontSize: 13, color: theme.textTheme.bodySmall?.color, height: 1.5)),
        ],
      ),
    );
  }
}