
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dio_client.dart';
import '../add_address_screens/add_newaddress.dart';
import '../add_address_screens/manager/add_address_apiservces.dart';
import '../add_address_screens/manager/add_address_cubit.dart';
import '../deliver_screen/manager/getuseraddress_apiserves.dart';
import '../deliver_screen/manager/getuseraddress_cubit.dart';
import '../deliver_screen/manager/getuseraddress_state.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color lightBrown = const Color(0xffC9A875);

    return BlocProvider(
      create: (context) =>
      AddressCubit(AddressApiService(DioClient()))..fetchAddresses(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Order Summary",
                style: TextStyle(
                    color: Color(0xff3e2723),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Review before placing order",
                style: TextStyle(color: Color(0xff8d6c63), fontSize: 12),
              )
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// Order Items
              Container(
                padding: const EdgeInsets.all(14),
                decoration: _cardDecoration(),
                child: Column(
                  children: [

                    Row(
                      children: const [
                        Icon(Icons.inventory_2_outlined),
                        SizedBox(width: 8),
                        Text(
                          "Order Items (2)",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    _productItem(
                      image:
                      "https://images.unsplash.com/photo-1603190287605-e6ade32fa852",
                      name: "Ceramic Bowl Set",
                      price: "\$45",
                      qty: "Qty: 1",
                    ),

                    const SizedBox(height: 10),

                    _productItem(
                      image:
                      "https://images.unsplash.com/photo-1611599537845-1c7aca0091c0",
                      name: "Handmade Necklace",
                      price: "\$64",
                      qty: "Qty: 2",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Delivery Address
              Container(
                padding: const EdgeInsets.all(14),
                decoration: _cardDecoration(),
                child: Column(
                  children: [

                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 20, color: Colors.brown),
                        const SizedBox(width: 8),

                        const Text(
                          "Delivery Address",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        const Spacer(),

                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => AddAddressCubit(AddAddressApiService(DioClient())), // تأكدي من استدعاء الـ ApiService والـ Dio
                                  child: const AddNewAddressScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(
                                color: lightBrown,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// 🔥 هنا الربط مع Cubit
                    BlocBuilder<AddressCubit, AddressState>(
                      builder: (context, state) {
                        if (state is AddressLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        else if (state is AddressSuccess) {
                          final address = state.addresses.first;

                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xffF1E8DA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  address.fullName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  "${address.streetDetails}, ${address.region}\n${address.city}\n${address.phoneNumber}",
                                  style: const TextStyle(
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          );
                        }

                        else if (state is AddressError) {
                          return Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Price Details
              Container(
                padding: const EdgeInsets.all(14),
                decoration: _cardDecoration(),
                child: Column(
                  children: [

                    const Row(
                      children: [
                        Text(
                          "Price Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3e2723)),
                        )
                      ],
                    ),

                    const SizedBox(height: 14),

                    _priceRow("Subtotal:", "\$109.00",
                        titleColor: const Color(0xff8d6c63),
                        priceColor: const Color(0xff3e2723)),

                    const SizedBox(height: 8),

                    _priceRow("Shipping:", "\$5.00",
                        titleColor: const Color(0xff8d6c63),
                        priceColor: const Color(0xff3e2723)),

                    const Divider(height: 25),

                    Row(
                      children: const [
                        Text(
                          "Total:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff3e2723)),
                        ),
                        Spacer(),
                        Text(
                          "\$114.00",
                          style: TextStyle(
                            color: Color(0xffC9A875),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// Terms
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffF3ECE3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "By placing this order, you agree to our terms and conditions",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xff6d4c41),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(),

              /// Button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff6B4A3A),
                      Color(0xff8B5E4A),
                      Color(0xffA47154),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    "Continue to Payment",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Product Item
  Widget _productItem({
    required String image,
    required String name,
    required String price,
    required String qty,
  }) {
    return Row(
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image,
              height: 50, width: 50, fit: BoxFit.cover),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff3e2723))),
              Text(qty,
                  style: const TextStyle(
                      color: Color(0xff8d6c63), fontSize: 12))
            ],
          ),
        ),

        Text(price,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff6d4c41)))
      ],
    );
  }

  /// Price Row
  Widget _priceRow(String title, String price,
      {Color titleColor = Colors.black,
        Color priceColor = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(color: titleColor, fontSize: 16)),
        Text(price,
            style: TextStyle(
                color: priceColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  /// Decoration
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            color: const Color(0xff8d6e63).withOpacity(.02),
            blurRadius: 20,
            offset: const Offset(0, 5))
      ],
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/review/manager/cart_cubit.dart';
import 'package:graduation2/feauture/review/manager/cart_state.dart';

import '../add_address_screens/add_newaddress.dart';
import '../add_address_screens/manager/add_address_apiservces.dart';
import '../add_address_screens/manager/add_address_cubit.dart';
import '../deliver_screen/manager/getuseraddress_apiserves.dart';
import '../deliver_screen/manager/getuseraddress_cubit.dart';
import '../deliver_screen/manager/getuseraddress_state.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color lightBrown = const Color(0xffC9A875);

    return BlocProvider(
      create: (context) =>
      AddressCubit(AddressApiService(DioClient()))..fetchAddresses(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Order Summary",
                style: TextStyle(
                    color: Color(0xff3e2723),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Review before placing order",
                style: TextStyle(color: Color(0xff8d6c63), fontSize: 12),
              )
            ],
          ),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final cartItems = state.cart.cartItems;

              // حساب الحسابات المالية بناءً على بيانات الكارت الحقيقية
              final subtotal = cartItems.fold(
                0.0,
                    (sum, item) => sum + (item.price * item.quantity),
              );
              const double shipping = 5.0;
              final total = subtotal + shipping;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// --- Order Items Section (Logic Linked) ---
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _cardDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.inventory_2_outlined),
                              const SizedBox(width: 8),
                              Text(
                                "Order Items (${cartItems.length})",
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          // عرض قائمة المنتجات ديناميكياً
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartItems.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return _productItem(
                                image: item.pictureURL ?? "https://via.placeholder.com/150",
                                name: item.itemName,
                                price: "\$${item.price}",
                                qty: "Qty: ${item.quantity}",
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// --- Delivery Address Section ---
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _cardDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 20, color: Colors.brown),
                              const SizedBox(width: 8),
                              const Text(
                                "Delivery Address",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => AddAddressCubit(
                                            AddAddressApiService(DioClient())),
                                        child: const AddNewAddressScreen(),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Change",
                                  style: TextStyle(
                                      color: lightBrown,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, addressState) {
                              if (addressState is AddressLoading) {
                                return const Center(child: LinearProgressIndicator());
                              } else if (addressState is AddressSuccess && addressState.addresses.isNotEmpty) {
                                final address = addressState.addresses.first;
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF1E8DA),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address.fullName,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${address.streetDetails}, ${address.region}\n${address.city}\n${address.phoneNumber}",
                                        style: const TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const Text("No address selected");
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// --- Price Details Section (Logic Linked) ---
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _cardDecoration(),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Price Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3e2723)),
                              )
                            ],
                          ),
                          const SizedBox(height: 14),
                          _priceRow("Subtotal:", "\$${subtotal.toStringAsFixed(2)}",
                              titleColor: const Color(0xff8d6c63),
                              priceColor: const Color(0xff3e2723)),
                          const SizedBox(height: 8),
                          _priceRow("Shipping:", "\$${shipping.toStringAsFixed(2)}",
                              titleColor: const Color(0xff8d6c63),
                              priceColor: const Color(0xff3e2723)),
                          const Divider(height: 25),
                          Row(
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xff3e2723)),
                              ),
                              const Spacer(),
                              Text(
                                "\$${total.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: lightBrown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Terms
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3ECE3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "By placing this order, you agree to our terms and conditions",
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xff6d4c41),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const Spacer(),

                    /// Button
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff6B4A3A),
                            Color(0xff8B5E4A),
                            Color(0xffA47154),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue to Payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Your cart is empty"));
          },
        ),
      ),
    );
  }

  /// Product Item Widget
  Widget _productItem({
    required String image,
    required String name,
    required String price,
    required String qty,
  }) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xff3e2723))),
              Text(qty,
                  style: const TextStyle(color: Color(0xff8d6c63), fontSize: 12))
            ],
          ),
        ),
        Text(price,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff6d4c41)))
      ],
    );
  }

  /// Price Row Widget
  Widget _priceRow(String title, String price,
      {Color titleColor = Colors.black, Color priceColor = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: titleColor, fontSize: 16)),
        Text(price,
            style: TextStyle(
                color: priceColor, fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  /// Decoration
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            color: const Color(0xff8d6e63).withOpacity(.02),
            blurRadius: 20,
            offset: const Offset(0, 5))
      ],
    );
  }
}*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/review/manager/cart_cubit.dart';
import 'package:graduation2/feauture/review/manager/cart_state.dart';

