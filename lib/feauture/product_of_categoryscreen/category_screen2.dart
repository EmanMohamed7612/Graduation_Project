/*import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_of_categoryscreen/search_detailsof%20category.dart';


import '../home/manager/category_cubit.dart';
import '../home/manager/category_state.dart';
import '../home/manager/fav_cubit.dart';
import 'manager/productofcategory_apiservices.dart';
import 'manager/productofcategory_cubit.dart';



class ProductCategoriesScreen extends StatelessWidget {
  const ProductCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),

      body: SafeArea(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {

            /// loading
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            /// success
            if (state is CategorySuccess) {

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 10),

                      /// HEADER
                      Row(
                        children: [

                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new, size: 18),
                          ),

                          const SizedBox(width: 12),

                          const Text(
                            "Product Categories",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// SEARCH
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Search products...",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// GRID
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),

                        itemCount: state.categories.length,

                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: .9,
                        ),

                        itemBuilder: (context, index) {
                          final category = state.categories[index];

                          return GestureDetector(
                            // داخل ProductCategoriesScreen في الـ GestureDetector onTap
                            onTap: () {
                              // 1. احفظي المرجع للكيوبيت الموجود حالياً (الذي يستخدمه الهوم)
                              final favoriteCubit = context.read<FavoriteCubit>();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider( // استخدمي MultiBlocProvider لتمرير الاثنين
                                    providers: [
                                      // الكيوبيت الجديد الخاص بالمنتجات
                                      BlocProvider(
                                        create: (context) => CategoryProductCubit(CategoryProductService(Dio()))
                                          ..fetchProducts(category.id!),
                                      ),
                                      // ✅ السطر السحري: تمرير نفس الكيوبيت بتاع المفضلات للهوم
                                      BlocProvider.value(
                                        value: favoriteCubit,
                                      ),
                                    ],
                                    child: Product2categoryScreen(
                                      categoryId: category.id!,
                                      categoryName: category.name,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                image: DecorationImage(
                                  image: (category.imageUrl == null || category.imageUrl.isEmpty)
                                      ? const AssetImage('assets/images/material.png') as ImageProvider
                                      : NetworkImage(category.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(.6),
                                      Colors.transparent
                                    ],
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                    ],
                  ),
                ),
              );
            }

            /// error
            if (state is CategoryFailure) {
              return Center(child: Text(state.error));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}*/
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// تأكدي أن المسارات (Paths) دي صحيحة حسب مشروعك
import 'package:graduation2/feauture/product_of_categoryscreen/search_detailsof%20category.dart';
import '../home/manager/category_cubit.dart';
import '../home/manager/category_state.dart';
import '../home/manager/fav_cubit.dart';
import 'manager/productofcategory_apiservices.dart';
import 'manager/productofcategory_cubit.dart';

class ProductCategoriesScreen extends StatelessWidget {
  const ProductCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: SafeArea(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CategorySuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      /// HEADER
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "Product Categories",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// GRID
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.categories.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: .9,
                        ),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];

                          return InkWell(
                            onTap: () {
                              // السطر ده بيجيب الـ FavoriteCubit اللي شغال في الـ Home
                              final favoriteCubit = context.read<FavoriteCubit>();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      // إنشاء الكيوبيت اللي هيجيب منتجات الكاتيجوري المعين
                                      BlocProvider(
                                        create: (context) => CategoryProductCubit(
                                            CategoryProductService(Dio())
                                        )..fetchProducts(category.id!),
                                      ),
                                      // تمرير نفس الـ FavoriteCubit عشان القلب يشتغل
                                      BlocProvider.value(
                                        value: favoriteCubit,
                                      ),
                                    ],
                                    child: Product2categoryScreen(
                                      categoryId: category.id!,
                                      categoryName: category.name,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                image: DecorationImage(
                                  image: (category.imageUrl == null || category.imageUrl.isEmpty)
                                      ? const AssetImage('assets/images/material.png') as ImageProvider
                                      : NetworkImage(category.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black.withOpacity(.7), Colors.transparent],
                                  ),
                                ),
                                child: Text(
                                  category.name,
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is CategoryFailure) {
              return Center(child: Text(state.error));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}