import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String initialValue;
  final IconData icon;
  final int maxLines;
 final TextEditingController controller;
  const CustomInputField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.icon,
    required this.controller,
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
              Icon(icon, size: 18, color: Color(0xFF6D4C41)),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF6D4C41),
                  fontSize: 10.50,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            //  hintText: initialValue,
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: initialValue,
              fillColor: const Color(
                0xFFFDF8F5,
              ), // لون الخلفية الفاتح في الصورة
              filled: true,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),

                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
