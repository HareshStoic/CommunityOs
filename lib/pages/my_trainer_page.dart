import 'package:flutter/material.dart';
import 'package:communityos/widgets/book_trainer_session_page.dart';

class MyTrainerPage extends StatelessWidget {
  const MyTrainerPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("My Trainer",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=33"),
                ),
                const SizedBox(height: 12),
                Text("Harsh Singh",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    )),
                const SizedBox(height: 4),
                Text("Certified Personal Trainer",
                    style: TextStyle(fontSize: 13, color: theme.textTheme.bodySmall?.color)),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => const Icon(Icons.star, color: Color(0xFFFFC94D), size: 18)),
                ),
                const SizedBox(height: 4),
                Text("4.9 (120 sessions)",
                    style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _statCard(theme, "6+", "Years Exp.")),
              const SizedBox(width: 12),
              Expanded(child: _statCard(theme, "Strength &\nCardio", "Speciality")),
            ],
          ),
          const SizedBox(height: 20),
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
                const Icon(Icons.event_available_outlined, color: primaryPurple),
                const SizedBox(width: 12),
                Expanded(
                  child: Text("Next session: Tomorrow, 07:00 AM",
                      style: TextStyle(fontSize: 13, color: theme.textTheme.bodyLarge?.color)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              // onPressed: () {},
              onPressed: () async {
                final booked = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (_) => const BookTrainerSessionPage()),
                );

                if (!context.mounted) return;

                if (booked == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Session booked! Check My Bookings.")),
                  );
                }
              },
              child: const Text("Book Session", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(ThemeData theme, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Text(value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              )),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color)),
        ],
      ),
    );
  }
}