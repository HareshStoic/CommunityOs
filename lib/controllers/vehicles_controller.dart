import 'package:flutter/material.dart';

class VehicleItem {
  final String number;
  final String type; // e.g. "Sedan", "SUV", "Bike"
  final IconData icon;

  VehicleItem({
    required this.number,
    required this.type,
    required this.icon,
  });
}

/// Global vehicles store — Parking page reads/writes here so the list
/// stays live without needing setState plumbing across pages.
class VehiclesController extends ChangeNotifier {
  VehiclesController._internal();
  static final VehiclesController instance = VehiclesController._internal();

  final List<VehicleItem> vehicles = [
    VehicleItem(number: "MH 12 AB 1234", type: "Sedan", icon: Icons.directions_car),
    VehicleItem(number: "MH 12 XY 5678", type: "SUV", icon: Icons.directions_car_filled),
  ];

  void addVehicle(VehicleItem vehicle) {
    vehicles.add(vehicle);
    notifyListeners();
  }

  void removeVehicle(VehicleItem vehicle) {
    vehicles.remove(vehicle);
    notifyListeners();
  }
}