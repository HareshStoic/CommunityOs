import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Activity",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TodaysActivityCard(),
          SizedBox(height: 16),
          AmenityUsageCard(),
          SizedBox(height: 16),
          PeakHoursCard(),
        ],
      ),
    );
  }
}

// ---------------- Today's Activity ----------------

class TodaysActivityCard extends StatelessWidget {
  const TodaysActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final activities = [
      {
        "icon": Icons.fitness_center,
        "text": "Rahul Sharma checked in at Gym",
        "time": "09:15 AM",
        "color": const Color(0xFF6C5DD3),
      },
      {
        "icon": Icons.person_outline,
        "text": "Visitor Aman Kumar entered",
        "time": "09:10 AM",
        "color": const Color(0xFF4DA8FF),
      },
      {
        "icon": Icons.local_parking_outlined,
        "text": "Parking slot A-102 occupied",
        "time": "09:05 AM",
        "color": const Color(0xFFFF9770),
      },
      {
        "icon": Icons.check_circle_outline,
        "text": "Complaint #1245 resolved",
        "time": "08:50 AM",
        "color": const Color(0xFF2FAE6B),
      },
      {
        "icon": Icons.pool,
        "text": "Swimming Pool booking by Neha",
        "time": "08:30 AM",
        "color": const Color(0xFF4DA8FF),
      },
    ];

    return _CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Activity",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 2),
          Text(
            "Real-time updates",
            style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
          ),
          const SizedBox(height: 16),
          ...activities.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: (a["color"] as Color).withValues(alpha: 0.12),
                  child: Icon(a["icon"] as IconData, size: 16, color: a["color"] as Color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    a["text"] as String,
                    style: TextStyle(fontSize: 13, color: theme.textTheme.bodyLarge?.color),
                  ),
                ),
                Text(
                  a["time"] as String,
                  style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

// ---------------- Amenity Usage (Donut Chart) ----------------

class AmenityUsageCard extends StatelessWidget {
  const AmenityUsageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final data = [
      {"label": "Gym", "value": 72.0, "color": const Color(0xFF6C5DD3)},
      {"label": "Pool", "value": 18.0, "color": const Color(0xFF4DA8FF)},
      {"label": "Badminton", "value": 6.0, "color": const Color(0xFF2FAE6B)},
      {"label": "Tennis", "value": 3.0, "color": const Color(0xFFFF9770)},
      {"label": "Others", "value": 1.0, "color": const Color(0xFFB0B0C3)},
    ];

    return _CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amenity Usage",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
              ),
              Text(
                "This Week",
                style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 44,
                        sections: data.map((d) {
                          return PieChartSectionData(
                            value: d["value"] as double,
                            color: d["color"] as Color,
                            radius: 22,
                            showTitle: false,
                          );
                        }).toList(),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "72%",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                        ),
                        Text(
                          "Total Usage",
                          style: TextStyle(fontSize: 10, color: theme.textTheme.bodySmall?.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.map((d) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: d["color"] as Color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              d["label"] as String,
                              style: TextStyle(fontSize: 12, color: theme.textTheme.bodyLarge?.color),
                            ),
                          ),
                          Text(
                            "${(d["value"] as double).toInt()}%",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------- Peak Hours (Line Chart) ----------------

class PeakHoursCard extends StatelessWidget {
  const PeakHoursCard({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // x: hour index (0 = 6AM ... 6 = 9PM, step ~2.5 hrs), y: occupancy count
    final spots = <FlSpot>[
      const FlSpot(0, 5),
      const FlSpot(1, 45),
      const FlSpot(2, 62),
      const FlSpot(3, 55),
      const FlSpot(4, 70),
      const FlSpot(5, 82),
      const FlSpot(6, 68),
      const FlSpot(7, 72),
      const FlSpot(8, 40),
      const FlSpot(9, 18),
      const FlSpot(10, 8),
    ];

    return _CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Peak Hours (Gym)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
              ),
              Text(
                "This Week",
                style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.05),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: TextStyle(fontSize: 10, color: theme.textTheme.bodySmall?.color),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      reservedSize: 26,
                      getTitlesWidget: (value, meta) {
                        const labels = ["6 AM", "", "9 AM", "", "12 PM", "", "3 PM", "", "6 PM", "", "9 PM"];
                        final idx = value.toInt();
                        if (idx < 0 || idx >= labels.length || labels[idx].isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            labels[idx],
                            style: TextStyle(fontSize: 10, color: theme.textTheme.bodySmall?.color),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => isDark ? Colors.white : Colors.black87,
                    getTooltipItems: (touchedSpots) => touchedSpots.map((s) {
                      return LineTooltipItem(
                        s.y.toInt().toString(),
                        TextStyle(
                          color: isDark ? Colors.black87 : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: primaryPurple,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          primaryPurple.withValues(alpha: 0.25),
                          primaryPurple.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Shared Card Wrapper ----------------

class _CardWrapper extends StatelessWidget {
  final Widget child;
  const _CardWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }
}