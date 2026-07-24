import 'package:flutter/material.dart';
import 'package:communityos/widgets/qr_scanner_page.dart';
import 'package:communityos/controllers/occupancy_controller.dart';

class GymcheckingPage extends StatelessWidget {
  const GymcheckingPage({super.key});
  static const Color primaryPurple = Color(0xFF6C5DD3);
  static const String amenityKey = "gym";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = OccupancyController.instance;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final amenity = controller.amenities[amenityKey]!;
        final checkedIn = controller.isCheckedIn(amenityKey);

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            title: Text("Gym Check-in",
                style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7B6EF6), Color(0xFF6C5DD3)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.fitness_center, color: Colors.white, size: 40),
                      const SizedBox(height: 12),
                      const Text("Gym Occupancy", style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text("${amenity.current} / ${amenity.total}",
                          style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // ... QR box unchanged ...
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: checkedIn ? Colors.redAccent : primaryPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(builder: (_) => const QrScannerPage()),
                      );
                      if (!context.mounted) return;
                      if (result != null) {
                        controller.handleScan(amenityKey);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(checkedIn ? "Checked out successfully!" : "Checked in successfully!")),
                        );
                      }
                    },
                    icon: Icon(checkedIn ? Icons.logout : Icons.check_circle_outline),
                    label: Text(checkedIn ? "Check Out" : "Check In Now", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}