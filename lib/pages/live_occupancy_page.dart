import 'package:flutter/material.dart';

class LiveOccupancyPage extends StatelessWidget {
  const LiveOccupancyPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final items = [
      {"title": "Gym", "current": 31, "total": 50},
      {"title": "Swimming Pool", "current": 12, "total": 30},
      {"title": "Badminton Court", "current": 2, "total": 4},
      {"title": "Club House", "current": 2, "total": 4},
      {"title": "Garden Lawn", "current": 3, "total": 6},
      {"title": "Kids Play Area", "current": 8, "total": 60},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Live Occupancy",
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
        separatorBuilder: (context, child) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          final current = item["current"] as int;
          final total = item["total"] as int;
          final percent = current / total;

          Color statusColor;
          String statusLabel;
          if (percent >= 0.9) {
            statusColor = Colors.redAccent;
            statusLabel = "Almost Full";
          } else if (percent >= 0.6) {
            statusColor = const Color(0xFFFFC94D);
            statusLabel = "Busy";
          } else {
            statusColor = const Color(0xFF2FAE6B);
            statusLabel = "Available";
          }

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item["title"] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "$current / $total people",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: percent,
                    minHeight: 6,
                    backgroundColor: theme.brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(statusColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${(percent * 100).round()}% occupied",
                  style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}