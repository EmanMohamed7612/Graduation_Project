import 'package:flutter/material.dart';

class StoryField extends StatelessWidget {
  const StoryField({super.key, required this.controller});
final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Share Your Story",
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 14,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w600,
            height: 1.50,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller:controller,
          maxLines: 5,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: "Tell the community about your craft...",
            hintStyle: TextStyle(
              color: const Color(0xFFBCAAA4),
              fontSize: 12.25,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFFEFEBE9)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
