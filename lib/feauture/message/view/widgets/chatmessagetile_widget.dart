import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/inboxmessage_model.dart';

class ChatTile extends StatelessWidget {
  final InboxItemModel chat;
  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            // إضافة حماية هنا
            backgroundImage: (chat.otherAvatar != null && chat.otherAvatar.isNotEmpty)
                ? NetworkImage(chat.otherAvatar)
                : const AssetImage('assets/images/default_user.png') as ImageProvider,
            // إضافة معالج أخطاء لو الرابط باظ أثناء التحميل
            onBackgroundImageError: (exception, stackTrace) {
              debugPrint("Image error: $exception");
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chat.otherUserName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      _formatTime(chat.lastMessageTime), // وظيفة لتنسيق الوقت (مثلا: 5 min ago)
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    if (chat.unreadCount > 0)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFBC8E5E), // اللون البني الفاتح في الصورة
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hours ago";
    return "${diff.inDays} day ago";
  }
}