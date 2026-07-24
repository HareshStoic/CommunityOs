import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final offers = [
      {"title": "20% off Personal Training", "subtitle": "Valid till 31 Jul 2026", "color": const Color(0xFF6C5DD3), "icon": Icons.fitness_center},
      {"title": "Free Parking Wash", "subtitle": "For all residents this month", "color": const Color(0xFF4DA8FF), "icon": Icons.local_car_wash_outlined},
      {"title": "10% off Clubhouse Booking", "subtitle": "On weekend bookings", "color": const Color(0xFFFF9770), "icon": Icons.meeting_room_outlined},
      {"title": "Kids Summer Camp Discount", "subtitle": "15% off early registration", "color": const Color(0xFFE879A6), "icon": Icons.games_outlined},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Offers",
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        separatorBuilder: (context, index) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final o = offers[index];
          final color = o["color"] as Color;
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.85), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(o["title"] as String,
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(o["subtitle"] as String,
                          style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(o["icon"] as IconData, color: Colors.white.withValues(alpha: 0.6), size: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}