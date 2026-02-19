import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/api_services.dart';
import 'product_state.dart';
import '../data/model/prodect_model_explore.dart';
import 'prodect_apiservice.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductApiService apiService;

  ProductCubit(this.apiService) : super(ProductInitial());

  // 🔹 All Products (Explore)
  Future<void> fetchAllProducts() async {
    emit(ProductLoading());
    try {
      final List<ProductsModel> products = await apiService.fetchAllProducts();

      products.isNotEmpty
          ? emit(ProductSuccess(products))
          : emit(ProductFailure("No products found"));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  // 🔹 Top Products (Best Sellers)
  Future<void> fetchTopProducts() async {
    emit(ProductLoading());
    try {
      final List<ProductsModel> products = await apiService
          .fetchTopProductsFromApi();

      products.isNotEmpty
          ? emit(ProductSuccess(products))
          : emit(ProductFailure("No top products found"));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}

class ProductsCubit extends Cubit<ProductState> {
  final ProductOwnerProfileRepo repo;

  ProductsCubit(this.repo) : super(ProductInitial());

  Future<void> getProducts(String userId) async {
    emit(ProductLoading());
    try {
      final products = await repo.getProductsOfUser(userId);
      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}



/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/manager/product_state.dart';

import '../../../core/const/api_endpoint.dart';
import '../../../core/services/api_services.dart';
import '../data/model/creatprodect_model.dart';

import '../data/model/prodect_model_explore.dart';

class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;
  ProductCubit(this.apiService) : super(ProductInitial());

  Future<void> fetchAllProducts() async {
    emit(ProductLoading());
    try {
      final response = await apiService.get(ApiEndpoint.GetAllProdets, null);

      if (response is List) {
        final products = response.map((e) => ProductsModel.fromJson(e)).toList();
        emit(ProductSuccess(products));
      } else if (response is Map<String, dynamic> && response['data'] != null) {
        // لو الداتا راجعة جوه كائن اسمه data
        final List data = response['data'];
        final products = data.map((e) => ProductsModel.fromJson(e)).toList();
        emit(ProductSuccess(products));
      } else {
        emit(ProductFailure("Failed to load products"));
      }
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

}*/