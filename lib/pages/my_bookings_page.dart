import 'package:flutter/material.dart';
import 'package:communityos/controllers/bookings_controller.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> with SingleTickerProviderStateMixin {
  static const Color primaryPurple = Color(0xFF6C5DD3);
  late TabController _tabController;

  static const List<String> _monthAbbrev = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
  ];

  final past = [
    {"date": "MAY\n20", "title": "Swimming Pool", "time": "05:00 PM - 06:00 PM", "status": "Completed"},
    {"date": "MAY\n18", "title": "Club House", "time": "10:00 AM - 12:00 PM", "status": "Completed"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("My Bookings",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryPurple,
          unselectedLabelColor: theme.textTheme.bodySmall?.color,
          indicatorColor: primaryPurple,
          tabs: const [Tab(text: "Upcoming"), Tab(text: "Past")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _upcomingList(theme),
          _pastList(theme),
        ],
      ),
    );
  }

  Widget _upcomingList(ThemeData theme) {
    return AnimatedBuilder(
      animation: BookingsController.instance,
      builder: (context, _) {
        final bookings = BookingsController.instance.upcomingBookings;
        if (bookings.isEmpty) {
          return Center(
            child: Text(
              "No upcoming bookings yet.\nBook an amenity to see it here.",
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.textTheme.bodySmall?.color),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: bookings.length,
          separatorBuilder: (context, child) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final b = bookings[index];
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
                    radius: 22,
                    backgroundColor: b.color.withValues(alpha: 0.12),
                    child: Icon(b.icon, color: b.color, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    children: [
                      Text(_monthAbbrev[b.date.month - 1].toUpperCase(),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: primaryPurple)),
                      Text("${b.date.day}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                          )),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.amenityTitle,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyLarge?.color,
                            )),
                        const SizedBox(height: 4),
                        Text(b.timeLabel, style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: Colors.redAccent),
                    tooltip: "Cancel booking",
                    onPressed: () => _confirmCancel(context, b),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _confirmCancel(BuildContext context, BookingItem booking) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Cancel Booking?"),
        content: Text("Cancel your ${booking.amenityTitle} booking on "
            "${booking.date.day} ${_monthAbbrev[booking.date.month - 1]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              BookingsController.instance.cancelBooking(booking);
              Navigator.pop(dialogContext);
            },
            child: const Text("Yes, Cancel", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Widget _pastList(ThemeData theme) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: past.length,
      separatorBuilder: (context, child) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final b = past[index];
        final parts = b["date"]!.split("\n");
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
              Column(
                children: [
                  Text(parts[0], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: primaryPurple)),
                  Text(parts[1],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      )),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(b["title"]!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.bodyLarge?.color,
                        )),
                    const SizedBox(height: 4),
                    Text(b["time"]!, style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  b["status"]!,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}