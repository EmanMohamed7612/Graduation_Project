import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/post_model.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final PostsRepo postsRepo;
  CommunityCubit(this.postsRepo) : super(CommunityInitial());

  Future<void> fetchPosts() async {
    emit(CommunityLoading());
    try {
      final posts = await postsRepo.getAllPosts();
      emit(CommunitySuccess(posts));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  // داخل كلاس CommunityCubit
Future<void> toggleLike(int postId) async {
  // بنحتفظ بالحالة الحالية عشان لو حصل خطأ نرجع ليها
  if (state is CommunitySuccess) {
    final oldPosts = (state as CommunitySuccess).posts;
    
    try {
      final isLiked = await postsRepo.toggleLike(postId);
      
      // تحديث القائمة في الذاكرة (Local UI Update)
      final updatedPosts = oldPosts.map((post) {
        if (post.id == postId) {
          return PostModel(
            id: post.id,
            content: post.content,
            imageUrl: post.imageUrl,
            createdAt: post.createdAt,
            userName: post.userName,
            commentsCount: post.commentsCount,
            // تحديث القيم الجديدة
            isLikedByMe: isLiked,
            likesCount: isLiked ? post.likesCount + 1 : post.likesCount - 1,
          );
        }
        return post;
      }).toList();

      emit(CommunitySuccess(updatedPosts));
    } catch (e) {
      // اختياري: ممكن تطلعي SnackBar بالخطأ
      print("Like Error: $e");
    }
  }
}
void updateCommentCount(int postId) {
  if (state is CommunitySuccess) {
    final currentState = state as CommunitySuccess;
    
    // الحل هنا: ننشئ قائمة جديدة تماماً وننشئ كائن بوست جديد تماماً للبوست المطلوب
    final List<PostModel> updatedPosts = currentState.posts.map((post) {
      if (post.id == postId) {
        // نرجع نسخة جديدة مع زيادة العداد
        return post.copyWith(
          commentsCount: post.commentsCount + 1,
        );
      }
      return post; // باقي البوستات تنزل كما هي
    }).toList();

    emit(CommunitySuccess(updatedPosts));
  }
}
}