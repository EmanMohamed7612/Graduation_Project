import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/rescources/colors.dart';
import 'package:graduation2/feauture/message/manager/message_cubit.dart';
import 'package:graduation2/feauture/message/manager/message_state.dart';

// تأكد من استيراد الـ Cubit والـ Model الخاص بمشروعك

class ChatScreen extends StatefulWidget {
  final String otherUserId;
  String otherUserName;
  ChatScreen({
    super.key,
    required this.otherUserId,
    this.otherUserName = "Un Known",
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // 🔹 استدعاء تحميل الرسائل فور فتح المحادثة لتسجيل الـ currentChattingWithId داخل الـ Cubit
    context.read<MessagesCubit>().loadMessages(widget.otherUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEBE9),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ChatColors.primaryBrown,
                    ),
                  );
                } else if (state is MessagesSuccess) {
                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      // تحديد هل الرسالة مرسلة مني أم مستلمة
                      bool isMe = message.isOwnMessage;

                      // نمرر الوقت بعد تحويله لصيغة مناسبة (ساعة:دقيقة)
                      String formattedTime =
                          "${message.sentAt.hour}:${message.sentAt.minute}";

                      return _buildChatBubble(
                        message.content,
                        formattedTime,
                        isMe,
                      );
                    },
                  );
                } else {
                  return Center(child: Text("ابدأ المحادثة الآن"));
                }
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  // الـ AppBar بنفس تصميم الصورة
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        color: Color(0xFFEFEBE9),
        icon: Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: ChatColors.primaryBrown,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(backgroundColor: ChatColors.primaryBrown, radius: 20),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.otherUserName,
                style: TextStyle(
                  color: Color(0xFF3E2723),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Online",
                style: TextStyle(color: ChatColors.textGray, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // تصميم فقاعة الدردشة
  Widget _buildChatBubble(String text, String time, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Color(0xFF6D4C41) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
          ),
        ),
        constraints: BoxConstraints(maxWidth: 250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Color(0xFF3E2723),
                fontSize: 15,
              ),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isMe ? Colors.white70 : Color(0xFF8D6E63),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // حقل إدخال الرسالة السفلي
  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xFFFAF8F5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ChatColors.backgroundBeige,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Color(0xFFEFEBE9)),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(color: Color(0xFF8D6E63)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (_messageController.text.isNotEmpty) {
                // 🔹 الآن سيعمل الـ context بدون أي أخطاء أحمر
                context.read<MessagesCubit>().sendUserMessage(
                  widget.otherUserId,
                  _messageController.text,
                );
                _messageController.clear();
              }
            },
            child: CircleAvatar(
              backgroundColor: ChatColors.primaryBrown,
              child: Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
