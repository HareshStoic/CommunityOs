import 'package:flutter/material.dart';
import 'package:communityos/controllers/complaints_controller.dart';
import 'package:communityos/widgets/raise_complaint_page.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Complaints",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryPurple,
        onPressed: () async {
          final submitted = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const RaiseComplaintPage()),
          );

          if (!context.mounted) return;

          if (submitted == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Complaint submitted successfully")),
            );
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Raise Complaint", style: TextStyle(color: Colors.white)),
      ),
      body: AnimatedBuilder(
        animation: ComplaintsController.instance,
        builder: (context, _) {
          final complaints = ComplaintsController.instance.complaints;

          if (complaints.isEmpty) {
            return Center(
              child: Text(
                "No complaints raised yet.",
                style: TextStyle(color: theme.textTheme.bodySmall?.color),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: complaints.length,
            separatorBuilder: (context, child) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final c = complaints[index];
              final resolved = c.status == "Resolved";
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
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: (resolved ? const Color(0xFF2FAE6B) : const Color(0xFFFFC94D)).withValues(alpha: 0.12),
                      child: Icon(
                        resolved ? Icons.check_circle_outline : Icons.hourglass_empty,
                        color: resolved ? const Color(0xFF2FAE6B) : const Color(0xFFFFC94D),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: theme.textTheme.bodyLarge?.color,
                              )),
                          const SizedBox(height: 4),
                          Text(c.category, style: TextStyle(fontSize: 11, color: primaryPurple, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(ComplaintsController.instance.formatDate(c.date),
                              style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: (resolved ? const Color(0xFF2FAE6B) : const Color(0xFFFFC94D)).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        c.status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: resolved ? const Color(0xFF2FAE6B) : const Color(0xFFB8860B),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}