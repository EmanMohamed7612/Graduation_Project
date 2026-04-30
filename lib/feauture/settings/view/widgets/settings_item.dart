import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? textColor;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      visualDensity: const VisualDensity(
        vertical: -2,
      ), // لتقليل المسافات الرأسية قليلاً
      leading: Icon(
        icon,
        color: textColor ?? const Color(0xFF6D4C41),
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? const Color(0xFF3E2723),
          fontSize: 14,
          fontFamily: 'Arimo',
          fontWeight: FontWeight.w400,
          height: 1.50,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(
                color: const Color(0xFF8D6E63),
                fontSize: 12.25,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Color(0xFF8D6E63),
          ),
        ],
      ),
    );
  }
}
