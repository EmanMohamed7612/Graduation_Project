import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String name, initials, time, message;

  const CommentCard({
    super.key,
    required this.name,
    required this.initials,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF8D7766),
            child: Text(initials, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            // يجعل المحتوى يتكيف مع عرض الشاشة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: const Color(0xFF3E2723),
                        fontSize: 14,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w600,
                        height: 1.50,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: const Color(0xFF8D6E63),
                        fontSize: 10.50,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: const Color(0xFF6D4C41),
                    fontSize: 12.25,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
