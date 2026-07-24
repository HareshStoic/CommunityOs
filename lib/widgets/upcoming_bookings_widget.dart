import 'package:flutter/material.dart';
import 'package:communityos/controllers/bookings_controller.dart';
import 'package:communityos/pages/my_bookings_page.dart';

class UpcomingBookingsWidget extends StatelessWidget {
  const UpcomingBookingsWidget({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  static const List<String> _monthAbbrev = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: BookingsController.instance,
      builder: (context, _) {
        // Home page only needs a quick glance — show up to 2 soonest bookings.
        final allBookings = List<BookingItem>.from(BookingsController.instance.upcomingBookings)
          ..sort((a, b) => a.date.compareTo(b.date));
        final bookings = allBookings.take(2).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Bookings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MyBookingsPage()),
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
            if (bookings.isEmpty)
              Container(
                width: double.infinity,
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
                child: Text(
                  "No upcoming bookings. Book an amenity to see it here.",
                  style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
                ),
              )
            else
              ...List.generate(bookings.length, (index) {
                final booking = bookings[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: index == bookings.length - 1 ? 0 : 10),
                  child: _bookingTile(theme: theme, booking: booking),
                );
              }),
          ],
        );
      },
    );
  }

  Widget _bookingTile({
    required ThemeData theme,
    required BookingItem booking,
  }) {
    return Container(
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: booking.color.withValues(alpha: 0.12),
            child: Icon(booking.icon, color: booking.color, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                _monthAbbrev[booking.date.month - 1].toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: primaryPurple,
                ),
              ),
              Text(
                "${booking.date.day}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.amenityTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.timeLabel,
                  style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F9EF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Confirmed",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2FAE6B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}