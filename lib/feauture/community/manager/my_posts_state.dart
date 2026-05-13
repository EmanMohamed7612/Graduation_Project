import 'package:graduation2/feauture/community/data/post_model.dart';

abstract class MyPostsState {}
class MyPostsInitial extends MyPostsState {}
class MyPostsLoading extends MyPostsState {}
class MyPostsSuccess extends MyPostsState {
  final List<PostModel> posts;
  MyPostsSuccess(this.posts);
}
class MyPostsError extends MyPostsState {
  final String message;
  MyPostsError(this.message);
}