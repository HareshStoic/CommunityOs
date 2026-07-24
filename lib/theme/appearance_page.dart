import 'package:flutter/material.dart';
import 'package:communityos/theme/theme_controller.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Appearance",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, mode, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _themeOption(
                context: context,
                title: "Light Mode",
                subtitle: "Bright background, dark text",
                icon: Icons.light_mode_outlined,
                selected: mode == ThemeMode.light,
                onTap: () => themeNotifier.value = ThemeMode.light,
              ),
              const SizedBox(height: 12),
              _themeOption(
                context: context,
                title: "Dark Mode",
                subtitle: "Dark background, light text",
                icon: Icons.dark_mode_outlined,
                selected: mode == ThemeMode.dark,
                onTap: () => themeNotifier.value = ThemeMode.dark,
              ),
              const SizedBox(height: 12),
              _themeOption(
                context: context,
                title: "System Default",
                subtitle: "Match your device settings",
                icon: Icons.settings_suggest_outlined,
                selected: mode == ThemeMode.system,
                onTap: () => themeNotifier.value = ThemeMode.system,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _themeOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? primaryPurple : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: primaryPurple.withValues(alpha: 0.12),
                child: Icon(icon, color: primaryPurple),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        )),
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
  }
}