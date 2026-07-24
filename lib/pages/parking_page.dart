import 'package:flutter/material.dart';
import 'package:communityos/controllers/vehicles_controller.dart';
import 'package:communityos/pages/add_vehicle_page.dart';

class ParkingPage extends StatelessWidget {
  const ParkingPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Parking",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: AnimatedBuilder(
        animation: VehiclesController.instance,
        builder: (context, _) {
          final vehicles = VehiclesController.instance.vehicles;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B6EF6), Color(0xFF6C5DD3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Your Slot", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          SizedBox(height: 6),
                          Text("B2 - 014", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Basement Level 2", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.local_parking, color: Colors.white, size: 48),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text("Vehicles",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  )),
              const SizedBox(height: 12),

              if (vehicles.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Text(
                    "No vehicles added yet.",
                    style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
                  ),
                )
              else
                ...List.generate(vehicles.length, (index) {
                  final vehicle = vehicles[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: index == vehicles.length - 1 ? 0 : 12),
                    child: _vehicleTile(theme, vehicle),
                  );
                }),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryPurple,
                    side: const BorderSide(color: primaryPurple),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () async {
                    final added = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(builder: (_) => const AddVehiclePage()),
                    );

                    if (!context.mounted) return;

                    if (added == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Vehicle added successfully")),
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Vehicle", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _vehicleTile(ThemeData theme, VehicleItem vehicle) {
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
            radius: 24,
            backgroundColor: primaryPurple.withValues(alpha: 0.12),
            child: Icon(vehicle.icon, color: primaryPurple),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vehicle.number,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodyLarge?.color,
                    )),
                const SizedBox(height: 4),
                Text(vehicle.type, style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            tooltip: "Remove vehicle",
            onPressed: () => VehiclesController.instance.removeVehicle(vehicle),
          ),
        ],
      ),
    );
  }
}