import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/categories_list.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_app_bar.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_top_product.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/search_bar_widget.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/section_title.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/top_sellers_list.dart';
import 'package:graduation2/feauture/profile/data/user_profile_repo.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';

import '../../../../core/rescources/colors.dart';
import '../../../../generated/locale_keys.g.dart';

import '../../../product_of_categoryscreen/category_screen2.dart';

import 'widget/product_category.dart';

//origin/book-session
import '../../../product_screens/manager/prodect_apiservice.dart';
import '../../../product_screens/manager/product_cubit.dart';
import '../../../product_screens/presentation/view/getall_seller_screen.dart';
import '../../../product_screens/presentation/view/top_prodect/view/top_prodect_screen.dart';
import '../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';
import '../../../review/manager/cart_cubit.dart';
import '../../../review/data/cart_repo.dart';
import '../../manager/category_cubit.dart';
import '../../manager/fav_apiserves.dart';

import '../../../../core/services/dio_client.dart';
import '../../manager/search_apiservice.dart';
import '../../manager/search_cubit.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onGoProfile;
  const HomeScreen({super.key, required this.onGoProfile});

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
          UserProfileCubit(UserProfileRepo())..fetchProfile(),
        ),
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

        // ❌ تم إزالة الـ BlocProvider لـ FavoriteCubit من هنا لمنع التهيئة المكررة

        //origin/book-session
        BlocProvider(
          create: (context) =>
          CartCubit(repo: CartRepo(), cartId: "1")..loadCart(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(
            SearchApiService(DioClient().dio),
          ),
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
                HomeAppBar(onGoProfile: widget.onGoProfile),
                const SizedBox(height: 16),

                const SearchBarWidget(),
                const SizedBox(height: 20),

                SectionTitle(
                  title: LocaleKeys.categories.tr(),
                  trailing: LocaleKeys.see_all.tr(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductCategoriesScreen(),
                      ),
                    );
                  },
                ),

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
                  title: LocaleKeys.top_products.tr(),
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