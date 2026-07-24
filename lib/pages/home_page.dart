import 'package:flutter/material.dart';
import 'package:communityos/pages/activity_page.dart';
import 'package:communityos/pages/my_bookings_page.dart';
import 'package:communityos/pages/profile_page.dart';
import 'package:communityos/widgets/greeting_app_bar.dart';
import 'package:communityos/widgets/my_access_card.dart';
import 'package:communityos/widgets/quick_actions_widget.dart';
import 'package:communityos/widgets/live_occupancy_widget.dart';
import 'package:communityos/widgets/upcoming_bookings_widget.dart';
import 'package:communityos/widgets/personal_training_banner.dart';
import 'package:communityos/widgets/bottom_navbar_widget.dart';
import 'package:communityos/widgets/qr_scanner_page.dart';
import 'package:communityos/widgets/notification_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF7F7FB),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GreetingAppBar(
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationPage()),
          );
        },
        // onSyncTap: () {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Syncing data...")),
        //   );
        // },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 8),
            MyAccessCard(),
            SizedBox(height: 22),
            QuickActionsWidget(),
            SizedBox(height: 22),
            LiveOccupancyWidget(),
            SizedBox(height: 22),
            UpcomingBookingsWidget(),
            SizedBox(height: 22),
            PersonalTrainingBanner(),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyBookingsPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ActivityPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }
        },
      ),

      floatingActionButton: CenterFabButton(
        onTap: () async {
          final result = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (_) => const QrScannerPage()),
          );

          if (!context.mounted) return; // guard using context.mounted

          if (result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Scanned: $result")),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
