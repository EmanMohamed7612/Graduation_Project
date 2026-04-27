
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/rescources/colors.dart';
import '../../../../../core/services/dio_client.dart';
import '../../../../../core/utils/pref_helpers.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../favourite/manager/favourite_cubit.dart';
import '../../../../favourite/views/favourite_screen.dart';
import '../../../../review/manager/cart_cubit.dart';
import '../../../../review/manager/cart_state.dart';
import '../../../../review/view/cart/cart_screen.dart';
import '../../../manager/fav_apiserves.dart';
import '../../../manager/fav_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  Widget buildIcon({
    required IconData icon,
    required int count,
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22),
        ),
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.Craftoria.tr(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.kTextDark,
          ),
        ),
        Row(
          children: [
            /// ✅ كارت مع تحديث مباشر
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                int count = 0;
                if (state is CartLoaded) {
                  count = state.cart.cartItems.length;
                }

                return GestureDetector(
                  onTap: () async {
                    final userId = await PrefHelpers.getUserId();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<CartCubit>(), // 🔹 استخدم نفس الـ Cubit
                          child: CartScreen(userId: userId!),
                        ),
                      ),
                    );
                  },
                  child: buildIcon(
                    icon: Icons.shopping_cart_outlined,
                    count: count,
                  ),
                );
              },
            ),

            const SizedBox(width: 10),

            /// Fav count
            BlocBuilder<FavoriteCubit, List<int>>(
              builder: (context, favorites) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          // بنكريت نسخة جديدة من الـ Cubit مخصوص للصفحة دي
                          create: (context) => MyFavoriteCubit(FavoriteApiService(DioClient())),
                          child: const FavouriteScreen(),
                        ),
                      ),
                    );
                  },
                  child: buildIcon(
                    icon: Icons.favorite_border,
                    count: favorites.length,
                  ),
                );
              },
            ),
            const SizedBox(width: 10),

            buildIcon(
              icon: Icons.notifications_none,
              count: 3,
            ),
            const SizedBox(width: 10),

            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ],
        )
      ],
    );
  }
}
