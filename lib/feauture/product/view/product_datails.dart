/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart' hide CartRepo;
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/home/manager/fav_cubit.dart';
import 'package:graduation2/feauture/product/manager/product_details_cubit.dart';
import 'package:graduation2/feauture/product/manager/product_details_state.dart';
import 'package:graduation2/feauture/product/view/recommendation_screen.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/profile/manager/account.cubit.dart';
import 'package:graduation2/feauture/profile/views/accounts/account.dart';
import 'package:graduation2/feauture/review/data/cart_repo.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/manager/cart_cubit.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';
import 'package:graduation2/feauture/review/view/cart/cart_screen.dart';
import 'package:graduation2/feauture/review/view/rating_screen.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key, required this.productId});
  final int productId;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ReviewApiService _reviewApiService = ReviewApiService();

  double averageRating = 0.0;
  int totalReviews = 0;
  bool isLoadingRating = true;
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().fetchProductDetails(widget.productId);
    _loadProductStats();
  }

  Future<void> _loadProductStats() async {
    final stats = await _reviewApiService.getProductStats(widget.productId);

    if (stats != null) {
      setState(() {
        averageRating = stats.averageRating;
        totalReviews = stats.totalReviews;
        isLoadingRating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
        title: Text(
          LocaleKeys.productdetails.tr(),
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        actions: [
          CustomIcon(icon: Icons.share_outlined),
          SizedBox(width: size.width * .02),
          // CustomIcon(icon: Icons.favorite_border_outlined),
          BlocBuilder<FavoriteCubit, List<int>>(
            builder: (context, favoriteIds) {
              final isFav = context.read<FavoriteCubit>().isFavorite(
                widget.productId,
              );

              return CustomIcon(
                icon: isFav ? Icons.favorite : Icons.favorite_border_outlined,
                color: isFav
                    ? Colors.red
                    : null, // هيقلب أحمر لو مفضل، غير كدة بني
                onPressed: () {
                  context.read<FavoriteCubit>().toggleFavorite(
                    widget.productId,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsFailure) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsSuccess) {
            final product = state.product;

            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02,
                  ),
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        height: size.height * .26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.network(
                          product.imageUrl ?? 'assets/images/person.png',
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * .04,
                          vertical: size.height * .01,
                        ),
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        height: size.height * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: const Color(0xFF3E2723),
                                      fontSize: 18,
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * .02,
                                    right: size.width * .02,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffFFF8E1),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Color(0xffFFD700),
                                      ),
                                      isLoadingRating
                                          ? const SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              ' ${averageRating.toStringAsFixed(1)} ',
                                              style: const TextStyle(
                                                color: Color(0xFF3E2723),
                                                fontSize: 14.5,
                                                fontFamily: 'Arimo',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                product.price.toString(),
                                style: TextStyle(
                                  color: const Color(0xFF6D4C41),
                                  fontSize: 26,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.012),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                product.description ?? '',
                                maxLines: 3, // 👈 يخليه 3 سطور بس
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: const Color(0xFF8D6E63),
                                  fontSize: 14,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.63,
                                ),
                              ),
                            ),
                            Divider(
                              height: size.height * .02,
                              thickness: 1,
                              color: const Color(0xFF8D6E63),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "  ${LocaleKeys.seller.tr()} : ",
                                    style: TextStyle(
                                      color: const Color(0xFF8D6E63),
                                      fontSize: 14,
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),

                                  // isLoadingSeller
                                  //   ? const SizedBox(
                                  //       width: 15,
                                  //       height: 15,
                                  //       child: CircularProgressIndicator(strokeWidth: 2),
                                  //     )
                                  //   : Text(
                                  //       seller?.fullName ?? 'Unknown Seller',
                                  //       style: const TextStyle(
                                  //         color: Color(0xFF3E2723),
                                  //         fontSize: 16,
                                  //         fontFamily: 'Arimo',
                                  //         fontWeight: FontWeight.w400,
                                  //       ),
                                  //     ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                            create: (_) => AccountCubit(
                                              UserProfileRepo(),
                                            )..fetchAccount(product.sellerId),
                                            child: const AccountScreen(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      product.sellerName,
                                      style: TextStyle(
                                        color: const Color(0xFF3E2723),
                                        fontSize: 16,
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * .015),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),

                            gradient: const LinearGradient(
                              begin: Alignment(0.50, 0.00),
                              end: Alignment(0.50, 1.00),
                              colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
                            ),
                          ),
                          width: size.width,
                          height: size.height * .05,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  '  ${LocaleKeys.chatwithseller.tr()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .015),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) =>
                                    ReviewCubit(ReviewApiService())
                                      ..getProductReviews(product.id),
                                child: RatingProductScreen(
                                  idProduct: product.id,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xffFAF8F5),
                            border: Border.all(color: Color(0xff6D4C41)),
                          ),
                          width: size.width,
                          height: size.height * .05,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                Text(
                                  '  ${LocaleKeys.viewreviews.tr()}  ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff6D4C41),
                                    fontSize: 18,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.youmayalsolike.tr(),
                            style: TextStyle(
                              color: const Color(0xFF3E2723),
                              fontSize: 14,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RecommendationScreen(),
                                ),
                              );
                            },
                            child: Text(
                              LocaleKeys.seemore.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFFC9A875),
                                fontSize: 14,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .01),
                      SizedBox(
                        height: size.height * .12,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              width: size.width * .3,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Image.asset(
                                'assets/images/ImageWithFallback.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: size.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final userId = await PrefHelpers.getUserId();

                              // ✅ 1. بنستخدم النسخة الموحدة اللي في الـ main عن طريق الـ context المتاح حالياً
                              if (context.mounted) {
                                context.read<CartCubit>().addItem(product.id);

                                // ✅ 2. بننقل لصفحة الكارد بأمان مع باصي الـ userId
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CartScreen(userId: userId ?? "1"),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff6D4C41)),
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xffFAF8F5),
                              ),
                              width: size.width * .4,
                              height: size.height * .05,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Color(0xff6D4C41),
                                    ),
                                    Text(
                                      LocaleKeys.addtocart.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xff6D4C41),
                                        fontSize: 18,
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),

                                gradient: const LinearGradient(
                                  begin: Alignment(0.50, 0.00),
                                  end: Alignment(0.50, 1.00),
                                  colors: [
                                    Color(0xFF6D4C41),
                                    Color(0xFF8D6E63),
                                  ],
                                ),
                              ),
                              width: size.width * .4,
                              height: size.height * .05,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '  ${LocaleKeys.buy.tr()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart' hide CartRepo;
