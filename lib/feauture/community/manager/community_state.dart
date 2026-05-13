
import 'package:graduation2/feauture/community/data/post_model.dart';
// import الـ Repo والـ Model بتاعك هنا

abstract class CommunityState {}
class CommunityInitial extends CommunityState {}
class CommunityLoading extends CommunityState {}
class CommunitySuccess extends CommunityState {
  final List<PostModel> posts;
  CommunitySuccess(this.posts);
}
class CommunityError extends CommunityState {
  final String message;
  CommunityError(this.message);
}