import 'package:graduation2/feauture/community/data/comment_model.dart';

abstract class CommentsState {}
class CommentsInitial extends CommentsState {}
class CommentsLoading extends CommentsState {}
class CommentSendLoading extends CommentsState {}
class CommentsAddSuccess extends CommentsState {
  final CommentModel comment;
  CommentsAddSuccess(this.comment);
}
class CommentsError extends CommentsState {
  final String message;
  CommentsError(this.message);
}
class CommentsFetchSuccess extends CommentsState {
  final List<CommentModel> comments;
  CommentsFetchSuccess(this.comments);
}