import 'package:graduation2/core/utils/pref_helpers.dart';

// ✅ استيراد الكيوبيت والموديل والـ State للمفضلة الموحدة

import 'package:graduation2/feauture/product/manager/product_details_cubit.dart';
import 'package:graduation2/feauture/product/manager/product_details_state.dart';
import 'package:graduation2/feauture/product/view/recommendation_screen.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/profile/manager/account.cubit.dart';
import 'package:graduation2/feauture/profile/views/accounts/account.dart';
import 'package:graduation2/feauture/review/data/cart_repo.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/manager/cart_cubit.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';
import 'package:graduation2/feauture/review/view/cart/cart_screen.dart';
import 'package:graduation2/feauture/review/view/rating_screen.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

import '../../favourite/data/favourite_model.dart';
import '../../favourite/manager/fav_state.dart';
import '../../favourite/manager/favourite_cubit.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productId});
  final int productId;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ReviewApiService _reviewApiService = ReviewApiService();

  double averageRating = 0.0;
  int totalReviews = 0;
  bool isLoadingRating = true;

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().fetchProductDetails(widget.productId);
    _loadProductStats();
  }

  Future<void> _loadProductStats() async {
    final stats = await _reviewApiService.getProductStats(widget.productId);

    if (stats != null) {
      setState(() {
        averageRating = stats.averageRating;
        totalReviews = stats.totalReviews;
        isLoadingRating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
        title: Text(
          LocaleKeys.productdetails.tr(),
          style: const TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        actions: [
          const CustomIcon(icon: Icons.share_outlined),
          SizedBox(width: size.width * .02),

          // ✅ تعديل الـ BlocBuilder والـ State ليتوافق مع الكيوبيت الجديد
          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsSuccess) {
                final product = state.product;

                return BlocBuilder<MyFavoriteCubit, FavoriteState>(
                  builder: (context, favoriteState) {
                    final isFav = context.read<MyFavoriteCubit>().isFavorite(widget.productId);

                    return CustomIcon(
                      icon: isFav ? Icons.favorite : Icons.favorite_border_outlined,
                      color: isFav ? Colors.red : null,
                      onPressed: () {
                        // ✅ تعديل product.imageUrl إلى product.image لتطابق الموديل
                        final favProduct = FavouriteModel(
                          id: product.id,
                          name: product.name,
                          imageUrl: product.imageUrl.toString(),
                          price: product.price.toDouble(),
                        );
                        context.read<MyFavoriteCubit>().toggleFavorite(favProduct);
                      },
                    );
                  },
                );
              }
              return const CustomIcon(icon: Icons.favorite_border_outlined);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsFailure) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsSuccess) {
            final product = state.product;

            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02,
                  ),
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        height: size.height * .26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        // ✅ تعديل product.imageUrl إلى product.image هنا أيضاً
                        child: Image.network(
                          product.imageUrl ?? 'assets/images/person.png',
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * .04,
                          vertical: size.height * .01,
                        ),
                        clipBehavior: Clip.antiAlias,
                        width: double.infinity,
                        height: size.height * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF3E2723),
                                      fontSize: 18,
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * .02,
                                    right: size.width * .02,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffFFF8E1),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFD700),
                                      ),
                                      isLoadingRating
                                          ? const SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                          : Text(
                                        ' ${averageRating.toStringAsFixed(1)} ',
                                        style: const TextStyle(
                                          color: Color(0xFF3E2723),
                                          fontSize: 14.5,
                                          fontFamily: 'Arimo',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                product.price.toString(),
                                style: const TextStyle(
                                  color: Color(0xFF6D4C41),
                                  fontSize: 26,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.012),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                product.description ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF8D6E63),
                                  fontSize: 14,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.63,
                                ),
                              ),
                            ),
                            Divider(
                              height: size.height * .02,
                              thickness: 1,
                              color: const Color(0xFF8D6E63),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "  ${LocaleKeys.seller.tr()} : ",
                                    style: const TextStyle(
                                      color: Color(0xFF8D6E63),
                                      fontSize: 14,
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                            create: (_) => AccountCubit(
                                              UserProfileRepo(),
                                            )..fetchAccount(product.sellerId),
                                            child: const AccountScreen(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      product.sellerName,
                                      style: const TextStyle(
                                        color: Color(0xFF3E2723),
                                        fontSize: 16,
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * .015),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              begin: Alignment(0.50, 0.00),
                              end: Alignment(0.50, 1.00),
                              colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
                            ),
                          ),
                          width: size.width,
                          height: size.height * .05,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.chat_bubble_outline_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  '  ${LocaleKeys.chatwithseller.tr()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .015),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) =>
                                ReviewCubit(ReviewApiService())
                                  ..getProductReviews(product.id),
                                child: RatingProductScreen(
                                  idProduct: product.id,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xffFAF8F5),
                            border: Border.all(color: const Color(0xff6D4C41)),
                          ),
                          width: size.width,
                          height: size.height * .05,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, color: Colors.yellow),
                                Text(
                                  '  ${LocaleKeys.viewreviews.tr()}  ',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff6D4C41),
                                    fontSize: 18,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.youmayalsolike.tr(),
                            style: const TextStyle(
                              color: Color(0xFF3E2723),
                              fontSize: 14,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>  RecommendationScreen(),
                                ),
                              );
                            },
                            child: Text(
                              LocaleKeys.seemore.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFC9A875),
                                fontSize: 14,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .01),
                      SizedBox(
                        height: size.height * .12,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              width: size.width * .3,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Image.asset(
                                'assets/images/ImageWithFallback.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: size.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // نجلب الـ cartId الصحيحة لفتح صفحة الكارت بها بالتوافق مع الـ Cubit
                              final savedCartId = await PrefHelpers.getCartId();

                              if (context.mounted) {
                                // 1. إضافة المنتج للسلة (الكيوبيت هيحدث الـ State تلقائياً فوراً للـ HomeAppBar)
                                await context.read<CartCubit>().addItem(product.id);

                                // 2. الملاحة لصفحة الكارت بالـ cartId
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CartScreen(userId: savedCartId ?? "1"),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xff6D4C41)),
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xffFAF8F5),
                              ),
                              width: size.width * .4,
                              height: size.height * .05,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Color(0xff6D4C41),
                                    ),
                                    Text(
                                      LocaleKeys.addtocart.tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xff6D4C41),
                                        fontSize: 18,
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                  begin: Alignment(0.50, 0.00),
                                  end: Alignment(0.50, 1.00),
                                  colors: [
                                    Color(0xFF6D4C41),
                                    Color(0xFF8D6E63),
                                  ],
                                ),
                              ),
                              width: size.width * .4,
                              height: size.height * .05,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '  ${LocaleKeys.buy.tr()}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}