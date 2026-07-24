import 'package:flutter/material.dart';

class AmenityOccupancy {
  final String name;
  int current;
  final int total;
  AmenityOccupancy({required this.name, required this.current, required this.total});
}

class ActivityEntry {
  final String text;
  final DateTime time;
  ActivityEntry(this.text, this.time);
}

class OccupancyController extends ChangeNotifier {
  OccupancyController._internal();
  static final OccupancyController instance = OccupancyController._internal();

  final Map<String, AmenityOccupancy> amenities = {
    "gym": AmenityOccupancy(name: "Gym", current: 0, total: 50),
    "pool": AmenityOccupancy(name: "Swimming Pool", current: 0, total: 30),
    "badminton": AmenityOccupancy(name: "Badminton Court", current: 0, total: 4),
  };

  // Tracks whether the current resident is checked into a given amenity
  final Set<String> _checkedIn = {};

  final List<ActivityEntry> activityLog = [];

  bool isCheckedIn(String key) => _checkedIn.contains(key);

  /// Called after a successful QR scan on an amenity's check-in page.
  /// Automatically toggles entry/exit based on current state.
  void handleScan(String key, {String residentName = "You"}) {
    final amenity = amenities[key];
    if (amenity == null) return;

    if (_checkedIn.contains(key)) {
      // Exit
      _checkedIn.remove(key);
      amenity.current = (amenity.current - 1).clamp(0, amenity.total);
      activityLog.insert(0, ActivityEntry("$residentName checked out of ${amenity.name}", DateTime.now()));
    } else {
      // Entry
      _checkedIn.add(key);
      amenity.current = (amenity.current + 1).clamp(0, amenity.total);
      activityLog.insert(0, ActivityEntry("$residentName checked in at ${amenity.name}", DateTime.now()));
    }
    notifyListeners();
  }
}