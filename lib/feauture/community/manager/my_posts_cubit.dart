import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  final PostsRepo postsRepo;
  MyPostsCubit(this.postsRepo) : super(MyPostsInitial());

  // تغيير النوع إلى String
  Future<void> fetchUserPosts(String userId) async {
    emit(MyPostsLoading());
    try {
      final posts = await postsRepo.getUserPosts(userId);
      emit(MyPostsSuccess(posts));
    } catch (e) {
      emit(MyPostsError(e.toString()));
    }
  }
}