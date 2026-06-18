

import '../data/message_model.dart';

abstract class MessagesState {}

// الحالة الابتدائية
class MessagesInitial extends MessagesState {}

// حالة التحميل (لما تفتحي الشات وتستني الرسايل القديمة تيجي)
class MessagesLoading extends MessagesState {}

// حالة النجاح (لما الرسايل تيجي أو لما رسالة جديدة تضاف في الوقت الحقيقي)
class MessagesSuccess extends MessagesState {
  final List<MessageModel> messages;
  MessagesSuccess(this.messages);
}

// حالة الخطأ (لو السيرفر وقع أو مفيش نت)
class MessagesFailure extends MessagesState {
  final String errorMessage;
  MessagesFailure(this.errorMessage);
}