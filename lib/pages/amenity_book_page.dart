// import 'package:flutter/material.dart';
//
// class BookAmenityPage extends StatelessWidget {
//   const BookAmenityPage({super.key});
//
//   static const Color primaryPurple = Color(0xFF6C5DD3);
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final amenities = [
//       {"icon": Icons.fitness_center, "title": "Gym", "subtitle": "Open 6 AM - 10 PM", "color": const Color(0xFF3FC98A)},
//       {"icon": Icons.pool, "title": "Swimming Pool", "subtitle": "Open 6 AM - 8 PM", "color": const Color(0xFF4DA8FF)},
//       {"icon": Icons.sports_tennis, "title": "Badminton Court", "subtitle": "Open 6 AM - 10 PM", "color": const Color(0xFFFF9770)},
//       {"icon": Icons.meeting_room_outlined, "title": "Club House", "subtitle": "Open 9 AM - 9 PM", "color": const Color(0xFF6C5DD3)},
//       {"icon": Icons.park_outlined, "title": "Garden Lawn", "subtitle": "Open 24 hours", "color": const Color(0xFFFFC94D)},
//       {"icon": Icons.games_outlined, "title": "Kids Play Area", "subtitle": "Open 7 AM - 7 PM", "color": const Color(0xFFE879A6)},
//     ];
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         elevation: 0,
//         title: Text(
//           "Book Amenity",
//           style: TextStyle(
//             color: theme.textTheme.bodyLarge?.color,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
//       ),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: amenities.length,
//         separatorBuilder: (context, child) => const SizedBox(height: 12),
//         itemBuilder: (context, index) {
//           final item = amenities[index];
//           return Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               color: theme.cardColor,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
//               ],
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 26,
//                   backgroundColor: (item["color"] as Color).withValues(alpha: 0.12),
//                   child: Icon(item["icon"] as IconData, color: item["color"] as Color, size: 24),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(item["title"] as String,
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: theme.textTheme.bodyLarge?.color,
//                           )),
//                       const SizedBox(height: 4),
//                       Text(item["subtitle"] as String,
//                           style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
//                     ],
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryPurple,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   ),
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Booking ${item["title"]}...")),
//                     );
//                   },
//                   child: const Text("Book", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:communityos/widgets/amenity_booking_detail_page.dart';

class BookAmenityPage extends StatelessWidget {
  const BookAmenityPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final amenities = [
      {
        "icon": Icons.fitness_center,
        "title": "Gym",
        "subtitle": "Open 6 AM - 10 PM",
        "color": const Color(0xFF3FC98A),
        "openHour": 6,
        "closeHour": 22,
      },
      {
        "icon": Icons.pool,
        "title": "Swimming Pool",
        "subtitle": "Open 6 AM - 8 PM",
        "color": const Color(0xFF4DA8FF),
        "openHour": 6,
        "closeHour": 20,
      },
      {
        "icon": Icons.sports_tennis,
        "title": "Badminton Court",
        "subtitle": "Open 6 AM - 10 PM",
        "color": const Color(0xFFFF9770),
        "openHour": 6,
        "closeHour": 22,
      },
      {
        "icon": Icons.meeting_room_outlined,
        "title": "Club House",
        "subtitle": "Open 9 AM - 9 PM",
        "color": const Color(0xFF6C5DD3),
        "openHour": 9,
        "closeHour": 21,
      },
      {
        "icon": Icons.park_outlined,
        "title": "Garden Lawn",
        "subtitle": "Open 24 hours",
        "color": const Color(0xFFFFC94D),
        "openHour": 0,
        "closeHour": 24,
      },
      {
        "icon": Icons.games_outlined,
        "title": "Kids Play Area",
        "subtitle": "Open 7 AM - 7 PM",
        "color": const Color(0xFFE879A6),
        "openHour": 7,
        "closeHour": 19,
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Book Amenity",
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
        itemCount: amenities.length,
        separatorBuilder: (context, child) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = amenities[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: (item["color"] as Color).withValues(alpha: 0.12),
                  child: Icon(item["icon"] as IconData, color: item["color"] as Color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item["title"] as String,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.bodyLarge?.color,
                          )),
                      const SizedBox(height: 4),
                      Text(item["subtitle"] as String,
                          style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () async {
                    final booked = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AmenityBookingDetailPage(
                          title: item["title"] as String,
                          icon: item["icon"] as IconData,
                          color: item["color"] as Color,
                          hoursLabel: item["subtitle"] as String,
                          openHour: item["openHour"] as int,
                          closeHour: item["closeHour"] as int,
                        ),
                      ),
                    );

                    if (!context.mounted) return;

                    if (booked == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${item["title"]} booked! Check My Bookings.")),
                      );
                    }
                  },
                  child: const Text("Book", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}