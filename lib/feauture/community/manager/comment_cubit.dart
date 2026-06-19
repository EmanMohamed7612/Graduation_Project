import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/comment_model.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/comment_state.dart';

// class CommentsCubit extends Cubit<CommentsState> {
//   final PostsRepo postsRepo;
//   CommentsCubit(this.postsRepo) : super(CommentsInitial());

//   Future<void> sendComment(int postId, String text) async {
//     if (text.trim().isEmpty) return;
    
//     emit(CommentsLoading()); // حالة التحميل أثناء الإرسال
//     try {
//       final newComment = await postsRepo.addComment(postId, text);
//       emit(CommentsAddSuccess(newComment));
//     } catch (e) {
//       emit(CommentsError(e.toString()));
//     }
//   }

//   // داخل كلاس CommentsCubit
// Future<void> fetchComments(int postId) async {
//   emit(CommentsLoading()); // نستخدم حالة Loading العامة للتحميل الأول
//   try {
//     final comments = await postsRepo.getComments(postId);
//     emit(CommentsFetchSuccess(comments));
//   } catch (e) {
//     emit(CommentsError(e.toString()));
//   }
// }

// }


class CommentsCubit extends Cubit<CommentsState> {
  final PostsRepo postsRepo;
  
  // 1. متغير لتخزين القائمة الحالية
  List<CommentModel> allComments = [];

  CommentsCubit(this.postsRepo) : super(CommentsInitial());

  Future<void> fetchComments(int postId) async {
    emit(CommentsLoading());
    try {
      // تخزين التعليقات القادمة من السيرفر
      allComments = await postsRepo.getComments(postId);
      emit(CommentsFetchSuccess(allComments));
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }

  Future<void> sendComment(int postId, String text) async {
    if (text.trim().isEmpty) return;
    emit(CommentSendLoading());
    // مش هنبعت Loading عشان ميمسحش القائمة القديمة من الشاشة
    // ممكن تعملي حالة خاصة زي CommentsAddLoading لو عايزة تبيني Progress صغير
    try {
      final newComment = await postsRepo.addComment(postId, text);
      
      // 2. إضافة التعليق الجديد في أول القائمة
      allComments.insert(0, newComment);
      
      // 3. تحديث الـ UI بالقائمة كاملة بعد الإضافة
      emit(CommentsFetchSuccess(allComments)); 
      emit(CommentsAddSuccess(newComment)); // لإشعار الـ listener بمسح التكست فيلد
    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }
}