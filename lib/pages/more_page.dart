import 'package:flutter/material.dart';
import 'package:communityos/theme/appearance_page.dart';
import 'package:communityos/pages/maintenance_bills_page.dart';
import 'package:communityos/pages/notices_page.dart';
import 'package:communityos/pages/community_page.dart';
import 'package:communityos/pages/offers_page.dart';
import 'package:communityos/pages/language_page.dart';
import 'package:communityos/pages/privacy_policy_page.dart';
import 'package:communityos/pages/support_page.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final items = [
      // {"icon": Icons.notifications_none, "label": "Notifications"},
      {"icon": Icons.receipt_long_outlined, "label": "Maintenance Bills"},
      {"icon": Icons.campaign_outlined, "label": "Notices"},
      {"icon": Icons.groups_outlined, "label": "Community"},
      {"icon": Icons.local_offer_outlined, "label": "Offers"},
      {"icon": Icons.language_outlined, "label": "Language"},
      {"icon": Icons.dark_mode_outlined, "label": "Appearance"},
      {"icon": Icons.privacy_tip_outlined, "label": "Privacy Policy"},
      {"icon": Icons.support_agent_outlined, "label": "Support"},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "More",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, child) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          final String label = item["label"] as String;
          final IconData icon = item["icon"] as IconData;

          return Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(icon, color: theme.textTheme.bodyLarge?.color),
              title: Text(
                label,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              // onTap: () {
              //   if (label == "Appearance") {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (_) => const AppearancePage()),
              //     );
              //   } else {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text("$label page coming soon")),
              //     );
              //   }
              // },

              onTap: () {
                Widget? page;
                switch (label) {
                  case "Maintenance Bills":
                    page = const MaintenanceBillsPage();
                    break;
                  case "Notices":
                    page = const NoticesPage();
                    break;
                  case "Community":
                    page = const CommunityPage();
                    break;
                  case "Offers":
                    page = const OffersPage();
                    break;
                  case "Language":
                    page = const LanguagePage();
                    break;
                  case "Appearance":
                    page = const AppearancePage();
                    break;
                  case "Privacy Policy":
                    page = const PrivacyPolicyPage();
                    break;
                  case "Support":
                    page = const SupportPage();
                    break;
                }

                if (page != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => page!));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$label page coming soon")),
                  );
                }
              },

            ),
          );
        },
      ),
    );
  }
}