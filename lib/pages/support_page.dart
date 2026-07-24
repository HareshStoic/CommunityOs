import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final faqs = [
      {"q": "How do I book an amenity?", "a": "Go to Home > Book Amenity, choose your preferred slot, and confirm."},
      {"q": "How do I add a visitor?", "a": "Go to Home > Visitors and tap Add Visitor to pre-approve entry."},
      {"q": "How do I pay maintenance bills?", "a": "Go to More > Maintenance Bills and tap Pay Now on your current due."},
      {"q": "How do I raise a complaint?", "a": "Go to Home > Complaints and tap Raise Complaint to submit a new issue."},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Support",
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF7B6EF6), Color(0xFF6C5DD3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Need Help?", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text("Our team is available 9 AM - 9 PM", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.support_agent_outlined, color: Colors.white, size: 44),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _contactTile(
                  theme,
                  icon: Icons.call_outlined,
                  label: "Call Us",
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contactTile(
                  theme,
                  icon: Icons.email_outlined,
                  label: "Email Us",
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contactTile(
                  theme,
                  icon: Icons.chat_bubble_outline,
                  label: "Live Chat",
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text("Frequently Asked Questions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
          const SizedBox(height: 12),
          ...faqs.map((f) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              iconColor: primaryPurple,
              collapsedIconColor: theme.textTheme.bodySmall?.color,
              title: Text(f["q"]!,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(f["a"]!,
                        style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color, height: 1.4)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _contactTile(ThemeData theme, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: primaryPurple),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(fontSize: 11, color: theme.textTheme.bodyLarge?.color)),
            ],
          ),
        ),
      ),
    );
  }
}