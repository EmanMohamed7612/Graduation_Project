

import '../data/model/materialsupplierdashboard.dart';


abstract class ProductsupplierdashboardState {}

class ProductsupplierInitial extends ProductsupplierdashboardState {}

class ProductsupplierLoading extends ProductsupplierdashboardState {}

class ProductsupplierSuccess extends ProductsupplierdashboardState {

  final List<materialsupplierdashboardModel> products;

  ProductsupplierSuccess(this.products);
}

class ProductsupplierError extends ProductsupplierdashboardState {

  final String message;

  ProductsupplierError(this.message);
}