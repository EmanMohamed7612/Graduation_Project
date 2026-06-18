import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart' hide CartRepo;
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/home/manager/fav_cubit.dart';
import 'package:graduation2/feauture/product/data/recommendation_repo.dart';
import 'package:graduation2/feauture/product/manager/product_details_cubit.dart';
import 'package:graduation2/feauture/product/manager/product_details_state.dart';
import 'package:graduation2/feauture/product/manager/recommendation_cubit.dart';
import 'package:graduation2/feauture/product/manager/recommendtion_state.dart';
import 'package:graduation2/feauture/product/view/recommendation_screen.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/profile/data/user_profile_repo.dart';
import 'package:graduation2/feauture/profile/manager/account.cubit.dart';
import 'package:graduation2/feauture/profile/views/accounts/account.dart';
import 'package:graduation2/feauture/review/data/cart_repo.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/manager/cart_cubit.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';
import 'package:graduation2/feauture/review/view/cart/cart_screen.dart';
import 'package:graduation2/feauture/review/view/rating_matrial_screen.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class RawMaterialDetails extends StatefulWidget {
  RawMaterialDetails({super.key, required this.productId});
  int productId;

  @override
  State<RawMaterialDetails> createState() => _RawMaterialDetailsState();
}

class _RawMaterialDetailsState extends State<RawMaterialDetails> {
  final ReviewApiService _reviewApiService = ReviewApiService();

  double averageRating = 0.0;
  int totalReviews = 0;
  bool isLoadingRating = true;
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().fetchMaterialDetails(widget.productId);
    _loadProductStats();
  }

  Future<void> _loadProductStats() async {
    final stats = await _reviewApiService.getRawMatrialState(widget.productId);

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
          LocaleKeys.rawmaterialdetails.tr(),
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        actions: [
         // CustomIcon(icon: Icons.share_outlined),
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
                  context.read<FavoriteCubit>().toggleFavoriteForMaterial(
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
                        height: size.height * .24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.network(
                          product.imageUrl ?? 'assets/images/no_photo.png',
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
                        height: size.height * .26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    color: const Color(0xFF3E2723),
                                    fontSize: 18,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w400,
                                    height: 1.43,
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
                                      //                                    Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) => BlocProvider(
                                      //       create: (_) => UserAccountCubit(UserProfileRepo())
                                      //         ..fetchAccount(product.sellerId), // 👈 هنا بنجيب الاكونت حسب sellerId
                                      //       child: const Account(),
                                      //     ),
                                      //   ),
                                      // );
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) =>
                          //         RatingScreen(idProduct: product.id),
                          //   ),
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) =>
                                    ReviewCubit(ReviewApiService())
                                      ..getRawMaterialReviews(product.id),
                                child: RatingMatrialScreen(
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
                                  builder: (_) => BlocProvider(
                                    create: (_) =>
                                        RecommendationCubit(
                                          RecommendationRepo(),
                                        )..fetchRecommendations(
                                          product.id,
                                        ), // ضعي الـ id المطلوب هنا
                                    child: RecommendationScreen(
                                      productId: product.id,
                                    ),
                                  ),
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
                      BlocProvider(
                        create: (context) =>
                            RecommendationCubit(RecommendationRepo())
                              ..fetchRecommendations(product.id),
                        child: BlocBuilder<RecommendationCubit, RecommendationState>(
                          builder: (context, recState) {
                            if (recState is RecommendationLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (recState is RecommendationFailure) {
                              return Center(child: Text(recState.errorMessage));
                            }
                            if (recState is RecommendationSuccess) {
                              // أخذ أول 3 منتجات فقط من القائمة القادمة من السيرفر
                              final recommendedProducts = recState.products
                                  .take(3)
                                  .toList();

                              if (recommendedProducts.isEmpty) {
                                return const Center(
                                  child: Text("No recommendations available"),
                                );
                              }

                              return SizedBox(
                                height: size.height * .12,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recommendedProducts.length,
                                  itemBuilder: (context, index) {
                                    final recProduct =
                                        recommendedProducts[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // عند الضغط على المنتج المرشح يفتح صفحته الخاصة بالـ id بتاعه
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => RawMaterialDetails(
                                              productId: recProduct.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        width: size.width * .3,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Image.network(
                                          recProduct.imageUrl ??
                                              'assets/images/no_photo.png',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => Image.asset(
                                                'assets/images/no_photo.png',
                                                fit: BoxFit.cover,
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      SizedBox(height: size.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return CartScreen(sellerId: product.sellerId,);
                              //     },
                              //   ),
                              // );
                              final userId = await PrefHelpers.getUserId();
                              print('userId : $userId');
                              print("CartId value: $userId");
                              print("CartId type: ${userId.runtimeType}");
                              final cartCubit = CartCubit(
                                repo: CartRepo(),
                                cartId: userId!,
                                // userId!,
                              );

                              await cartCubit.addItem(
                                product.id,
                              ); // ✅ ضيف المنتج الأول

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: cartCubit, // ✅ نستخدم نفس الكيوبت
                                    child: CartScreen(userId: userId),
                                  ),
                                ),
                              );
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
                                      ' ${LocaleKeys.addtocart.tr()}',
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
}
