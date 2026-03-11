// ProductsellerCubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/dashboard_screen/data/repo/repo_dashboard.dart';
import 'package:graduation2/feauture/dashboard_screen/data/repo/repo_supplier_dashboard.dart';
import 'package:graduation2/feauture/dashboard_screen/manager/sellerdashboard_state.dart';
import 'package:graduation2/feauture/dashboard_screen/manager/supplierdashboard_state.dart';
import '../data/model/materialsupplierdashboard.dart';
import '../data/model/productsellerdashboardmodel.dart';
import '../data/repo/repo_supplier_dashboard.dart';

class ProductsupplierCubit extends Cubit<ProductsupplierdashboardState> {
  ProductsupplierCubit(this.repoSupplierDashboard) : super(ProductsupplierInitial());

  final RepoSupplierDashboard repoSupplierDashboard;
  List<materialsupplierdashboardModel> products = [];

  Future<void> getmaterial() async {
    emit(ProductsupplierLoading());
    final result = await repoSupplierDashboard.getspacificsupplierProducts();
    result.fold(
          (error) => emit(ProductsupplierError(error.message)),
          (List<materialsupplierdashboardModel> data) {
        products = data;
        emit(ProductsupplierSuccess(products));
      },
    );
  }

  // ✅ ضيفي ده
  void removeProduct(int id) {
    products.removeWhere((p) => p.id == id);
    emit(ProductsupplierSuccess(List.from(products)));
  }
}