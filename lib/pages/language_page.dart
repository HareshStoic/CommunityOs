import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);
  String _selectedLanguage = "English";

  final List<Map<String, String>> languages = const [
    {"name": "English", "native": "English"},
    {"name": "Hindi", "native": "हिन्दी"},
    {"name": "Kannada", "native": "ಕನ್ನಡ"},
    {"name": "Tamil", "native": "தமிழ்"},
    {"name": "Telugu", "native": "తెలుగు"},
    {"name": "Marathi", "native": "मराठी"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text("Language",
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final lang = languages[index];
          final selected = lang["name"] == _selectedLanguage;
          return Material(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => setState(() => _selectedLanguage = lang["name"]!),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected ? primaryPurple : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lang["name"]!,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                          const SizedBox(height: 2),
                          Text(lang["native"]!, style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
                        ],
                      ),
                    ),
                    Icon(
                      selected ? Icons.check_circle : Icons.circle_outlined,
                      color: selected ? primaryPurple : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}