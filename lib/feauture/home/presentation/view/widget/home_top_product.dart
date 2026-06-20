import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../favourite/manager/favourite_cubit.dart'; // تأكدي من صحة هذا المسار طبقاً لمكان الـ Cubit الجديد
import '../../../../favourite/manager/fav_state.dart';      // مسار الـ FavoriteState الجديد
import '../../../../product/view/product_datails.dart';
import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';

class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {

        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),

              itemBuilder: (context, index) {
                final product = products[index];

                // التعديل هنا: استخدام الـ FavoriteState المدمجة الجديدة بدلاً من List<int>
                return BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, favState) {

                    // استخدام دالة الـ isFavorite المدمجة داخل الـ Cubit للتأكد من حالة المنتج
                    final isFav = context.read<FavoriteCubit>().isFavorite(product.id);

                    return SizedBox(
                      width: 150,
                      child: Stack(
                        children: [

                          /// الضغط على المنتج يفتح صفحة التفاصيل
                          TopProductCard(
                            rank: index + 1,
                            name: product.name,
                            price: product.price.toString(),
                            rating: product.rating.toString(),
                            imageUrl: product.imageUrl,
                            onTap: () {
                              debugPrint("Pressed product: ${product.id}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetails(productId: product.id),
                                ),
                              );
                            },
                          ),

                          /// زر المفضلة
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                // استدعاء دالة الـ toggle المحدثة
                                context.read<FavoriteCubit>().toggleFavorite(product.id);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                    )
                                  ],
                                ),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
