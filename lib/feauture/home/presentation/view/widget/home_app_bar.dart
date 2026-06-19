import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_state.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';
import 'package:graduation2/feauture/review/data/cart_repo.dart';

import '../../../../../core/rescources/colors.dart';
import '../../../../../core/services/dio_client.dart';
import '../../../../../core/utils/pref_helpers.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../favourite/manager/fav_state.dart';
import '../../../../favourite/manager/favourite_cubit.dart';
import '../../../../favourite/views/favourite_screen.dart';
import '../../../../review/manager/cart_cubit.dart';
import '../../../../review/manager/cart_state.dart';
import '../../../../review/view/cart/cart_screen.dart';
import '../../../manager/fav_apiserves.dart';


class HomeAppBar extends StatelessWidget {
  // const HomeAppBar({super.key});
  final VoidCallback onGoProfile; // أضيفي السطر ده
  const HomeAppBar({super.key, required this.onGoProfile});
  Widget buildIcon({required IconData icon, int count = 0}) {
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
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
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
                  //count = state.cart.cartItems.length;
                  count = state.cart.cartItems.fold(
                    0,
                    (sum, item) => sum + item.quantity,
                  );
                }

                return GestureDetector(
                  onTap: () async {
                    final userId = await PrefHelpers.getUserId();
                    print('userId : $userId');
                    print("CartId value: $userId");
                    print("CartId type: ${userId.runtimeType}");
                    final cartCubit = CartCubit(
                      repo: CartRepo(),
                      cartId: userId!,
                      // userId!,
                    );

                    // ✅ ضيف المنتج الأول

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: cartCubit, // ✅ نستخدم نفس الكيوبت
                          child: CartScreen(userId: userId),
                        ),
                      ),
                    );
                    // final userId = await PrefHelpers.getUserId();

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => BlocProvider.value(
                    //       value: context
                    //           .read<CartCubit>(), // 🔹 استخدم نفس الـ Cubit
                    //       child: CartScreen(userId: userId!),
                    //     ),
                    //   ),
                    // );
                  },
                  child: buildIcon(
                    icon: Icons.shopping_cart_outlined,
                    count: 0,
                  ),
                );
              },
            ),

            const SizedBox(width: 10),

            /// Fav count
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                // جلب عدد العناصر المفضلة من الـ products اللي جوه الـ state الجديدة
                int favoriteCount = state.products.length;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // مش محتاجين نكريت كيوبيت جديد هنا خالص، بننقل لصفحة المفضلة علطول
                        // لأنها هتشوف الكيوبيت الأساسي المفتوح للتطبيق كله
                        builder: (_) => const FavouriteScreen(),
                      ),
                    );
                  },
                  child: buildIcon(
                    // تقدري تغيري شكل الأيقونة لو القائمة مش فاضية مثلاً
                    icon: favoriteCount > 0 ? Icons.favorite : Icons.favorite_border,
                    count: favoriteCount, // العداد هيتحدث تلقائياً هنا
                  ),
                );
              },
            ),
            const SizedBox(width: 10),

           // buildIcon(icon: Icons.notifications_none, count: 3),
            const SizedBox(width: 10),
            GestureDetector(
              onTap:
                  // الانتقال لصفحة البروفايل مع تمرير الـ Cubit الحالي لتجنب الـ ProviderNotFoundException
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => BlocProvider.value(
                  //       value: context.read<UserProfileCubit>(),
                  //       child: const Profile(),
                  //     ),
                  //   ),
                  // );
                  onGoProfile,
              child: BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  String? profileImageUrl;

                  // إذا نجح تحميل البيانات، نأخذ رابط الصورة من الموديل
                  if (state is UserProfileSuccess) {
                    profileImageUrl = state
                        .profile
                        .profileImage; // ⚠️ تأكدي من مسمى المتغير عندك في الـ Model
                  }

                  return CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        (profileImageUrl != null && profileImageUrl.isNotEmpty)
                        ? NetworkImage(profileImageUrl) as ImageProvider
                        : const AssetImage(
                            "assets/images/person.png",
                          ), // الصورة الافتراضية في حال عدم وجود صورة أو أثناء التحميل
                    child: state is UserAccountLoading
                        ? const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: Colors.brown,
                            ),
                          )
                        : null,
                  );
                },
              ),
            ),
            // const CircleAvatar(
            //   radius: 16,
            //   backgroundImage: AssetImage("assets/images/profile.png"),
            // ),
          ],
        ),
      ],
    );
  }
}
