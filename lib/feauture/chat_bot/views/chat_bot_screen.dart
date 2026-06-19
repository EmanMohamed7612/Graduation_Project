import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/chat_bot/data/chat_bot_repo.dart';
import 'package:graduation2/feauture/chat_bot/manager/chat_bot_cubit.dart';
import 'package:graduation2/feauture/chat_bot/manager/chat_bot_state.dart';
import 'package:graduation2/feauture/chat_bot/views/widgets/chat_bubble.dart';
import 'package:graduation2/feauture/chat_bot/views/widgets/chat_input_section.dart';
import 'package:graduation2/feauture/chat_bot/views/widgets/typing_indicator.dart';

// --- Model Layer ---

// --- Presentation Layer ---
class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key, this.onGoHome});
  final VoidCallback? onGoHome;

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // قائمة تجريبية لمحاكاة البيانات القادمة من الـ API لاحقاً
  // List<ChatMessage> messages = [
  //   ChatMessage(
  //     text: "Hello! I'm your Craftoria AI assistant. How can I help you today?",
  //     time: "10:30 AM",
  //     isAi: true,
  //   ),
  //   ChatMessage(
  //     text: "I'm looking for a unique gift",
  //     time: "10:32 AM",
  //     isAi: false,
  //   ),
  //   ChatMessage(
  //     text: "I'd love to help! What are their interests?",
  //     time: "10:33 AM",
  //     isAi: true,
  //   ),
  //   ChatMessage(text: "She loves pottery", time: "10:35 AM", isAi: false),
  // ];
  // إنشاء نسخة من الريبو
  final ChatBotRepo _chatRepo = ChatBotRepo(); // إنشاء نسخة من الريبو
  // قائمة الرسائل تبدأ فارغة
  List<ChatMessage> messages = [];
  bool isLoading = false; // قائمة الرسائل تبدأ فارغة
  @override
  void initState() {
    super.initState();
    context.read<ChatBotCubit>().getWelcomeMessage();
    // استدعاء الرسالة بمجرد فتح الشاشة
    context.read<ChatBotCubit>().loadChatConfiguration();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // الألوان المستخرجة من التصمي

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF5F0E8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF6D4C41), size: 18),
          onPressed: () {
            if (widget.onGoHome != null) {
              widget.onGoHome!();
            } else {
              // لو مش موجودة (زي لو فاتحين البروفايل من صفحة تانية بـ push)
              Navigator.maybePop(context);
            }
          },
        ),
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment(0.50, 0.00),
                  end: Alignment(0.50, 1.00),
                  colors: [Color(0xFFC9A875), Color(0xFFD4AF77)],
                ),
              ),
              child: Icon(
                Icons.auto_awesome_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Assistant",
                  style: TextStyle(
                    color: const Color(0xFF3E2723),
                    fontSize: 15.75,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
                Text(
                  'Always here to help',
                  style: TextStyle(
                    color: const Color(0xFF8D6E63),
                    fontSize: 14,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // منطقة الرسائل
          Expanded(
            child: BlocListener<ChatBotCubit, ChatBotState>(
              listener: (context, state) {
                // لو إحنا في حالة نجاح أو حالة كتابة (Stream)
                if (state is ChatBotSuccess || state is ChatBotTyping) {
                  _scrollToBottom();
                }
              },
              child: BlocBuilder<ChatBotCubit, ChatBotState>(
                builder: (context, state) {
                  if (state is ChatBotLoading &&
                      context.read<ChatBotCubit>().messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatBotFailure) {
                    return Center(child: Text(state.errMessage));
                  }
                  // final allMessages = context.read<ChatBotCubit>().messages;
                  // bool isTyping = state is ChatBotTyping;
                  final allMessages = context.read<ChatBotCubit>().messages;
                  if (state is ChatBotSuccess) {
                    _scrollToBottom();
                  }

                  // في حالة النجاح أو وجود رسائل قديمة
                  // var messages = context.read<ChatBotCubit>().messages;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFAF8F5),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: allMessages.length,
                      reverse: false,
                      itemBuilder: (context, index) {
                        // return ChatBubble(msg: allMessages[index]);
                        final message = allMessages[index];

                        // لو الرسالة دي من الـ AI ونصه لسه فاضي والحالة هي Typing
                        // اظهر الـ Indicator مكان الفقاعة
                        if (state is ChatBotTyping &&
                            message.isAi &&
                            message.text.isEmpty &&
                            index == allMessages.length - 1) {
                          // <--- التأكد إنه آخر عنصر فقط
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: const TypingIndicator(),
                            ),
                          );
                        }

                        // عرض الرسائل القديمة أو الرسائل اللي بدأ يظهر فيها نص
                        return ChatBubble(msg: message);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          //
          //
          ChatInputSection(
            controller: _controller,
            onSend: () {
              if (_controller.text.isNotEmpty) {
                context.read<ChatBotCubit>().sendMessage(
                  _controller.text,
                  TimeOfDay.now().format(context),
                );
                _controller.clear();
              }
            },
          ),
          // ChatInputSection(
          //   controller: _controller,
          //   onSend: () {
          //     // الأكشن الخاص بالإرسال
          //     print("Sending: ${_controller.text}");
          //   },
          // ),
        ],
      ),
    );
  }

  // Widget _buildChatBubble(ChatMessage msg, Color aiColor, Color userColor) {
  //   bool isAi = msg.isAi;
  //   return Align(
  //     alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 8),
  //       padding: EdgeInsets.all(16),
  //       constraints: BoxConstraints(
  //         maxWidth: MediaQuery.of(context).size.width * 0.75,
  //       ),
  //       decoration: BoxDecoration(
  //         color: isAi ? Color(0xFFEFEBE9) : Color(0xFF6D4C41),
  //         borderRadius: BorderRadius.circular(15),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Color(0xFFE0D5C7),
  //             // blurRadius: 4,
  //             //offset: Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           if (isAi)
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.auto_awesome_outlined,
  //                   color: Color(0xFFC9A875),
  //                   size: 12,
  //                 ),
  //                 Text(
  //                   '  AI',
  //                   style: TextStyle(
  //                     color: const Color(0xFFC9A875),
  //                     fontSize: 14,
  //                     fontFamily: 'Arimo',
  //                     fontWeight: FontWeight.w400,
  //                     height: 1.50,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           SizedBox(height: 4),
  //           Text(
  //             msg.text,
  //             style: isAi
  //                 ? TextStyle(
  //                     color: const Color(0xFF3E2723),
  //                     fontSize: 14,
  //                     fontFamily: 'Arimo',
  //                     fontWeight: FontWeight.w400,
  //                     height: 1.50,
  //                   )
  //                 : TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 14,
  //                     fontFamily: 'Arimo',
  //                     fontWeight: FontWeight.w400,
  //                     height: 1.50,
  //                   ),
  //           ),
  //           SizedBox(height: 5),
  //           Align(
  //             alignment: Alignment.bottomRight,
  //             child: Text(
  //               msg.time,
  //               style: TextStyle(
  //                 color: isAi ? Color(0xFF8D6E63) : Colors.white70,
  //                 fontSize: 14,
  //                 fontFamily: 'Arimo',
  //                 fontWeight: FontWeight.w400,
  //                 height: 1.50,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildInputSection(Color primaryBrown) {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Color(0xfFAF8F5),
  //               borderRadius: BorderRadius.circular(30),
  //               border: Border.all(color: Color(0xFFE0D5C7)),
  //             ),
  //             child: TextField(
  //               controller: _controller,
  //               decoration: InputDecoration(
  //                 hintText: "Ask me anything...",
  //                 hintStyle: TextStyle(
  //                   color: const Color(0xFF8D6E63),
  //                   fontSize: 14,
  //                   fontFamily: 'Arimo',
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
  //                 border: InputBorder.none,
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 10),
  //         CircleAvatar(
  //           backgroundColor: Color(0xFFD4AF77),
  //           child: IconButton(
  //             icon: Icon(Icons.send, color: Colors.white, size: 20),
  //             onPressed: () {
  //               // هنا يتم استدعاء الـ API لاحقاً
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
