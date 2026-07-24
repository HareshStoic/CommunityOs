import 'package:flutter/material.dart';
import 'package:communityos/controllers/vehicles_controller.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();

  final List<Map<String, dynamic>> _vehicleTypes = [
    {"label": "Sedan", "icon": Icons.directions_car},
    {"label": "SUV", "icon": Icons.directions_car_filled},
    {"label": "Hatchback", "icon": Icons.directions_car_outlined},
    {"label": "Bike", "icon": Icons.two_wheeler},
  ];

  String _selectedType = "Sedan";

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  IconData get _selectedIcon =>
      _vehicleTypes.firstWhere((t) => t["label"] == _selectedType)["icon"] as IconData;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    VehiclesController.instance.addVehicle(
      VehicleItem(
        number: _numberController.text.trim().toUpperCase(),
        type: _selectedType,
        icon: _selectedIcon,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Add Vehicle",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text("Vehicle Number",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodySmall?.color,
                )),
            const SizedBox(height: 8),
            TextFormField(
              controller: _numberController,
              textCapitalization: TextCapitalization.characters,
              style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                hintText: "e.g. MH 12 AB 1234",
                prefixIcon: const Icon(Icons.confirmation_number_outlined, color: primaryPurple, size: 20),
                filled: true,
                fillColor: theme.cardColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: primaryPurple, width: 1.5),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter the vehicle number";
                }
                return null;
              },
            ),
            const SizedBox(height: 22),

            Text("Vehicle Type",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodySmall?.color,
                )),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _vehicleTypes.map((t) {
                final label = t["label"] as String;
                final icon = t["icon"] as IconData;
                final selected = _selectedType == label;
                return GestureDetector(
                  onTap: () => setState(() => _selectedType = label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? primaryPurple : theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected ? primaryPurple : theme.dividerColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 16, color: selected ? Colors.white : primaryPurple),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _submit,
                child: const Text("Add Vehicle", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}