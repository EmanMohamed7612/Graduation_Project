import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product/data/product_details_repo.dart';
import 'package:graduation2/feauture/product/manager/product_details_cubit.dart';
import 'package:graduation2/feauture/product/view/product_datails.dart';
import 'package:graduation2/feauture/product_screens/manager/product_cubit.dart';
import 'package:graduation2/feauture/product_screens/manager/product_state.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/explore_prodect/widget/prodect_card_widget.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/explore_prodect/widget/search_filter_bar.dart';

import '../../../../../core/services/api_services.dart';
import '../../../../../generated/locale_keys.g.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final double rating;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({super.key});
  List<ProductModel> dummyProducts = [
    ProductModel(
      id: '1',
      name: 'Coffee Table',
      price: 150.0,
      rating: 4.5,
      imageUrl: 'assets/images/Container-4.png',
    ),
    ProductModel(
      id: '2',
      name: 'Modern Chair',
      price: 85.0,
      rating: 4.8,
      imageUrl: 'assets/images/Container-4.png',
    ),
    ProductModel(
      id: '3',
      name: 'Leather Sofa',
      price: 1200.0,
      rating: 4.9,
      imageUrl: 'assets/images/Container-4.png',
    ),
    ProductModel(
      id: '4',
      name: 'Wooden Shelf',
      price: 45.5,
      rating: 4.2,
      imageUrl: 'assets/images/Container-4.png',
    ),
    ProductModel(
      id: '5',
      name: 'Bed Frame',
      price: 500.0,
      rating: 4.7,
      imageUrl: 'assets/images/Container-4.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.brown,
          size: 20,
        ),
        title: Text(
          LocaleKeys.allproduct.tr(),
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.brown),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          //  SearchFilterBar(onFilterTap: () {}),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: dummyProducts.length,
              itemBuilder: (context, index) {
                final product = dummyProducts[index];
                return ProductCardWidget(
                  title: product.name,
                  price: product.price.toString(),
                  rating: product.rating.toString(),
                  imageUrl: product.imageUrl,
                  onTap: () {
                    print('Product tapped: ${product.id}');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => BlocProvider(
                    //       create: (_) => ProductDetailsCubit(ProductDetailsRepo()),
                    //       child: ProductDetails(productId: product.id),
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
