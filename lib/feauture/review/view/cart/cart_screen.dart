import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/review/data/cart_model.dart';
import 'package:graduation2/feauture/review/manager/cart_cubit.dart';
import 'package:graduation2/feauture/review/manager/cart_state.dart';
import 'package:graduation2/feauture/review/view/cart/widget/cart_item_card.dart'
    as card;
import 'package:graduation2/feauture/review/view/cart/widget/order_summary_card.dart';
import 'package:graduation2/feauture/review/view/cart/widget/primary_button.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

import '../../../order_screen/deliver_screen/deliver_address.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.userId});
  final String userId;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItemDto> items = [];

  final double shipping = 5;
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();
    // 👈 التعديل الأول: نتأكد إننا بنحمل الداتا لو الـ Cubit لسه في البداية
    final cartCubit = context.read<CartCubit>();
    if (cartCubit.state is CartInitial) {
      cartCubit.loadCart(); // أو loadCartFromPrefs() حسب اللوجيك بتاعك
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
        title: Text(
          LocaleKeys.mycart.tr(),
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w700,
            height: 1.50,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// المحتوى
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          // if (state is CartLoading) {
                          //   return Center(child: CircularProgressIndicator());
                          // }
                          if (state is CartInitial || state is CartLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is CartError) {
                            return Center(child: Text(state.message));
                          }

                          if (state is CartLoaded) {
                            final items = state.cart.cartItems;

                            if (items.isEmpty) {
                              return Center(
                                child: Text(LocaleKeys.yourcartisempty.tr()),
                              );
                            }

                            /// نحسب subtotal من المنتجات
                            final subtotal = items.fold(
                              0.0,
                              (sum, item) => sum + (item.price * item.quantity),
                            );

                            return Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: items.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 16),
                                  itemBuilder: (context, index) {
                                    final item = items[index];

                                    return card.CartItemCard(
                                      item: item,
                                      onIncrease: () async {
                                        final userId =
                                            await PrefHelpers.getUserId();
                                        context
                                            .read<CartCubit>()
                                            .updateQuantity(
                                              cartId: userId!,
                                              productId: item.id,
                                              isIncrement: true,
                                            );
                                      },
                                      // onDecrease: () async {
                                      //   final userId =
                                      //       await PrefHelpers.getUserId();
                                      //   context
                                      //       .read<CartCubit>()
                                      //       .updateQuantity(
                                      //         cartId: userId!,
                                      //         productId: item.id,
                                      //         isIncrement: false,
                                      //       );
                                      // },
                                      // onDelete: () {
                                      //   context.read<CartCubit>().deleteItem(
                                      //     item.id,
                                      //   );
                                      // },
                                      onDecrease: () async {
                                        // ✅ المنطق الجديد هنا
                                        if (item.quantity > 1) {
                                          // لو أكبر من 1، قلل عادي
                                          final userId =
                                              await PrefHelpers.getUserId();
                                          context
                                              .read<CartCubit>()
                                              .updateQuantity(
                                                cartId: userId!,
                                                productId: item.id,
                                                isIncrement: false,
                                              );
                                        } else {
                                          showDialog(
                                            context: context,

                                            builder: (BuildContext dialogContext) {
                                              // سميناه dialogContext لتجنب التداخل
                                              return AlertDialog(
                                                content: Text(
                                                  "${LocaleKeys.areyousureyouwanttodelete.tr()} ${item.itemName} ${LocaleKeys.fromyourcart.tr()}",
                                                ),
                                                title: Text(
                                                  LocaleKeys.confirmdelete.tr(),
                                                ),
                                                // ... (إعدادات الـ AlertDialog الخاصة بك)
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                          dialogContext,
                                                        ),
                                                    child: Text(
                                                      LocaleKeys.cancel.tr(),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      // 1. أغلق الـ Dialog أولاً
                                                      Navigator.pop(
                                                        dialogContext,
                                                      );

                                                      // 2. نفذ أمر الحذف
                                                      await context
                                                          .read<CartCubit>()
                                                          .deleteItem(item.id);

                                                      // 3. تأكدي أن الـ Cubit يقوم بإعادة تحميل السلة (Load)
                                                      // إذا كان الـ deleteItem لا يقوم بعمل load تلقائياً، أضيفي هذا السطر:
                                                      // context.read<CartCubit>().loadCart();
                                                    },
                                                    child: Text(
                                                      LocaleKeys.delete.tr(),
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      onDelete: () {
                                        context.read<CartCubit>().deleteItem(
                                          item.id,
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),

                                OrderSummaryCard(
                                  subtotal: subtotal,
                                  shipping: shipping,
                                ),
                              ],
                            );
                          }

                          return SizedBox();
                        },
                      ),

                      // const SizedBox(height: 20),

                      // OrderSummaryCard(subtotal: subtotal, shipping: shipping),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              /// الزرار في آخر الصفحة
              PrimaryButton(
                text: LocaleKeys.proceedtocheckout.tr(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryAddressScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
