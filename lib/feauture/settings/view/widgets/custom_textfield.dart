import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String initialValue;
  final IconData icon;
  final int maxLines;

  const CustomInputField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.brown[700]),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(color: Colors.brown[700], fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            decoration: InputDecoration(
              fillColor: const Color(0xFFFDF8F5), // لون الخلفية الفاتح في الصورة
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}