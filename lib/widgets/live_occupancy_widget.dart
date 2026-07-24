import 'package:flutter/material.dart';
import 'package:communityos/pages/live_occupancy_page.dart';

class LiveOccupancyWidget extends StatelessWidget {
  const LiveOccupancyWidget({super.key});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Live Occupancy",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LiveOccupancyPage()),
                );
              },
              child: const Text(
                "View All",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryPurple,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (context, child) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              final current = item["current"] as int;
              final total = item["total"] as int;
              final percent = current / total;

              return Container(
                width: 140,
                padding: const EdgeInsets.all(14),
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
                    Text(
                      item["title"] as String,
                      style: TextStyle(fontSize: 13, color: theme.textTheme.bodySmall?.color),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$current / $total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: percent,
                        minHeight: 5,
                        backgroundColor: theme.brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation(primaryPurple),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${(percent * 100).round()}%",
                      style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}