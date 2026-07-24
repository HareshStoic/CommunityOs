import 'package:flutter/material.dart';
import 'package:communityos/controllers/bookings_controller.dart';

class AmenityBookingDetailPage extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String hoursLabel; // e.g. "Open 6 AM - 10 PM" (shown as subtitle)
  final int openHour; // 24hr format, e.g. 6
  final int closeHour; // 24hr format, e.g. 22. Use 0 & 24 for "open 24 hours"

  const AmenityBookingDetailPage({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.hoursLabel,
    required this.openHour,
    required this.closeHour,
  });

  @override
  State<AmenityBookingDetailPage> createState() => _AmenityBookingDetailPageState();
}

class _AmenityBookingDetailPageState extends State<AmenityBookingDetailPage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);

  late final List<DateTime> _next7Days;
  int _selectedDateIndex = 0;
  int? _selectedSlotIndex;
  int _guests = 1;

  static const List<String> _monthAbbrev = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
  ];
  static const List<String> _weekdayAbbrev = [
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",
  ];

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _next7Days = List.generate(
      7,
          (i) => DateTime(today.year, today.month, today.day + i),
    );
  }

  String _formatHour(int hour24) {
    final period = hour24 >= 12 ? "PM" : "AM";
    int hour12 = hour24 % 12;
    if (hour12 == 0) hour12 = 12;
    return "${hour12.toString().padLeft(2, '0')}:00 $period";
  }

  List<String> get _slots {
    final List<String> result = [];
    for (int h = widget.openHour; h < widget.closeHour; h++) {
      result.add("${_formatHour(h)} - ${_formatHour(h + 1)}");
    }
    return result;
  }

  /// Deterministically "pre-book" a few slots per date so the UI has
  /// some greyed-out / unavailable slots to demonstrate real behaviour.
  Set<int> _bookedSlotIndicesFor(DateTime date, int slotCount) {
    final seed = date.day + date.month;
    final booked = <int>{};
    if (slotCount > 2) booked.add(seed % slotCount);
    if (slotCount > 4) booked.add((seed * 3) % slotCount);
    return booked;
  }

  void _confirmBooking() {
    if (_selectedSlotIndex == null) return;

    final date = _next7Days[_selectedDateIndex];
    final slotLabel = _slots[_selectedSlotIndex!];

    BookingsController.instance.addBooking(
      BookingItem(
        amenityTitle: widget.title,
        icon: widget.icon,
        color: widget.color,
        date: date,
        timeLabel: slotLabel,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final slots = _slots;
    final selectedDate = _next7Days[_selectedDateIndex];
    final bookedIndices = _bookedSlotIndicesFor(selectedDate, slots.length);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Header card
                Container(
                  padding: const EdgeInsets.all(16),
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
                        radius: 26,
                        backgroundColor: widget.color.withValues(alpha: 0.12),
                        child: Icon(widget.icon, color: widget.color, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                            const SizedBox(height: 4),
                            Text(widget.hoursLabel,
                                style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                Text("Select Date",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                const SizedBox(height: 12),

                SizedBox(
                  height: 74,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _next7Days.length,
                    separatorBuilder: (context,child) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final date = _next7Days[index];
                      final selected = index == _selectedDateIndex;
                      return GestureDetector(
                        onTap: () => setState(() {
                          _selectedDateIndex = index;
                          _selectedSlotIndex = null;
                        }),
                        child: Container(
                          width: 58,
                          decoration: BoxDecoration(
                            color: selected ? primaryPurple : theme.cardColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected ? primaryPurple : theme.dividerColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                index == 0 ? "Today" : _weekdayAbbrev[date.weekday - 1],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: selected ? Colors.white70 : theme.textTheme.bodySmall?.color,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${date.day}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selected ? Colors.white : theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                              Text(
                                _monthAbbrev[date.month - 1],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: selected ? Colors.white70 : theme.textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),
                Text("Guests",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Number of people",
                            style: TextStyle(fontSize: 13, color: theme.textTheme.bodyLarge?.color)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        color: primaryPurple,
                        onPressed: _guests > 1 ? () => setState(() => _guests--) : null,
                      ),
                      Text("$_guests",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        color: primaryPurple,
                        onPressed: _guests < 10 ? () => setState(() => _guests++) : null,
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 24),
                Text("Select Time Slot",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                const SizedBox(height: 12),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: slots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.6,
                  ),
                  itemBuilder: (context, index) {
                    final isBooked = bookedIndices.contains(index);
                    final isSelected = _selectedSlotIndex == index;

                    return GestureDetector(
                      onTap: isBooked ? null : () => setState(() => _selectedSlotIndex = index),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isBooked
                              ? theme.dividerColor.withValues(alpha: 0.15)
                              : isSelected
                              ? primaryPurple
                              : theme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? primaryPurple : theme.dividerColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          slots[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: isBooked
                                ? theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5)
                                : isSelected
                                ? Colors.white
                                : theme.textTheme.bodyLarge?.color,
                            decoration: isBooked ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),

          // Bottom confirm bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, -3)),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: primaryPurple.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _selectedSlotIndex == null ? null : _confirmBooking,
                  child: Text(
                    _selectedSlotIndex == null ? "Select a time slot" : "Confirm Booking",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}