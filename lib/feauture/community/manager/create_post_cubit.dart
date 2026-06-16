import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostsRepo postsRepo;
  CreatePostCubit(this.postsRepo) : super(CreatePostInitial());

  File? selectedImage;
  
  // وظيفة لاختيار الصورة
  // void setImage(File image) {
  //   selectedImage = image;
  //   emit(ImageSelectedState(image));
  // }
  void setImage(File image) {
  selectedImage = image;
  // بدل ما تعملي emit لحالة جديدة ممكن تسببلنا مشاكل في الـ UI Builder
  // اعملي emit لحالة الـ Initial تاني عشان الـ Builder يرسم الصورة الجديدة
  emit(CreatePostInitial()); 
}

  Future<void> submitPost(String content) async {
    if (content.isEmpty) {
      emit(CreatePostFailure("Content cannot be empty"));
      return;
    }

    emit(CreatePostLoading());
    try {
      await postsRepo.createPost(content: content, imageFile: selectedImage);
      emit(CreatePostSuccess("Post Created Successfully!"));
    } catch (e) {
      emit(CreatePostFailure(e.toString()));
    }
  }
}