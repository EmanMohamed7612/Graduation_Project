import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../favourite/data/favourite_model.dart';
import '../../../../favourite/manager/fav_state.dart';
import '../../../../favourite/manager/favourite_cubit.dart';
import '../../../../product/view/product_datails.dart';
import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../../review/manager/cart_cubit.dart';

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

                return BlocBuilder<MyFavoriteCubit, FavoriteState>(
                  builder: (context, favState) {
                    final isFav = context.read<MyFavoriteCubit>().isFavorite(product.id);

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
                            // جوه ملف HomeTopProductsSection في الـ onTap بتاع الكارت:
                            onTap: () async {
                              final cartCubit = context.read<CartCubit>();

                              // بنستقبل قيمة الـ pop لو رجعت بـ true
                              final bool? shouldRefresh = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<MyFavoriteCubit>(),
                                    child: ProductDetails(productId: product.id),
                                  ),
                                ),
                              );

                              // ✅ لو رجعنا من صفحة التفاصيل، بنجبر السلة تقرأ من الكاش وتحدث الـ UI فوراً
                              if (shouldRefresh == true) {
                                await cartCubit.loadCartFromPrefs();
                              }
                            },
                          ),

                          /// زر المفضلة (تم تظبيطه ومنع الـ Cast المسبب للـ crash)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                // ⚠️ التعديل الأهم: نمرر الداتا بشكل آمن للـ toggle بدون 'as FavouriteModel'
                                // لو الـ toggleFavorite بتاخد id، مرري product.id
                                // لو بتاخد موديل كامل، مرري الـ product نفسه علطول بدونه
                                // لو جاب خط أحمر استبدلي السطر ده باللي تحت:
                                context.read<MyFavoriteCubit>().toggleFavorite(
                                  FavouriteModel(
                                    id: product.id,
                                    name: product.name,
                                    price: product.price,
                                    imageUrl: product.imageUrl.toString(),
                                  ),
                                );
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
                                  isFav ? Icons.favorite : Icons.favorite_border,
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