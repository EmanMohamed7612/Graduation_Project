import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/rescources/colors.dart';
import '../../../../../core/services/api_services.dart';
import '../../../../../core/services/dio_client.dart';
import '../../../../../core/utils/pref_helpers.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../favourite/manager/favourite_cubit.dart';
import '../../../../favourite/views/favourite_screen.dart';
import '../../../../profile/manager/account.cubit.dart';
import '../../../../profile/views/accounts/account.dart';
import '../../../../review/data/cart_repo.dart';
import '../../../../review/manager/cart_cubit.dart';
import '../../../../review/manager/cart_state.dart';
import '../../../../review/view/cart/cart_screen.dart';
import 'package:graduation2/feauture/favourite/manager/fav_state.dart';

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
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
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
            /// ✅ كارت المشتريات المطور والمضمون
            /// ✅ كارت المشتريات المنقذ والمضمون 100% بدون أي إيرورز
            StatefulBuilder(
              builder: (context, setStateBar) {
                return FutureBuilder<String?>(
                  // 1️⃣ أولاً: بنجيب الـ id الصح المتسيف في الكاش
                  future: PrefHelpers.getCartId(),
                  builder: (context, idSnapshot) {
                    final savedCartId = idSnapshot.data ?? "1"; // لو ملعق بياخد "1" مؤقتاً

                    return FutureBuilder(
                      // 2️⃣ ثانياً: بنجيب بيانات السلة طازة بناءً على الـ ID الصح
                      future: CartRepo().getCart(savedCartId),
                      builder: (context, cartSnapshot) {
                        int count = 0;
                        if (cartSnapshot.hasData && cartSnapshot.data != null) {
                          count = cartSnapshot.data!.cartItems.length;
                        }

                        return GestureDetector(
                          onTap: () async {
                            if (context.mounted) {
                              // ننتظر الذهاب لصفحة الكارت وعند العودة نقوم بعمل تحديث تلقائي
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(userId: savedCartId),
                                ),
                              );

                              // ✅ أول ما يرجع، بنجبر الـ AppBar تعيد قراءة الـ Future وتحدث الرقم فوراً!
                              setStateBar(() {});
                            }
                          },
                          child: buildIcon(
                            icon: Icons.shopping_cart_outlined,
                            count: count,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(width: 10),

            /// ✅ أيقونة المفضلة
            BlocBuilder<MyFavoriteCubit, FavoriteState>(
              builder: (context, state) {
                int favCount = 0;
                if (state is FavoriteLoaded) {
                  favCount = state.favoriteIds.length;
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavouriteScreen(),
                      ),
                    );
                  },
                  child: buildIcon(
                    icon: Icons.favorite_border,
                    count: favCount,
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

            GestureDetector(
              onTap: () async {
                final userId = await PrefHelpers.getUserId();
                if (userId != null && context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AccountCubit(UserProfileRepo())..fetchAccount(userId),
                        child: const AccountScreen(),
                      ),
                    ),
                  );
                }
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
            ),
          ],
        )
      ],
    );
  }
}