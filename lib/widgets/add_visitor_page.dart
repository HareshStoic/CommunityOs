import 'package:flutter/material.dart';
import 'package:communityos/controllers/visitors_controller.dart';

class AddVisitorPage extends StatefulWidget {
  const AddVisitorPage({super.key});

  @override
  State<AddVisitorPage> createState() => _AddVisitorPageState();
}

class _AddVisitorPageState extends State<AddVisitorPage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final List<String> _purposes = ["Guest", "Delivery", "Service"];
  String _selectedPurpose = "Guest";

  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme(
              brightness: isDark ? Brightness.dark : Brightness.light,
              primary: primaryPurple,
              onPrimary: Colors.white,
              secondary: primaryPurple,
              onSecondary: Colors.white,
              surface: Theme.of(context).cardColor,
              onSurface: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
              error: Colors.red,
              onError: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  String get _formattedTime {
    final now = TimeOfDay.now();
    final isLaterToday = _selectedTime.hour > now.hour ||
        (_selectedTime.hour == now.hour && _selectedTime.minute >= now.minute);
    final dayLabel = isLaterToday ? "Today" : "Tomorrow";
    return "$dayLabel, ${_selectedTime.format(context)}";
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    VisitorsController.instance.addVisitor(
      VisitorItem(
        name: _nameController.text.trim(),
        purpose: _selectedPurpose,
        time: _formattedTime,
        status: "Expected",
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
          "Add Visitor",
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
            Text("Visitor Name",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.textTheme.bodySmall?.color)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                hintText: "e.g. Rohit Sharma",
                prefixIcon: const Icon(Icons.person_outline, color: primaryPurple, size: 20),
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
                  return "Please enter the visitor's name";
                }
                return null;
              },
            ),
            const SizedBox(height: 22),

            Text("Purpose of Visit",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.textTheme.bodySmall?.color)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _purposes.map((p) {
                final selected = _selectedPurpose == p;
                final icon = p == "Delivery"
                    ? Icons.local_shipping_outlined
                    : p == "Service"
                    ? Icons.build_outlined
                    : Icons.person_outline;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPurpose = p),
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
                        Text(p,
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

            Text("Expected Time",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.textTheme.bodySmall?.color)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickTime,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: primaryPurple, size: 20),
                    const SizedBox(width: 10),
                    Text(_formattedTime, style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color)),
                  ],
                ),
              ),
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
                child: const Text("Add Visitor", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}