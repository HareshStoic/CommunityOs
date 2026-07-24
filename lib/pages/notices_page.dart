import 'package:flutter/material.dart';

class NoticesPage extends StatelessWidget {
  const NoticesPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final notices = [
      {"title": "Water Supply Interruption", "desc": "Water supply will be interrupted tomorrow from 10 AM to 2 PM for maintenance work.", "date": "20 Jul 2026"},
      {"title": "Annual General Meeting", "desc": "AGM will be held in the clubhouse on 28 Jul 2026 at 6 PM. All residents are requested to attend.", "date": "18 Jul 2026"},
      {"title": "Diwali Celebration", "desc": "Society Diwali celebration will be organized in the garden area. Details to follow soon.", "date": "15 Jul 2026"},
      {"title": "Fire Safety Drill", "desc": "A mandatory fire safety drill will be conducted on 22 Jul 2026 at 11 AM.", "date": "12 Jul 2026"},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Notices",
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notices.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notices[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0x1A6C5DD3),
                      child: Icon(Icons.campaign_outlined, color: primaryPurple, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(n["title"]!,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(n["desc"]!,
                    style: TextStyle(fontSize: 13, color: theme.textTheme.bodySmall?.color, height: 1.4)),
                const SizedBox(height: 10),
                Text(n["date"]!,
                    style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7))),
              ],
            ),
          );
        },
      ),
    );
  }
}