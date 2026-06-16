/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/rescources/colors.dart';
import '../../../../../generated/locale_keys.g.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => Container(
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  "assets/images/topprodect.png",
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text( LocaleKeys.ceramic_bowl.tr(),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text("\$45",
                    style: TextStyle(color: AppColors.kPrimaryBrown)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/rescources/colors.dart';
import '../../../../../core/services/api_services.dart';
import '../../../../../core/services/dio_client.dart';
import '../../../../../core/utils/pref_helpers.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../favourite/manager/fav_state.dart'; // 👈 تأكدي من مسار الـ State الصحيح
import '../../../../favourite/manager/favourite_cubit.dart'; // 👈 MyFavoriteCubit
import '../../../../favourite/views/favourite_screen.dart';
import '../../../../profile/manager/account.cubit.dart';
import '../../../../profile/manager/profile_cubit.dart';
import '../../../../profile/views/accounts/account.dart';
import '../../../../profile/views/myprofile/profile.dart';
import '../../../../review/manager/cart_cubit.dart';
import '../../../../review/manager/cart_state.dart';
import '../../../../review/view/cart/cart_screen.dart';
import '../../../manager/fav_apiserves.dart';

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
                          value: context.read<CartCubit>(),
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

            /// ✅ تعديل جزء المفضلة ليقرأ بشكل موحد وصحيح
            BlocBuilder<MyFavoriteCubit, FavoriteState>(
              builder: (context, state) {
                int count = 0;

                // لو البيانات اتحملت بنجاح، ناخد عدد العناصر في اللستة مباشرة
                if (state is FavoriteLoaded) {
                  count = state.products.length;
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // 🔹 نستخدم BlocProvider.value علشان نمرر نفس الـ Cubit الموحد للشاشة التانية بدل ما نكريت واحد جديد يضيع البيانات
                        builder: (_) => BlocProvider.value(
                          value: context.read<MyFavoriteCubit>(),
                          child: const FavouriteScreen(),
                        ),
                      ),
                    );
                  },
                  child: buildIcon(
                    icon: Icons.favorite_border,
                    count: count,
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
                } else {
                  print("User ID is null or context is unmounted");
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