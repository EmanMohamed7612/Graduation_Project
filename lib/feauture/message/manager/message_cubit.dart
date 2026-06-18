// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation2/feauture/message/data/message_model.dart';
// import 'package:graduation2/feauture/message/manager/message_repo.dart';
// import 'package:graduation2/feauture/message/manager/message_singlerR.dart';
// import 'package:graduation2/feauture/message/manager/message_state.dart';

// class MessagesCubit extends Cubit<MessagesState> {
//   final MessagesRepo repo;
//   final SignalRService signalRService;
//   List<MessageModel> messages = [];

//   MessagesCubit(this.repo, this.signalRService) : super(MessagesInitial()) {
//     // تهيئة SignalR مرة واحدة عند إنشاء الـ Cubit
//     signalRService.initSignalR((newMessageJson) {
//       final newMessage = MessageModel.fromJson(newMessageJson);
//       messages.insert(0, newMessage);
//       emit(MessagesSuccess(List.from(messages)));
//     });
//   }

//   Future<void> loadMessages(String otherUserId) async {
//     emit(MessagesLoading()); // فقط عند الفتح الأول
//     try {
//       messages = await repo.getConversation(otherUserId);
//       emit(MessagesSuccess(List.from(messages)));
//     } catch (e) {
//       emit(MessagesFailure(e.toString()));
//     }
//   }
// Future<void> sendUserMessage(String receiverId, String text) async {
//   try {
//     // 1. إرسال الرسالة وجلب الكائن الراجع من السيرفر
//     final newMessage = await repo.sendMessage(receiverId, text);

//     if (newMessage != null) {
//       // 2. إدخال الرسالة في بداية القائمة محلياً فوراً
//       messages.insert(0, newMessage);

//       // 3. تحديث الحالة لتظهر الرسالة فوراً دون عمل loadMessages ودون Loading
//       emit(MessagesSuccess(List.from(messages)));
//     }
//   } catch (e) {
//     emit(MessagesFailure("Failed to send message: ${e.toString()}"));
//   }
// }

//   @override
//   Future<void> close() {
//     signalRService.stopConnection();
//     return super.close();
//   }
// }
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/message/data/message_model.dart';
import 'package:graduation2/feauture/message/manager/message_repo.dart';
import 'package:graduation2/feauture/message/manager/message_singlerR.dart';
import 'package:graduation2/feauture/message/manager/message_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessagesRepo repo;
  final SignalRService signalRService;
  List<MessageModel> messages = [];
  String? currentChattingWithId;
  String? currentUserId;
  MessagesCubit(this.repo, this.signalRService) : super(MessagesInitial()) {
    _initUserId();
    // تهيئة واستقبال أحداث الـ Realtime
    signalRService.initSignalR((newMessageJson) {
      try {
        final Map<String, dynamic> messageMap = Map<String, dynamic>.from(
          newMessageJson as Map,
        );
        messageMap['isOwnMessage'] = messageMap['senderId'] == currentUserId;
        final newMessage = MessageModel.fromJson(messageMap);

        // ✅ الفلتر الجديد: لو الشات مفتوح مع نفس الشخص
        final bool isRelevantToCurrentChat =
            currentChattingWithId != null &&
            (newMessage.senderId == currentChattingWithId ||
                newMessage.receiverId == currentChattingWithId);

        if (isRelevantToCurrentChat) {
          final isExist = messages.any((msg) => msg.id == newMessage.id);
          if (!isExist) {
            messages.insert(0, newMessage);
            emit(MessagesSuccess(List.from(messages)));
            print("⚡ Realtime Message Injected!");
          }
        } else {
          // 🔹 الشات مش مفتوح - ممكن تعملي notification هنا لو عايزة
          print(
            "ℹ️ Message received but chat not open. senderId: ${newMessage.senderId}, currentChat: $currentChattingWithId",
          );
        }
      } catch (e) {
        print("❌ Error: $e");
      }
    });
    //   try {
    //     print("📥 SignalR Raw Payload received in Cubit: $newMessageJson");

    //     // تحويل البيانات بشكل صريح إلى Map لضمان عدم حدوث Type Cast Error
    //     final Map<String, dynamic> messageMap = Map<String, dynamic>.from(
    //       newMessageJson as Map,
    //     );
    //     messageMap['isOwnMessage'] = messageMap['senderId'] == currentUserId;

    //     final newMessage = MessageModel.fromJson(messageMap);

    //     print(
    //       "🔍 Checking filter: Message Sender: ${newMessage.senderId}, Current Chat with: $currentChattingWithId",
    //     );

    //     // التحقق من أن الرسالة تخص المحادثة المفتوحة حالياً
    //     if (newMessage.senderId == currentChattingWithId ||
    //         newMessage.receiverId == currentChattingWithId) {
    //       // منع التكرار
    //       final isExist = messages.any((msg) => msg.id == newMessage.id);
    //       if (!isExist) {
    //         // نستخدم insert(0) لأن القائمة معروضة بشكل reverse: true في الـ UI
    //         messages.insert(0, newMessage);
    //         emit(MessagesSuccess(List.from(messages)));
    //         print("⚡ Realtime Message Injected successfully into UI!");
    //       }
    //     }
    //   } catch (e) {
    //     print("❌ Error processing SignalR message in Cubit: $e");
    //   }
    // });
  }

  Future<void> loadMessages(String otherUserId) async {
    currentUserId ??= await PrefHelpers.getUserId();
    //currentUserId = await PrefHelpers.getUserId();
    currentChattingWithId = otherUserId;
    print(
      "🔍 loadMessages called - currentUserId: $currentUserId, chattingWith: $currentChattingWithId",
    );
    currentChattingWithId =
        otherUserId; // حفظ المعرف فوراً عند الفتح لفلترة الرسائل القادمة
    emit(MessagesLoading());
    try {
      await _initUserId();
      messages = await repo.getConversation(otherUserId);
      emit(MessagesSuccess(List.from(messages)));
    } catch (e) {
      emit(MessagesFailure(e.toString()));
    }
  }

  Future<void> sendUserMessage(String receiverId, String text) async {
    try {
      final newMessage = await repo.sendMessage(receiverId, text);

      if (newMessage != null) {
        // إضافة رسالتك محلياً فوراً لتظهر في شاشتك دون انتظار السيرفر
        messages.insert(0, newMessage);
        emit(MessagesSuccess(List.from(messages)));
      }
    } catch (e) {
      emit(MessagesFailure("Failed to send message: ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    currentChattingWithId = null;
    signalRService.stopConnection();
    return super.close();
  }

  Future<void> _initUserId() async {
    // currentUserId = await PrefHelpers.getUserId();
    // print("✅ currentUserId initialized: $currentUserId");
    // currentUserId = await PrefHelpers.getUserId();

    // // لو null، استخرجيه من الـ JWT Token
    // if (currentUserId == null) {
    //   final token = await PrefHelpers.getToken();
    //   if (token != null) {
    //     currentUserId = PrefHelpers.extractUserIdFromToken(token);
    //     // احفظيه عشان المرة الجاية
    //     if (currentUserId != null) {
    //       await PrefHelpers.saveUserId(currentUserId!);
    //     }
    //   }
    // }

    // print("✅ currentUserId initialized: $currentUserId");
    final token = await PrefHelpers.getToken();
    if (token != null) {
      currentUserId = PrefHelpers.extractUserIdFromToken(token);
      if (currentUserId != null) {
        await PrefHelpers.saveUserId(
          currentUserId!,
        ); // تحديث الكاش بالـ ID الصح
      }
    }
    print("✅ currentUserId initialized from Token: $currentUserId");
  }
}
