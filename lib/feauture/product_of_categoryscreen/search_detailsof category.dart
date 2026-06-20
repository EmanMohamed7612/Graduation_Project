import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../favourite/manager/favourite_cubit.dart';
import '../favourite/manager/fav_state.dart'; // مسار الـ FavoriteState الجديد
import '../product/view/product_datails.dart';
import 'data/model/productofcategory_model.dart';
import 'manager/productofcategory_cubit.dart';
import 'manager/productofcategory_state.dart';

class Product2categoryScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const Product2categoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryName
  });

  @override
  State<Product2categoryScreen> createState() => _Product2categoryScreenState();
}

class _Product2categoryScreenState extends State<Product2categoryScreen> {

  final TextEditingController searchController = TextEditingController();

  List<CategoryofProductModel> allProducts = [];
  List<CategoryofProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CategoryProductCubit>().fetchProducts(widget.categoryId);
      }
    });
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts.where((product) {
        return product.name
            .toLowerCase()
            .startsWith(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.categoryName, style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔍 Search
            TextField(
              controller: searchController,
              onChanged: filterProducts,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            BlocBuilder<CategoryProductCubit, CategoryProductState>(
              builder: (context, state) {

                if (state is CategoryProductLoading) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                else if (state is CategoryProductSuccess) {

                  // أول مرة نحفظ كل المنتجات
                  allProducts = state.products;

                  // لو مفيش فلترة → اعرض الكل
                  if (filteredProducts.isEmpty &&
                      searchController.text.isEmpty) {
                    filteredProducts = allProducts;
                  }

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
                  );
                }

                else {
                  return const Expanded(
                    child: Center(child: Text("Error loading products")),
                  );
                }
              },
            ),

            // Load More
            Center(
              child: TextButton(
                onPressed: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Load More Products",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 🔥 Product Card
class ProductCard extends StatelessWidget {
  final CategoryofProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              productId: product.id,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Stack(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  // التعديل هنا: تم تغيير الكيوبيت لـ FavoriteState الجديدة
                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, favState) {
                      // استخدام الـ دالة المدمجة لمعرفة حالة العنصر
                      final isFav = context.read<FavoriteCubit>().isFavorite(product.id);

                      return GestureDetector(
                        onTap: () {
                          context.read<FavoriteCubit>()
                              .toggleFavorite(product.id);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          Text(
            "\$${product.price}",
            style: const TextStyle(color: Colors.brown),
          ),

          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 14),
              Icon(Icons.star, color: Colors.amber, size: 14),
              Icon(Icons.star, color: Colors.amber, size: 14),
              Icon(Icons.star, color: Colors.amber, size: 14),
            ],
          )
        ],
      ),
    );
  }
}