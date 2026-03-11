import 'package:dartz/dartz.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/material_screen/data/model/addmaterialmodel.dart';

import '../data/model/update_material.dart';



abstract class Repomaterial {
  Future<Either<ApiError, CreatematerialResponseModel>> creatematerial(
      CreatematerialRequestModel requestModel,
      );

  Future<Either<ApiError, CreatematerialResponseModel>> updatematerial(
      UpdatematerialRequestModel requestModel,
      );

  Future<Either<ApiError, void>> deletematerial(int id);
}
