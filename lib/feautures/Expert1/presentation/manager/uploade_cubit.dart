import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';


import '../../../auth/presentation/manager/cubit/auth_cubit.dart';
import '../../data/model/uploade_model.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInitial());

  File? profileImage;
  File? portfolioFile;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://craftoria.runasp.net/api/Authentication",
    ),
  );

  void setProfileImage(File file) {
    profileImage = file;
  }

  void setPortfolioFile(File file) {
    portfolioFile = file;
  }

  Future<void> uploadFiles({required String token}) async {
    if (profileImage == null || portfolioFile == null) {
      emit(UploadFailure("Please upload both files"));
      return;
    }

    emit(UploadLoading());

    try {
      final model = UploadFileModel(
        profileImage: profileImage!,
        portfolioFile: portfolioFile!,
      );

      FormData formData = FormData.fromMap({
        "ProfileImage": await MultipartFile.fromFile(
          model.profileImage.path,
          filename: model.profileImage.path.split('/').last,
        ),
        "Portfolio": await MultipartFile.fromFile(
          model.portfolioFile.path,
          filename: model.portfolioFile.path.split('/').last,
        ),
      });

      await dio.post(
        "Authentication/Register",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      emit(UploadSuccess());
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }
}
