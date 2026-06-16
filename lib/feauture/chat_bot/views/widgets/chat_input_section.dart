import 'package:flutter/material.dart';

class ChatInputSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputSection({super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFAF8F5),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFE0D5C7)),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Ask me anything...",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: const Color(0xFFD4AF77),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: onSend,
            ),
          ),
        ],
      ),
    );
  }
}