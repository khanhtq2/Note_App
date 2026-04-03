import 'package:flutter/material.dart';
import 'package:fe_note_app/core/responsive.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const ThemeToggleButton({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {


    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.light_mode : Icons.dark_mode,
        size: Responsive.isMobile(context) ? 24 : 20, 
      ),
      onPressed: onToggle,
      tooltip: 'Đổi chế độ sáng/tối',
    );
  }
}
