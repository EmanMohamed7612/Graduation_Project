import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/message_model.dart';
import 'message_repo.dart';
import 'message_singlerR.dart';
import 'message_state.dart';


class MessagesCubit extends Cubit<MessagesState> {
  final MessagesRepo repo;
  final SignalRService signalRService;

  List<MessageModel> messages = [];

  MessagesCubit(this.repo, this.signalRService) : super(MessagesInitial());

  Future<void> loadMessages(String otherUserId) async {
    emit(MessagesLoading());
    try {
      messages = await repo.getConversation(otherUserId);

      // نبدأ نسمع للـ SignalR أول ما نفتح الشات
      await signalRService.initSignalR((newMessageJson) {
        final newMessage = MessageModel.fromJson(newMessageJson);
        messages.insert(0, newMessage); // نضيف الرسالة الجديدة في أول القائمة
        emit(MessagesSuccess(List.from(messages)));
      });

      emit(MessagesSuccess(List.from(messages)));
    } catch (e) {
      emit(MessagesFailure(e.toString()));
    }
  }

  Future<void> sendUserMessage(String receiverId, String text) async {
    try {
      await repo.sendMessage(receiverId, text);
      // ملاحظة: الباك إيند هيبعتلك الرسالة اللي إنت بعتها عبر SignalR برضه
      // فمش لازم تضيفيها يدوي هنا، هي هتتضاف لوحدها من الـ listener
    } catch (e) {
      emit(MessagesFailure("Failed to send message"));
    }
  }
}