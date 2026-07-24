import 'package:flutter/material.dart';

class VisitorItem {
  final String name;
  final String purpose; // "Guest", "Delivery", "Service"
  final String time; // display string, e.g. "Today, 05:30 PM"
  String status; // "Expected", "Checked In", "Checked Out"

  VisitorItem({
    required this.name,
    required this.purpose,
    required this.time,
    this.status = "Expected",
  });
}

class VisitorsController extends ChangeNotifier {
  VisitorsController._internal();
  static final VisitorsController instance = VisitorsController._internal();

  final List<VisitorItem> visitors = [
    VisitorItem(name: "Rohit Sharma", purpose: "Guest", time: "Today, 05:30 PM", status: "Expected"),
    VisitorItem(name: "Amazon Delivery", purpose: "Delivery", time: "Today, 02:15 PM", status: "Checked In"),
    VisitorItem(name: "Priya Singh", purpose: "Guest", time: "Yesterday, 07:00 PM", status: "Checked Out"),
  ];

  void addVisitor(VisitorItem visitor) {
    visitors.insert(0, visitor);
    notifyListeners();
  }

  void removeVisitor(VisitorItem visitor) {
    visitors.remove(visitor);
    notifyListeners();
  }
}