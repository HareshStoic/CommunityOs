import 'package:flutter/material.dart';

class MaintenanceBillsPage extends StatelessWidget {
  const MaintenanceBillsPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bills = [
      {"month": "July 2026", "amount": "₹3,200", "status": "Due", "dueDate": "Due on 25 Jul"},
      {"month": "June 2026", "amount": "₹3,200", "status": "Paid", "dueDate": "Paid on 22 Jun"},
      {"month": "May 2026", "amount": "₹3,000", "status": "Paid", "dueDate": "Paid on 20 May"},
      {"month": "April 2026", "amount": "₹3,000", "status": "Paid", "dueDate": "Paid on 18 Apr"},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Maintenance Bills",
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF7B6EF6), Color(0xFF6C5DD3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Current Due", style: TextStyle(color: Colors.white70, fontSize: 13)),
                      SizedBox(height: 6),
                      Text("₹3,200", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Due on 25 Jul 2026", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.receipt_long_outlined, color: Colors.white, size: 44),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Redirecting to payment...")),
                );
              },
              child: const Text("Pay Now", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 24),
          Text("Bill History",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
          const SizedBox(height: 12),
          ...bills.map((b) {
            final paid = b["status"] == "Paid";
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
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
                    radius: 22,
                    backgroundColor: (paid ? const Color(0xFF2FAE6B) : const Color(0xFFFFC94D)).withValues(alpha: 0.12),
                    child: Icon(
                      paid ? Icons.check_circle_outline : Icons.hourglass_empty,
                      color: paid ? const Color(0xFF2FAE6B) : const Color(0xFFFFC94D),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b["month"]!,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                        const SizedBox(height: 4),
                        Text(b["dueDate"]!, style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                      ],
                    ),
                  ),
                  Text(b["amount"]!,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}