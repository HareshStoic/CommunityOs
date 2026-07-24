import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatefulWidget {
  // final VoidCallback? onThemeChanged;
  final ValueChanged<int>? onTap;
  final VoidCallback? onCenterTap;

  const BottomNavBarWidget({
    super.key,
    // this.onThemeChanged,
    this.onTap,
    this.onCenterTap,
  });

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _currentIndex = 0;

  static const Color primaryPurple = Color(0xFF6C5DD3);

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    widget.onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      color: theme.cardColor,
      elevation: 10,
      child: SizedBox(
        height: 62,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(theme, icon: Icons.home_outlined, label: "Home", index: 0),
            _navItem(theme, icon: Icons.bookmark_border, label: "Bookings", index: 1),
            const SizedBox(width: 48), // space for the floating center button
            _navItem(theme, icon: Icons.bolt_outlined, label: "Activity", index: 2),
            _navItem(theme, icon: Icons.person_outline, label: "Profile", index: 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
      ThemeData theme, {
        required IconData icon,
        required String label,
        required int index,
      }) {
    final bool selected = _currentIndex == index;
    final unselectedColor = theme.textTheme.bodySmall?.color ?? Colors.grey;

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? primaryPurple : unselectedColor,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? primaryPurple : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The floating purple center button from the design (QR / scan action).
/// Use this as the Scaffold's floatingActionButton alongside
/// floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked.
class CenterFabButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CenterFabButton({super.key, this.onTap});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: primaryPurple,
      shape: const CircleBorder(),
      elevation: 4,
      child: const Icon(Icons.qr_code_scanner, color: Colors.white),
    );
  }
}