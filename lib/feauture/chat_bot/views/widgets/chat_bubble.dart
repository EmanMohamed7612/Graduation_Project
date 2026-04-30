import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatMessage {
  final String text;
  final String time;
  final bool isAi;

  ChatMessage({required this.text, required this.time, required this.isAi});
}

// ودجت فقاعة الدردشة
class ChatBubble extends StatelessWidget {
  final ChatMessage msg;

  const ChatBubble({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    bool isAi = msg.isAi;
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isAi ? const Color(0xFFEFEBE9) : const Color(0xFF6D4C41),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isAi)
              const Row(
                children: [
                  Icon(
                    Icons.auto_awesome_outlined,
                    color: Color(0xFFC9A875),
                    size: 12,
                  ),
                  Text(
                    '  AI',
                    style: TextStyle(color: Color(0xFFC9A875), fontSize: 14),
                  ),
                ],
              ),
            const SizedBox(height: 4),
            MarkdownBody(
              data: msg.text,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  // تطبيق نفس الألوان القديمة على الـ Paragraph (p)
                  color: isAi ? const Color(0xFF3E2723) : Colors.white,
                  fontSize: 16,
                ),
                // يمكنك تعديل ستايل الـ Strong (bold) لو حابة
                strong: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // Text(
            //   msg.text,
            //   style: TextStyle(
            //     color: isAi ? const Color(0xFF3E2723) : Colors.white,
            //     fontSize: 14,
            //   ),
            // ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                msg.time,
                style: TextStyle(
                  color: isAi ? const Color(0xFF8D6E63) : Colors.white70,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
