import 'package:graduation2/feauture/chat_bot/views/widgets/chat_bubble.dart';

abstract class ChatBotState {}

class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {}

class ChatBotSuccess extends ChatBotState {
  final List<ChatMessage> messages;
  ChatBotSuccess(this.messages);
}

class ChatBotFailure extends ChatBotState {
  final String errMessage;
  ChatBotFailure(this.errMessage);
}
class ChatBotTyping extends ChatBotState {
  final List<ChatMessage> messages;
  ChatBotTyping(this.messages);
}