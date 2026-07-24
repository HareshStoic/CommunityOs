import 'package:flutter/material.dart';

class BookingItem {
  final String amenityTitle;
  final IconData icon;
  final Color color;
  final DateTime date;
  final String timeLabel; // e.g. "06:00 AM - 07:00 AM"
  String status; // "Confirmed", "Cancelled"

  BookingItem({
    required this.amenityTitle,
    required this.icon,
    required this.color,
    required this.date,
    required this.timeLabel,
    this.status = "Confirmed",
  });
}

/// Global bookings store — any page can read/add/cancel bookings and
/// every listener (e.g. My Bookings page) rebuilds automatically.
class BookingsController extends ChangeNotifier {
  BookingsController._internal();
  static final BookingsController instance = BookingsController._internal();

  final List<BookingItem> upcomingBookings = [];

  void addBooking(BookingItem item) {
    upcomingBookings.add(item);
    notifyListeners();
  }

  void cancelBooking(BookingItem item) {
    item.status = "Cancelled";
    upcomingBookings.remove(item);
    notifyListeners();
  }
}