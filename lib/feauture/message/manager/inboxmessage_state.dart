

import '../data/inboxmessage_model.dart';

abstract class InboxState {}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {} // تظهر وقت التحميل

class InboxSuccess extends InboxState {
  final List<InboxItemModel> chats; // لستة المحادثات اللي هترسم الـ UI
  InboxSuccess(this.chats);
}

class InboxFailure extends InboxState {
  final String errorMessage;
  InboxFailure(this.errorMessage);
}