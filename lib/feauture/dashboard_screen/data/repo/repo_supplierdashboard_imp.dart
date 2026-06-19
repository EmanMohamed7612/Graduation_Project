
import 'package:dartz/dartz.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/dashboard_screen/data/model/productsellerdashboardmodel.dart';
import 'package:graduation2/feauture/dashboard_screen/data/repo/repo_dashboard.dart';
import 'package:graduation2/feauture/dashboard_screen/data/repo/repo_supplier_dashboard.dart';


import '../../manager/supplierdashboard_apiserves.dart';
import '../model/materialsupplierdashboard.dart';

class ReposupplierDashboardImple implements RepoSupplierDashboard {
  final MaterialsupplierdashboardApiService materialsupplierdashboardApiService;

  ReposupplierDashboardImple(this.materialsupplierdashboardApiService);

  @override
  Future<Either<ApiError, List<materialsupplierdashboardModel>>>
  getspacificsupplierProducts() async {
    try {
      final response =
      await materialsupplierdashboardApiService.getspacificsupplierProducts();
      return Right(response);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }




}
