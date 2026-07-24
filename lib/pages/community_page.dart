import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final posts = [
      {"name": "Priya Singh", "message": "Anyone up for a badminton match this evening?", "time": "20 min ago", "avatar": "https://i.pravatar.cc/150?img=45"},
      {"name": "Rohit Sharma", "message": "Found a lost cat near Block C. DM me if it's yours!", "time": "1 hr ago", "avatar": "https://i.pravatar.cc/150?img=12"},
      {"name": "Neha Verma", "message": "Yoga session at the garden, 7 AM every Sunday. Join us!", "time": "3 hr ago", "avatar": "https://i.pravatar.cc/150?img=32"},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Community",
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryPurple,
        onPressed: () {},
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("New Post", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final p = posts[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 20, backgroundImage: NetworkImage(p["avatar"]!)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p["name"]!,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                      const SizedBox(height: 4),
                      Text(p["message"]!,
                          style: TextStyle(fontSize: 13, color: theme.textTheme.bodyLarge?.color, height: 1.4)),
                      const SizedBox(height: 6),
                      Text(p["time"]!, style: TextStyle(fontSize: 11, color: theme.textTheme.bodySmall?.color)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}