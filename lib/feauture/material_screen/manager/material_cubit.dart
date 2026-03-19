import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/material_screen/data/model/addmaterialmodel.dart';
import 'package:graduation2/feauture/material_screen/manager/material_state.dart';
import 'package:graduation2/feauture/material_screen/manager/repo_material.dart';
import '../../../core/services/api_services.dart';
import '../data/model/materialmodel.dart';
import '../data/model/update_material.dart';
import 'material_api_services.dart';




class materialssCubit extends Cubit<materialState> {
  final materialOwnerProfileRepo repo;

  materialssCubit(this.repo) : super(materialInitial());

  Future<void> getProducts(String userId) async {
    emit(materialLoading());
    try {
      final products = await repo.getmaterialsOfUser(userId);
      emit(materialSuccess(products));
    } catch (e) {
      emit(materialFailure(e.toString()));
    }
  }
}

/// CreateProducts Cubit
class CreatematerialCubit extends Cubit<CreatematerialState> {
  final Repomaterial repomaterial;

  CreatematerialCubit({required this.repomaterial}) : super(CreatesupplierInitialState());

  Future<void> addTosupplierCart(CreatematerialRequestModel model) async {
    emit(CreatesupplierLoadingState());
    final result = await repomaterial.creatematerial(model);
    result.fold(
          (failure) => emit(CreatesupplierErrorState(message: failure.message)),
          (value) => emit(CreatesupplierSuccessState(product: value)),
    );
  }
}

/// UpdateProduct Cubit
class UpdatematerialCubit extends Cubit<UpdatematerialState> {
  final Repomaterial repomaterial;

  UpdatematerialCubit({required this.repomaterial}) : super(UpdatesupplierInitialState());

  Future<void> updatematerial(UpdatematerialRequestModel model) async {
    emit(UpdatesupplierLoadingState());
    final result = await repomaterial.updatematerial(model);
    result.fold(
          (failure) => emit(UpdatesupplierErrorState(message: failure.message)),
          (value) => emit(UpdatesupplierSuccessState(product: value)),
    );
  }

}

// Delete Product Cubit
class DeletematerialCubit extends Cubit<DeletematerialState> {
  final Repomaterial repomaterial;

  DeletematerialCubit({required this.repomaterial}) : super(DeletesupplierInitialState());

  Future<void> deletematerial(int id) async {
    emit(DeletesupplierLoadingState());
    final result = await repomaterial.deletematerial(id);
    result.fold(
          (failure) => emit(DeletesupplierErrorState(message: failure.message)),
          (_) => emit(DeletesupplierSuccessState()),
    );
  }
}