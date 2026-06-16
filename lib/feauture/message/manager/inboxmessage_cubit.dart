import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/inboxmessage_model.dart';
import 'inboxmessage_repo.dart';
import 'inboxmessage_state.dart';


class InboxCubit extends Cubit<InboxState> {
  final InboxRepo inboxRepo;
  List<InboxItemModel> _allChats = []; // مخزن للقائمة كاملة للبحث

  InboxCubit(this.inboxRepo) : super(InboxInitial());

  Future<void> fetchInbox() async {
    emit(InboxLoading());
    try {
      _allChats = await inboxRepo.getInbox();
      emit(InboxSuccess(_allChats));
    } catch (e) {
      emit(InboxFailure("فشل تحميل الرسائل: ${e.toString()}"));
    }
  }

  void filterChats(String query) {
    if (query.isEmpty) {
      emit(InboxSuccess(_allChats));
    } else {
      final filtered = _allChats
          .where((chat) =>
          chat.otherUserName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(InboxSuccess(filtered));
    }
  }
}