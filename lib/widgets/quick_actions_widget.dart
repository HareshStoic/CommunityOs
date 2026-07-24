import 'package:flutter/material.dart';
import 'package:communityos/pages/amenity_book_page.dart';
import 'package:communityos/pages/my_bookings_page.dart';
import 'package:communityos/pages/gym_checking_page.dart';
import 'package:communityos/pages/my_trainer_page.dart';
import 'package:communityos/pages/visitors_page.dart';
import 'package:communityos/pages/parking_page.dart';
import 'package:communityos/pages/complaints_page.dart';
import 'package:communityos/pages/more_page.dart';


class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final actions = [
      {"icon": Icons.event_seat_outlined, "label": "Book Amenity", "color": const Color(0xFF6C5DD3), "page": const BookAmenityPage()},
      {"icon": Icons.calendar_today_outlined, "label": "My Bookings", "color": const Color(0xFF6C5DD3), "page": const MyBookingsPage()},
      {"icon": Icons.fitness_center, "label": "Gym Check-in", "color": const Color(0xFF3FC98A), "page": const GymcheckingPage()},
      {"icon": Icons.person_outline, "label": "My Trainer", "color": const Color(0xFFFF9770), "page": const MyTrainerPage()},
      {"icon": Icons.group_outlined, "label": "Visitors", "color": const Color(0xFF6C5DD3), "page": const VisitorsPage()},
      {"icon": Icons.directions_car_outlined, "label": "Parking", "color": const Color(0xFF4DA8FF), "page": const ParkingPage()},
      {"icon": Icons.report_gmailerrorred_outlined, "label": "Complaints", "color": const Color(0xFFFFC94D), "page": const ComplaintsPage()},
      {"icon": Icons.grid_view_rounded, "label": "More", "color": Colors.grey.shade600 , "page": const MorePage()},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            // mainAxisSpacing: 16,
            mainAxisSpacing: 4,
            crossAxisSpacing: 8,
            // childAspectRatio: 0.75,
            childAspectRatio: 0.95,
          ),
          // itemBuilder: (context, index) {
          //   final item = actions[index];
          //   return Column(
          //     children: [
          //       CircleAvatar(
          //         // radius: 26,
          //         radius: 24,
          //         backgroundColor: (item["color"] as Color).withValues(alpha: 0.12),
          //         child: Icon(
          //           item["icon"] as IconData,
          //           color: item["color"] as Color,
          //           size: 24,
          //         ),
          //       ),
          //       // const SizedBox(height: 6),
          //       const SizedBox(height: 4),
          //       Text(
          //         item["label"] as String,
          //         textAlign: TextAlign.center,
          //         // style: const TextStyle(fontSize: 11, color: Colors.black87),
          //         style: const TextStyle(fontSize: 10, color: Colors.black87),
          //       ),
          //     ],
          //   );
          // },
          itemBuilder: (context, index) {
            final item = actions[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => item["page"] as Widget));
              },
              child: Column(children: [
                CircleAvatar(
                  // radius: 26,
                  radius: 24,
                  backgroundColor: (item["color"] as Color).withValues(alpha: 0.12),
                  child: Icon(
                    item["icon"] as IconData,
                    color: item["color"] as Color,
                    size: 24,
                  ),
                ),
                // const SizedBox(height: 6),
                const SizedBox(height: 4),
                Text(
                  item["label"] as String,
                  textAlign: TextAlign.center,
                  // style: const TextStyle(fontSize: 11, color: Colors.black87),
                  style: TextStyle(fontSize: 10, color: theme.textTheme.bodyLarge?.color),
                ),
              ],
              ), // unchanged
            );
          },

        ),
      ],
    );
  }
}