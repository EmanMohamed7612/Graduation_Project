import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key, this.onPost});
  final VoidCallback? onPost;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPost,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFC9A875),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            "Post to Community",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFC9A875)),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: const Color(0xFF6D4C41),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
        ),
      ],
    );
  }
}
