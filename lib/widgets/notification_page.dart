import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);

  final List<Map<String, dynamic>> notifications = [
    {
      "icon": Icons.fitness_center,
      "title": "Gym Check-in Reminder",
      "subtitle": "Your booked gym slot starts in 30 minutes.",
      "time": "10 min ago",
      "unread": true,
      "color": const Color(0xFF3FC98A),
    },
    {
      "icon": Icons.report_gmailerrorred_outlined,
      "title": "Complaint Resolved",
      "subtitle": "Your complaint #1245 has been marked as resolved.",
      "time": "1 hr ago",
      "unread": true,
      "color": const Color(0xFF2FAE6B),
    },
    {
      "icon": Icons.local_offer_outlined,
      "title": "New Offer Available",
      "subtitle": "20% off on personal training sessions this week.",
      "time": "3 hr ago",
      "unread": false,
      "color": const Color(0xFFFFC94D),
    },
    {
      "icon": Icons.campaign_outlined,
      "title": "Society Notice",
      "subtitle": "Water supply will be interrupted tomorrow 10 AM - 2 PM.",
      "time": "Yesterday",
      "unread": false,
      "color": const Color(0xFF4DA8FF),
    },
    {
      "icon": Icons.directions_car_outlined,
      "title": "Parking Slot Assigned",
      "subtitle": "Your new parking slot B2-014 is now active.",
      "time": "2 days ago",
      "unread": false,
      "color": const Color(0xFF6C5DD3),
    },
  ];

  void _markAllRead() {
    setState(() {
      for (final n in notifications) {
        n["unread"] = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All notifications marked as read")),
    );
  }

  void _markOneRead(int index) {
    if (notifications[index]["unread"] == true) {
      setState(() {
        notifications[index]["unread"] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Notifications",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: const Text(
              "Mark all read",
              style: TextStyle(color: primaryPurple, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text(
          "No notifications yet",
          style: TextStyle(color: theme.textTheme.bodySmall?.color),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];
          final bool unread = n["unread"] as bool;
          final Color iconColor = n["color"] as Color;

          return GestureDetector(
            onTap: () => _markOneRead(index),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: unread
                    ? Border.all(color: primaryPurple.withValues(alpha: 0.3), width: 1)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: iconColor.withValues(alpha: 0.12),
                    child: Icon(n["icon"] as IconData, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                n["title"] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),
                            if (unread)
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(left: 6),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          n["subtitle"] as String,
                          style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          n["time"] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}