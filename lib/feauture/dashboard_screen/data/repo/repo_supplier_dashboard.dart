import 'package:dartz/dartz.dart';

import '../../../../core/services/api_error.dart';
import '../model/materialsupplierdashboard.dart';
import '../model/productsellerdashboardmodel.dart';

abstract class RepoSupplierDashboard {
  Future<Either<ApiError, List<materialsupplierdashboardModel>>>
  getspacificsupplierProducts();
}
