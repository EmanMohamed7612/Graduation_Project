import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/chat_bot/data/chat_bot_repo.dart';
import 'package:graduation2/feauture/chat_bot/views/widgets/chat_bubble.dart';
import 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotRepo chatBotRepo;
  ChatBotCubit(this.chatBotRepo) : super(ChatBotInitial());

  List<ChatMessage> messages = [];

  // ... getWelcomeMessage ...

  // Future<void> sendMessage(String text, String time) async {
  //   // 1. إضافة رسالة المستخدم
  //   messages.add(ChatMessage(text: text, time: time, isAi: false));
  //   emit(ChatBotSuccess(List.from(messages)));

  //   // 2. إضافة رسالة AI فارغة (ستمتلئ تدريجياً)
  //   ChatMessage aiResponse = ChatMessage(text: "", time: time, isAi: true);
  //   messages.add(aiResponse);
  //   int aiMsgIndex = messages.length - 1;

  //   try {
  //     // 3. استهلاك الـ Stream
  //     await for (String chunk in chatBotRepo.askAIStream(text)) {
  //       // تحديث النص في الرسالة الأخيرة
  //       String currentText = messages[aiMsgIndex].text;
  //       messages[aiMsgIndex] = ChatMessage(
  //         text: currentText + (currentText.isEmpty ? "" : " ") + chunk,
  //         time: aiResponse.time,
  //         isAi: true,
  //       );

  //       // إرسال الحالة لتحديث الـ UI في كل كلمة
  //       emit(ChatBotSuccess(List.from(messages)));
  //     }
  //   } catch (e) {
  //     messages[aiMsgIndex] = ChatMessage(
  //       text: "Sorry, I'm having trouble connecting.",
  //       time: aiResponse.time,
  //       isAi: true,
  //     );
  //     emit(ChatBotSuccess(List.from(messages)));
  //   }
  // }

  Future<void> sendMessage(String text, String time) async {
    messages.add(ChatMessage(text: text, time: time, isAi: false));
    emit(ChatBotSuccess(List.from(messages)));

    // إضافة رسالة AI فارغة
    ChatMessage aiResponse = ChatMessage(text: "", time: time, isAi: true);
    messages.add(aiResponse);
    int aiMsgIndex = messages.length - 1;

    try {
      // نبعت حالة التحميل فوراً
      emit(ChatBotTyping(List.from(messages)));

      await for (String chunk in chatBotRepo.askAIStream(text)) {
        String currentText = messages[aiMsgIndex].text;
        messages[aiMsgIndex] = ChatMessage(
          text:
              currentText +
              chunk, // شيلي المسافة الإضافية لو الـ backend بيبعتها
          time: aiResponse.time,
          isAi: true,
        );

        // نفضل في حالة الـ Typing عشان النجمة تفضل موجودة
        emit(ChatBotTyping(List.from(messages)));

        
      }

      // لما يخلص خالص نرجع لحالة النجاح الطبيعية
      emit(ChatBotSuccess(List.from(messages)));
    } catch (e) {
      messages[aiMsgIndex] = ChatMessage(
        text: "Sorry, I'm having trouble connecting.",
        time: aiResponse.time,
        isAi: true,
      );
      emit(ChatBotSuccess(List.from(messages)));
    }
  }

  Future<void> getWelcomeMessage() async {
    emit(ChatBotLoading());
    try {
      final response = await chatBotRepo.getWelcomeMessage();
      if (response != null) {
        // تجنب تكرار الرسالة إذا كانت موجودة بالفعل
        if (messages.isEmpty) {
          messages.add(response);
        }
      }
      emit(ChatBotSuccess(List.from(messages)));
    } catch (e) {
      emit(ChatBotFailure("حدث خطأ أثناء تحميل رسالة الترحيب"));
    }
  }

  // void sendMessage(String text, String time) {
  //   // إضافة رسالة المستخدم محلياً فوراً
  //   messages.add(ChatMessage(text: text, time: time, isAi: false));
  //   emit(ChatBotSuccess(List.from(messages)));

  //   // هنا مستقبلاً ستضيفين طلب الـ API لإرسال الرسالة والحصول على رد الـ AI
  // }

  // داخل ملف ChatBotCubit
  Future<void> loadChatConfiguration() async {
    emit(ChatBotLoading());
    try {
      // 1. جلب تاريخ المحادثة
      final history = await chatBotRepo.getChatHistory();
      messages = history;

      // 2. إذا لم يكن هناك تاريخ قديم، احضر رسالة الترحيب
      if (messages.isEmpty) {
        final welcome = await chatBotRepo.getWelcomeMessage();
        if (welcome != null) {
          messages.add(welcome);
        }
      }

      emit(ChatBotSuccess(List.from(messages)));
    } catch (e) {
      emit(ChatBotFailure("Failed to load chat history"));
    }
  }
}
