import 'package:flutter/material.dart';

class ComplaintItem {
  final String title;
  final String category; // "Plumbing", "Electrical", "Security", "Cleanliness", "Other"
  final String description;
  final DateTime date;
  String status; // "In Progress", "Resolved"

  ComplaintItem({
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    this.status = "In Progress",
  });
}

class ComplaintsController extends ChangeNotifier {
  ComplaintsController._internal();
  static final ComplaintsController instance = ComplaintsController._internal();

  static const List<String> _monthAbbrev = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
  ];

  String formatDate(DateTime date) => "${_monthAbbrev[date.month - 1]} ${date.day}, ${date.year}";

  final List<ComplaintItem> complaints = [];

  void addComplaint(ComplaintItem complaint) {
    complaints.insert(0, complaint);
    notifyListeners();
  }

  void resolveComplaint(ComplaintItem complaint) {
    complaint.status = "Resolved";
    notifyListeners();
  }
}