import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/favourite/manager/fav_state.dart';
import 'package:graduation2/feauture/favourite/manager/favourite_cubit.dart'; // مسار الـ Cubit الجديد
import 'package:graduation2/generated/locale_keys.g.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key, this.onGoHome});
  final VoidCallback? onGoHome;

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _RawMaterialDetailsState {}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    // التعديل: قراءة الكيوبيت الجديد FavoriteCubit
    context.read<FavoriteCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // للحفاظ على خلفية نظيفة للكروت
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff6D4C41),
          ),
        ),
        title: Text(
          LocaleKeys.wishList.tr(),
          style: const TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 16,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite, color: Color(0xff6D4C41)),
          ),
        ],
      ),
      // التعديل: تغيير اسم الكيوبيت إلى FavoriteCubit
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading && state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // تم تعديل الشرط ليتوافق مع الـ state المدمجة والـ products المتاحة بكاش الكيوبيت
          final products = state.products;

          if (products.isEmpty) {
            return Center(child: Text(LocaleKeys.nofavouritesyet.tr()));
          }

          return GridView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (_, __, ___) =>
                                  Image.asset('assets/images/no_photo.png'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // التعديل: الاحتفاظ بنسخة الكيوبيت الجديد قبل فتح الـ dialog
                              final cubit = context.read<FavoriteCubit>();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      LocaleKeys.removeFavourite.tr(),
                                    ),
                                    content: Text(
                                      LocaleKeys
                                          .areyousureyouwanttoremovethisproductfromwishlist
                                          .tr(),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(LocaleKeys.cancel.tr()),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(LocaleKeys.ok.tr()),
                                        onPressed: () {
                                          cubit.removeFavorite(product.id);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Color(0xff6D4C41),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Center(
                            child: Text(
                              '${product.price.toDouble()}  EGP',
                              style: const TextStyle(
                                color: Color(0xff7A4A32),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
