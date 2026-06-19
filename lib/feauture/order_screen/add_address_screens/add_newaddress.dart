

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/pref_helpers.dart';
import '../../../generated/locale_keys.g.dart';
import '../deliver_screen/manager/getuseraddress_cubit.dart';
import '../order_summary/order_summary_screen.dart';

import 'data/add_address_model.dart';
import 'manager/add_address_cubit.dart';
import 'manager/add_address_state.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    regionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryBrown = const Color(0xff6B4A3A);

    return Scaffold(
      backgroundColor: const Color(0xfffaf8f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              LocaleKeys.add_address_title.tr(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              LocaleKeys.delivery_details_subtitle.tr(),
              style: TextStyle(color: Color(0xff8d6e63), fontSize: 12),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Personal Information Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Color(0xffcfac59),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.person_outline, color: Colors.white, size: 20)),
                        const SizedBox(width: 10),
                        Text(
                          LocaleKeys.personal_info_label.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6d4e63)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Align(alignment: Alignment.centerLeft, child: Text(LocaleKeys.full_name_hint.tr())),
                    const SizedBox(height: 6),
                    _textField(LocaleKeys.full_name_field.tr(), controller: nameController),
                    const SizedBox(height: 12),
                    Align(alignment: Alignment.centerLeft, child: Text(LocaleKeys.phone_number_hint.tr())),
                    const SizedBox(height: 6),
                    _textField(LocaleKeys.phone_number_hint.tr(), icon: Icons.phone_outlined, controller: phoneController),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// Address Details Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: Color(0xffcfac59),
                              shape: BoxShape.circle),
                          child: const Icon(Icons.home_outlined, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Text(LocaleKeys.address_details_label.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Align(alignment: Alignment.centerLeft, child: Text("Street Address *")),
                    const SizedBox(height: 6),
                    _textField(LocaleKeys.street_address_field.tr(), controller: streetController),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.city_hint.tr()),
                              const SizedBox(height: 6),
                              _textField(LocaleKeys.city_field.tr(), controller: cityController),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.region_hint.tr()),
                              const SizedBox(height: 6),
                              _textField(LocaleKeys.region_field.tr(), controller: regionController),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Buttons Section
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryBrown),
                            borderRadius: BorderRadius.circular(14)),
                        child:  Center(child: Text(LocaleKeys.cancel.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BlocConsumer<AddAddressCubit, AddAddressState>(
                      listener: (context, state) {
                        if (state is AddAddressSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(LocaleKeys.success_save_msg.tr()), backgroundColor: Colors.green),
                          );

                          // تحديث قائمة العناوين في الخلفية
                          context.read<AddressCubit>().fetchAddresses();

                          // 🔹 تجهيز موديل العنوان الذي تم إدخاله حالياً لنقله مباشرة للملخص
                          final currentAddress = AddAddressModel(
                            fullName: nameController.text,
                            phoneNumber: phoneController.text,
                            city: cityController.text,
                            streetDetails: streetController.text,
                            region: regionController.text,
                          );

                          // 🔹 الانتقال للملخص مع تمرير العنوان الجديد فوراً
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderSummaryScreen(
                                selectedAddress: currentAddress,
                              ),
                            ),
                                (route) => route.isFirst, // لتنظيف الـ Stack
                          );
                        } else if (state is AddAddressError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                          );
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          onTap: state is AddAddressLoading
                              ? null
                              : () async {
                            if (nameController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                streetController.text.isEmpty ||
                                cityController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(LocaleKeys.validation_error_msg.tr())),
                              );
                              return;
                            }

                            final String? userId = await PrefHelpers.getUserId();
                            final model = AddAddressModel(
                              appUserId: userId,
                              fullName: nameController.text,
                              phoneNumber: phoneController.text,
                              city: cityController.text,
                              streetDetails: streetController.text,
                              region: regionController.text,
                            );

                            context.read<AddAddressCubit>().addNewAddress(model);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryBrown,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: state is AddAddressLoading
                                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  :  Text(LocaleKeys.save_address_btn.tr(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(String hint, {IconData? icon, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xff3e2723)),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, size: 20) : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xff8d6e63), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xffd7ccc8))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xff8d6e63), width: 1.5)),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(.03), blurRadius: 10, offset: const Offset(0, 4))],
    );
  }
}