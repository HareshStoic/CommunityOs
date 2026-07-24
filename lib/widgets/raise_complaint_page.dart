import 'package:flutter/material.dart';
import 'package:communityos/controllers/complaints_controller.dart';

class RaiseComplaintPage extends StatefulWidget {
  const RaiseComplaintPage({super.key});

  @override
  State<RaiseComplaintPage> createState() => _RaiseComplaintPageState();
}

class _RaiseComplaintPageState extends State<RaiseComplaintPage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {"label": "Plumbing", "icon": Icons.plumbing_outlined},
    {"label": "Electrical", "icon": Icons.electrical_services_outlined},
    {"label": "Security", "icon": Icons.security_outlined},
    {"label": "Cleanliness", "icon": Icons.cleaning_services_outlined},
    {"label": "Other", "icon": Icons.more_horiz},
  ];
  String _selectedCategory = "Plumbing";

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ComplaintsController.instance.addComplaint(
      ComplaintItem(
        title: _titleController.text.trim(),
        category: _selectedCategory,
        description: _descriptionController.text.trim(),
        date: DateTime.now(),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Raise Complaint",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text("Title",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.textTheme.bodySmall?.color)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                hintText: "e.g. Water leakage in parking",
                prefixIcon: const Icon(Icons.title, color: primaryPurple, size: 20),
                filled: true,
                fillColor: theme.cardColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: primaryPurple, width: 1.5),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a title";
                }
                return null;
              },
            ),
            const SizedBox(height: 22),

            Text("Category",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.textTheme.bodySmall?.color)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _categories.map((c) {
                final label = c["label"] as String;
                final icon = c["icon"] as IconData;
                final selected = _selectedCategory == label;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? primaryPurple : theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected ? primaryPurple : theme.dividerColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 16, color: selected ? Colors.white : primaryPurple),
                        const SizedBox(width: 6),
                        Text(label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected ? Colors.white : theme.textTheme.bodyLarge?.color,
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),

            Text("Description",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.textTheme.bodySmall?.color)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                hintText: "Describe the issue in detail...",
                filled: true,
                fillColor: theme.cardColor,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: primaryPurple, width: 1.5),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please describe the issue";
                }
                return null;
              },
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _submit,
                child: const Text("Submit Complaint", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}