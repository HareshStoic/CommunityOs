import 'package:flutter/material.dart';
import 'package:communityos/controllers/visitors_controller.dart';
import 'package:communityos/widgets/add_visitor_page.dart';

class VisitorsPage extends StatelessWidget {
  const VisitorsPage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Visitors",
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
          final added = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const AddVisitorPage()),
          );

          if (!context.mounted) return;

          if (added == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Visitor added successfully")),
            );
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Visitor", style: TextStyle(color: Colors.white)),
      ),
      body: AnimatedBuilder(
        animation: VisitorsController.instance,
        builder: (context, _) {
          final visitors = VisitorsController.instance.visitors;

          if (visitors.isEmpty) {
            return Center(
              child: Text(
                "No visitors logged yet.",
                style: TextStyle(color: theme.textTheme.bodySmall?.color),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: visitors.length,
            separatorBuilder: (context, child) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final v = visitors[index];
              Color statusColor;
              switch (v.status) {
                case "Expected":
                  statusColor = const Color(0xFFFFC94D);
                  break;
                case "Checked In":
                  statusColor = const Color(0xFF2FAE6B);
                  break;
                default:
                  statusColor = theme.textTheme.bodySmall?.color ?? Colors.black45;
              }
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
                      backgroundColor: primaryPurple.withValues(alpha: 0.12),
                      child: Icon(
                        v.purpose == "Delivery"
                            ? Icons.local_shipping_outlined
                            : v.purpose == "Service"
                            ? Icons.build_outlined
                            : Icons.person_outline,
                        color: primaryPurple,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(v.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: theme.textTheme.bodyLarge?.color,
                              )),
                          const SizedBox(height: 4),
                          Text(v.time, style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(v.status,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
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