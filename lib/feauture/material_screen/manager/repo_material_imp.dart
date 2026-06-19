import 'package:dartz/dartz.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/material_screen/manager/repo_material.dart';
import 'package:graduation2/feauture/product_screens/data/model/create_product_model.dart';
import 'package:graduation2/feauture/product_screens/data/repo/repo_product.dart';

import '../data/model/addmaterialmodel.dart';
import '../data/model/update_material.dart';
import 'material_api_services.dart';


class RepomaterialImple implements Repomaterial {
  final MaterialApiService materialApiService;

  RepomaterialImple({required this.materialApiService});

  @override
  Future<Either<ApiError, CreatematerialResponseModel>> creatematerial(
      CreatematerialRequestModel requestModel,
      ) async {
    try {
      final response = await materialApiService.creatematerial(requestModel);
      return Right(response);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, CreatematerialResponseModel>> updatematerial(
      UpdatematerialRequestModel requestModel,
      ) async {
    try {
      final response = await materialApiService.updatematerial(requestModel);
      return Right(response);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, void>> deletematerial(int id) async {
    try {
      await materialApiService.deletematerial(id);
      return const Right(null);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