import '../../../generated/locale_keys.g.dart';
import '../add_address_screens/add_newaddress.dart';
import '../add_address_screens/manager/add_address_apiservces.dart';
import '../add_address_screens/manager/add_address_cubit.dart';

class OrderSummaryScreen extends StatelessWidget {
  final dynamic selectedAddress; // استقبال العنوان المختار

  const OrderSummaryScreen({super.key, required this.selectedAddress});

  @override
  Widget build(BuildContext context) {
    Color lightBrown = const Color(0xffC9A875);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              LocaleKeys.order_summary_title.tr(),
              style: TextStyle(
                  color: Color(0xff3e2723),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              LocaleKeys.review_order_subtitle.tr(),
              style: TextStyle(color: Color(0xff8d6c63), fontSize: 12),
            )
          ],
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cartItems = state.cart.cartItems;

            if (cartItems.isEmpty) {
              return  Center(child: Text(LocaleKeys.empty_cart_msg.tr()));
            }

            // حساب الإجماليات
            final subtotal = cartItems.fold(
              0.0,
                  (sum, item) => sum + (item.price * item.quantity),
            );
            const double shipping = 5.0;
            final total = subtotal + shipping;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// --- Order Items ---
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _cardDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.inventory_2_outlined),
                              const SizedBox(width: 8),
                              Text(
                                "Order Items (${cartItems.length})",
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          // حل مشكلة اختفاء الصفحة: shrinkWrap + NeverScrollableScrollPhysics
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartItems.length,
                            separatorBuilder: (context, index) => const Divider(height: 20),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return _productItem(
                                image: item.pictureURL ?? "https://via.placeholder.com/150",
                                name: item.itemName,
                                price: "\$${item.price}",
                                qty: "Qty: ${item.quantity}",
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// --- Delivery Address ---
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _cardDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 20, color: Colors.brown),
                              const SizedBox(width: 8),
                              Text(LocaleKeys.delivery_address.tr(), style: TextStyle(fontWeight: FontWeight.w600)),
                              const Spacer(),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text(LocaleKeys.change_address.tr(), style: TextStyle(color: lightBrown, fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: const Color(0xffF1E8DA), borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(selectedAddress.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text("${selectedAddress.streetDetails}, ${selectedAddress.region}\n${selectedAddress.city}",
                                    style: const TextStyle(color: Colors.black54)),
                                if (selectedAddress.phoneNumber != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(selectedAddress.phoneNumber!, style: const TextStyle(color: Colors.black54)),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// --- Price Details ---
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _cardDecoration(),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(LocaleKeys.price_details_title.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff3e2723))),
                          ),
                          const SizedBox(height: 14),
                          _priceRow(LocaleKeys.subtotal.tr(), "\$${subtotal.toStringAsFixed(2)}", titleColor: const Color(0xff8d6c63)),
                          const SizedBox(height: 8),
                          _priceRow(LocaleKeys.shipping.tr(), "\$${shipping.toStringAsFixed(2)}", titleColor: const Color(0xff8d6c63)),
                          const Divider(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.total.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xff3e2723))),
                              Text("\$${total.toStringAsFixed(2)}", style: TextStyle(color: lightBrown, fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// --- Terms ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3ECE3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        LocaleKeys.terms_text.tr() ,
                        style: TextStyle(fontSize: 11, color: Color(0xff6d4c41)),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 20), // مسافة بديلة للـ Spacer

                    /// --- Payment Button ---
                    InkWell(
                      onTap: () {
                        // أكشن الدفع
                      },
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xff6B4A3A), Color(0xff8B5E4A), Color(0xffA47154)]),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child:  Center(
                          child: Text(LocaleKeys.continue_to_payment_btn.tr(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return  Center(child: Text(LocaleKeys.loading_card_details.tr()));
        },
      ),
    );
  }

  Widget _productItem({required String image, required String name, required String price, required String qty}) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image, height: 50, width: 50, fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff3e2723), fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(qty, style: const TextStyle(color: Color(0xff8d6c63), fontSize: 12))
            ],
          ),
        ),
        const SizedBox(width: 5),
        Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff6d4c41)))
      ],
    );
  }

  Widget _priceRow(String title, String price, {Color titleColor = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: titleColor, fontSize: 16)),
        Text(price, style: const TextStyle(color: Color(0xff3e2723), fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: const Color(0xff8d6e63).withOpacity(.05), blurRadius: 10, offset: const Offset(0, 5))],
    );
  }
}