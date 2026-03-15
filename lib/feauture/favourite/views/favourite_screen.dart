import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/favourite/manager/fav_state.dart';
import 'package:graduation2/feauture/favourite/manager/favourite_cubit.dart';
import 'package:graduation2/feauture/home/manager/fav_apiserves.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key, this.onGoHome});
  final VoidCallback? onGoHome;

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyFavoriteCubit>().getFavorites();
    // 👈 هنا
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff6D4C41),
          ),
        ),
        title: Text(
          LocaleKeys.wishList.tr(),
          style: TextStyle(
            color: const Color(0xFF3E2723),
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
            icon: Icon(Icons.favorite, color: Color(0xff6D4C41)),
          ),
        ],
      ),
      body: BlocBuilder<MyFavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteLoaded) {
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
                              // product.imageUrl != null &&
                              //     product.imageUrl!.startsWith('http')
                              // ? Image.network(
                              //     product.imageUrl!,

                              //     width: double.infinity,
                              //     fit: BoxFit.cover,
                              //   )
                              // : Image.asset(
                              //     'assets/images/no_photo.png',
                              //     // height: height * .15,
                              //     width: double.infinity,
                              //     fit: BoxFit.cover,
                              //   ),
                            ),
                            IconButton(
                              onPressed: () {
                                final cubit = context.read<MyFavoriteCubit>();
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
                              icon: Icon(
                                Icons.favorite,
                                color: Color(0xff6D4C41),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child: Image.network(
                      //       state.products[index].imageUrl ??
                      //           'assets/images/no_photo.png',
                      //       fit: BoxFit.cover,
                      //       width: double.infinity,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                product.name,
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
          }
          return SizedBox();
        },
      ),
    );
  }
}
