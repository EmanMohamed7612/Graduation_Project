// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../data/inboxmessage_model.dart';
// import 'inboxmessage_repo.dart';
// import 'inboxmessage_state.dart';

// class InboxCubit extends Cubit<InboxState> {
//   final InboxRepo inboxRepo;
//   List<InboxItemModel> _allChats = []; // مخزن للقائمة كاملة للبحث

//   InboxCubit(this.inboxRepo) : super(InboxInitial());

//   Future<void> fetchInbox() async {
//     emit(InboxLoading());
//     try {
//       _allChats = await inboxRepo.getInbox();
//       emit(InboxSuccess(_allChats));
//     } catch (e) {
//       emit(InboxFailure("فشل تحميل الرسائل: ${e.toString()}"));
//     }
//   }

//   void filterChats(String query) {
//     if (query.isEmpty) {
//       emit(InboxSuccess(_allChats));
//     } else {
//       final filtered = _allChats
//           .where((chat) =>
//           chat.otherUserName.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//       emit(InboxSuccess(filtered));
//     }
//   }
// }
import 'dart:async'; // مهم جداً عشان التايمر
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/inboxmessage_model.dart';
import 'inboxmessage_repo.dart';
import 'inboxmessage_state.dart';

class InboxCubit extends Cubit<InboxState> {
  final InboxRepo inboxRepo;
  List<InboxItemModel> _allChats = []; 
  Timer? _pollingTimer; // التايمر المسؤول عن التحديث الدوري

  InboxCubit(this.inboxRepo) : super(InboxInitial());

  /// 1. الميثود الأساسية اللي هتتندى أول ما الشاشة تفتح
  void startInboxUpdates() {
    // إظهار علامة التحميل في أول مرة فقط
    emit(InboxLoading());
    
    // جلب البيانات للمرة الأولى فوراً
    _fetchDataSilent();

    // إلغاء أي تايمر قديم احتياطاً لمنع التكرار
    _pollingTimer?.cancel();

    // تشغيل التايمر ليكرر الطلب كل 5 ثواني في الخلفية
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _fetchDataSilent();
    });
  }

  /// 2. ميثود داخلية تجلب البيانات في الخلفية بدون إظهار الـ Loading للمستخدم
  Future<void> _fetchDataSilent() async {
    try {
      _allChats = await inboxRepo.getInbox();
      
      // استخدام List.from لضمان أن الـ Bloc يرى أنها قائمة جديدة ويعيد رسم الـ UI
      emit(InboxSuccess(List.from(_allChats)));
    } catch (e) {
      // لو لسه مفيش داتا خالص (أول مرة) وفشل، نرفع حالة الفشل
      if (state is! InboxSuccess) {
        emit(InboxFailure("فشل تحميل الرسائل: ${e.toString()}"));
      }
    }
  }

  /// 3. إيقاف التايمر فوراً عند الخروج من الشاشة (مهم جداً للـ Memory والبطارية)
  void stopInboxUpdates() {
    _pollingTimer?.cancel();
  }

  @override
  Future<void> close() {
    stopInboxUpdates(); // تأكيد غلق التايمر عند تدمير الـ Cubit
    return super.close();
  }

  // ميثود الفلترة الجميلة بتاعتك زي ما هي بدون تغيير
  void filterChats(String query) {
    if (query.isEmpty) {
      emit(InboxSuccess(List.from(_allChats)));
    } else {
      final filtered = _allChats
          .where((chat) =>
              chat.otherUserName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(InboxSuccess(filtered));
    }
  }
}
