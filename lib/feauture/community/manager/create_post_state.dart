import 'dart:io';

abstract class CreatePostState {}
class CreatePostInitial extends CreatePostState {}
class CreatePostLoading extends CreatePostState {}
class CreatePostSuccess extends CreatePostState {
  final String message;
  CreatePostSuccess(this.message);
}
class CreatePostFailure extends CreatePostState {
  final String errMessage;
  CreatePostFailure(this.errMessage);
}
// حالة خاصة لاختيار الصورة في الـ UI
class ImageSelectedState extends CreatePostState {
  final File image;
  ImageSelectedState(this.image);
}