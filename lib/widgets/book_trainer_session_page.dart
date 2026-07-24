import 'package:flutter/material.dart';
import 'package:communityos/controllers/bookings_controller.dart';

class BookTrainerSessionPage extends StatefulWidget {
  final String trainerName;

  const BookTrainerSessionPage({
    super.key,
    this.trainerName = "Harsh Singh",
  });

  @override
  State<BookTrainerSessionPage> createState() => _BookTrainerSessionPageState();
}

class _BookTrainerSessionPageState extends State<BookTrainerSessionPage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);

  late final List<DateTime> _next7Days;
  int _selectedDateIndex = 0;
  int? _selectedSlotIndex;
  int _selectedDurationIndex = 0; // index into _durations

  static const List<String> _monthAbbrev = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
  ];
  static const List<String> _weekdayAbbrev = [
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun",
  ];

  // Trainer available 6 AM - 9 PM, sessions in 1-hour blocks.
  static const int _openHour = 6;
  static const int _closeHour = 21;

  final List<Map<String, dynamic>> _durations = const [
    {"label": "30 min", "minutes": 30},
    {"label": "60 min", "minutes": 60},
    {"label": "90 min", "minutes": 90},
  ];

  final List<String> _sessionTypes = const ["Strength", "Cardio", "Flexibility", "Full Body"];
  String _selectedSessionType = "Strength";

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
    for (int h = _openHour; h < _closeHour; h++) {
      result.add("${_formatHour(h)} - ${_formatHour(h + 1)}");
    }
    return result;
  }

  /// Deterministically block a couple of slots per date so the UI shows
  /// some unavailable slots (mirrors AmenityBookingDetailPage behavior).
  Set<int> _bookedSlotIndicesFor(DateTime date, int slotCount) {
    final seed = date.day + date.month;
    final booked = <int>{};
    if (slotCount > 3) booked.add(seed % slotCount);
    if (slotCount > 6) booked.add((seed * 2) % slotCount);
    return booked;
  }

  void _confirmBooking() {
    if (_selectedSlotIndex == null) return;

    final date = _next7Days[_selectedDateIndex];
    final slotLabel = _slots[_selectedSlotIndex!];
    final duration = _durations[_selectedDurationIndex]["label"] as String;

    BookingsController.instance.addBooking(
      BookingItem(
        amenityTitle: "Training - $_selectedSessionType",
        icon: Icons.self_improvement,
        color: primaryPurple,
        date: date,
        timeLabel: "$slotLabel ($duration)",
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
          "Book Session",
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
                // Trainer header card
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
                      const CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=33"),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.trainerName,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                            const SizedBox(height: 4),
                            Text("Certified Personal Trainer",
                                style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                Text("Session Type",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _sessionTypes.map((type) {
                    final selected = _selectedSessionType == type;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedSessionType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: selected ? primaryPurple : theme.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selected ? primaryPurple : theme.dividerColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),
                Text("Duration",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(_durations.length, (index) {
                    final selected = _selectedDurationIndex == index;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == _durations.length - 1 ? 0 : 10),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedDurationIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selected ? primaryPurple : theme.cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected ? primaryPurple : theme.dividerColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              _durations[index]["label"] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: selected ? Colors.white : theme.textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
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
                    separatorBuilder: (context, child) => const SizedBox(width: 10),
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
                    _selectedSlotIndex == null ? "Select a time slot" : "Confirm Session",
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