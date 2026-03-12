/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/categories_list.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_app_bar.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_top_product.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/search_bar_widget.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/section_title.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/top_sellers_list.dart';

import '../../../../core/rescources/colors.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/dio_client.dart';
import '../../../product_screens/manager/prodect_apiservice.dart';
import '../../../product_screens/manager/product_cubit.dart';
import '../../../product_screens/presentation/view/getall_seller_screen.dart';
import '../../../product_screens/presentation/view/top_prodect/view/top_prodect_screen.dart';
import '../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';
import '../../../review/manager/cart_cubit.dart';

import '../../manager/category_cubit.dart';
import '../../manager/fav_apiserves.dart';
import '../../manager/fav_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoryCubit(ProductApiService())..fetchCategories(),
        ),

        BlocProvider(
          create: (context) =>
              ProductCubit(ProductApiService())..fetchTopProducts(),
        ),

        BlocProvider(
          create: (context) =>
              BestSellerCubit(ProductApiService())..fetchBestSellers(),
        ),

        BlocProvider(
          create: (_) => FavoriteCubit(FavoriteApiService(DioClient())),
        ),

        BlocProvider(
          create: (context) => CartCubit(
            repo: CartRepo(),
            cartId: "1", // مؤقت لحد ما يجي من اليوزر
          )..loadCart(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.kBgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const SizedBox(height: 16),

                const SearchBarWidget(),
                const SizedBox(height: 20),

                const SectionTitle(title: "Categories"),
                const SizedBox(height: 12),

                const CategoriesList(),
                const SizedBox(height: 20),

                SectionTitle(
                  title: "Top Sellers",
                  trailing: "See All",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) =>
                              BestSellerCubit(ProductApiService())
                                ..fetchBestSellers(),
                          child: const AllSellersScreen(),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                const TopSellersList(),
                const SizedBox(height: 20),

                SectionTitle(
                  title: "Top prodect",
                  trailing: "View All",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TopProductsScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                const HomeTopProductsSection(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/categories_list.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_app_bar.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_top_product.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/search_bar_widget.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/section_title.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/top_sellers_list.dart';

import '../../../../core/rescources/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../product_screens/manager/prodect_apiservice.dart';
import '../../../product_screens/manager/product_cubit.dart';
import '../../../product_screens/presentation/view/getall_seller_screen.dart';
import '../../../product_screens/presentation/view/top_prodect/view/top_prodect_screen.dart';
import '../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';
import '../../../review/manager/cart_cubit.dart';
import '../../../review/data/cart_repo.dart';
import '../../manager/category_cubit.dart';
import '../../manager/fav_apiserves.dart';
import '../../manager/fav_cubit.dart';
import '../../../../core/services/dio_client.dart';
import '../../manager/search_apiservice.dart';
import '../../manager/search_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) =>
          CategoryCubit(ProductApiService())..fetchCategories(),
        ),

        BlocProvider(
          create: (context) =>
          ProductCubit(ProductApiService())..fetchTopProducts(),
        ),

        BlocProvider(
          create: (context) =>
          BestSellerCubit(ProductApiService())..fetchBestSellers(),
        ),

        BlocProvider(
          create: (_) => FavoriteCubit(FavoriteApiService(DioClient())),
        ),

        BlocProvider(
          create: (context) => CartCubit(
            repo: CartRepo(),
            cartId: "1",
          )..loadCart(),
        ),
        // أضف هذا داخل قائمة providers في HomeScreen
        BlocProvider(
          create: (context) => SearchCubit(SearchApiService(DioClient().dio)), // تأكد من تمرير Dio بشكل صحيح
        ),

      ],
      child: Scaffold(
        backgroundColor: AppColors.kBgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const HomeAppBar(),
                const SizedBox(height: 16),

                const SearchBarWidget(),
                const SizedBox(height: 20),

                 SectionTitle(title:LocaleKeys.categories.tr()),
                const SizedBox(height: 12),

                const CategoriesList(),
                const SizedBox(height: 20),

                SectionTitle(
                  title: LocaleKeys.top_sellers.tr(),
                  trailing: LocaleKeys.see_all.tr(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) =>
                          BestSellerCubit(ProductApiService())
                            ..fetchBestSellers(),
                          child: const AllSellersScreen(),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                const TopSellersList(),
                const SizedBox(height: 20),

                SectionTitle(
                  title:LocaleKeys.top_products.tr(),
                  trailing: LocaleKeys.view_all.tr(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TopProductsScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                const HomeTopProductsSection(),

                const SizedBox(height: 24),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/rescources/colors.dart';
import '../../../product_screens/manager/product_cubit.dart';
import '../../../product_screens/manager/product_state.dart';
import '../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../review/manager/cart_cubit.dart';
import '../../manager/fav_cubit.dart';

class HomeTopProductsSection extends StatefulWidget {
  const HomeTopProductsSection({super.key});

  @override
  State<HomeTopProductsSection> createState() => _HomeTopProductsSectionState();
}

class _HomeTopProductsSectionState extends State<HomeTopProductsSection> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 1️⃣ AppBar Search
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: "Search crafts & materials...",
              prefixIcon: Icon(Icons.search, color: AppColors.kTextLight),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// 2️⃣ Top Products Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Top Products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        /// 3️⃣ Top Products Section
        BlocBuilder<ProductCubit, ProductState>(
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
              return const SizedBox(
                height: 200,
                child: Center(child: Text("Failed to load products")),
              );
            }

            if (state is ProductSuccess) {
              // لو السيرش فاضي، نعرض الـ Top 4
              // لو في نص سيرش، نفلتر كل المنتجات حسب الاسم
              final filteredProducts = searchQuery.isEmpty
                  ? state.products.take(4).toList()
                  : state.products
                  .where(
                    (p) => p.name.toLowerCase().contains(searchQuery),
              )
                  .toList();

              if (filteredProducts.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text("No products found")),
                );
              }

              return SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return BlocBuilder<FavoriteCubit, List<int>>(
                      builder: (context, favorites) {
                        final isFav = favorites.contains(product.id);

                        return SizedBox(
                          width: 150,
                          child: Stack(
                            children: [
                              /// الكارت (اضافة للعربة)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  context
                                      .read<CartCubit>()
                                      .toggleCartItem(product.id);
                                },
                                child: TopProductCard(
                                  rank: index + 1,
                                  name: product.name,
                                  price: product.price.toString(),
                                  rating: product.rating.toString(),
                                  imageUrl: product.imageUrl,
                                ),
                              ),

                              /// زر المفضلة
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      context
                                          .read<FavoriteCubit>()
                                          .toggleFavorite(product.id);
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
        ),
      ],
    );
  }
}*/
