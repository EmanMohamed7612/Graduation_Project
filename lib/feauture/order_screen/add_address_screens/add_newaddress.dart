
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../deliver_screen/manager/getuseraddress_cubit.dart';
import '../order_summary/order_summary_screen.dart';

import 'data/add_address_model.dart';
import 'manager/add_address_cubit.dart';
import 'manager/add_address_state.dart';    // تأكدي من مسار الستيت

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  // تعريف الـ Controllers لجمع البيانات من الحقول
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
    // Color lightBrown = const Color(0xff8d6e63); // لم يُستخدم في التصميم الأصلي

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
          children: const [
            Text(
              "Add New Address",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              "Enter your delivery details",
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
              /// Personal Information
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
                            child: Image.asset(
                              "assets/images/person3.png",
                              width: 24,
                              height: 24,
                            )),
                        const SizedBox(width: 10),
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6d4e63)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Full Name *")),
                    const SizedBox(height: 6),
                    _textField("Enter your full name", controller: nameController),
                    const SizedBox(height: 12),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Phone Number *")),
                    const SizedBox(height: 6),
                    _textField("+20 123 456 7890",
                        icon: Icons.phone_outlined, controller: phoneController),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// Address Details
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
                          child: const Icon(Icons.home_outlined,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Address Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Street Address *")),
                    const SizedBox(height: 6),
                    _textField("14 El-Shaheed Street", controller: streetController),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        /// City
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("City *"),
                              const SizedBox(height: 6),
                              _textField("Cairo", controller: cityController),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        /// Region
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Region *"),
                              const SizedBox(height: 6),
                              _textField("Downtown", controller: regionController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xffF5EFE6),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 18, color: Colors.brown),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Note: Please ensure all information is accurate. Our delivery team will contact you using the phone number provided.",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Buttons
              Row(
                children: [
                  /// Cancel
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryBrown),
                            borderRadius: BorderRadius.circular(14)),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  /// Save
                  Expanded(
                    child: BlocConsumer<AddAddressCubit, AddAddressState>(
                      listener: (context, state) {
                        if (state is AddAddressSuccess) {
                          // 1. إظهار رسالة النجاح
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم حفظ العنوان بنجاح"),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // 2. تحديث قائمة العناوين في الـ Cubit الأساسي عشان تظهر فوراً
                          context.read<AddressCubit>().fetchAddresses();

                          // 3. الانتقال لصفحة ملخص الطلب
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderSummaryScreen(),
                            ),
                          );
                        } else if (state is AddAddressError) {
                          // إظهار رسالة الخطأ في حال حدوث مشكلة
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          onTap: state is AddAddressLoading
                              ? null // تعطيل الزر أثناء التحميل لمنع التكرار
                              : () {
                            // التحقق من الحقول المطلوبة قبل الإرسال
                            if (nameController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                streetController.text.isEmpty ||
                                cityController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("يرجى ملء جميع الحقول المطلوبة *")),
                              );
                              return;
                            }

                            // تجهيز البيانات وإرسالها للـ Cubit
                            final model = AddAddressModel(
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
                              color: const Color(0xff6B4A3A), // primaryBrown
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: state is AddAddressLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                "Save Address",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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

  /// TextField المعدل ليستقبل Controller
  Widget _textField(String hint, {IconData? icon, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Color(0xff3e2723),
      ),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xff8d6e63),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color(0xffd7ccc8),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color(0xff8d6e63),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4))
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/pref_helpers.dart';
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
          children: const [
            Text(
              "Add New Address",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              "Enter your delivery details",
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
                            child: Image.asset(
                              "assets/images/person3.png",
                              width: 24,
                              height: 24,
                            )),
                        const SizedBox(width: 10),
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6d4e63)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Full Name *")),
                    const SizedBox(height: 6),
                    _textField("Enter your full name", controller: nameController),
                    const SizedBox(height: 12),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Phone Number *")),
                    const SizedBox(height: 6),
                    _textField("+20 123 456 7890",
                        icon: Icons.phone_outlined, controller: phoneController),
                  ],
                ),
              ),

              const SizedBox(height: 15),

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
                          child: const Icon(Icons.home_outlined,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Address Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Street Address *")),
                    const SizedBox(height: 6),
                    _textField("14 El-Shaheed Street", controller: streetController),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("City *"),
                              const SizedBox(height: 6),
                              _textField("Cairo", controller: cityController),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Region *"),
                              const SizedBox(height: 6),
                              _textField("Downtown", controller: regionController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xffF5EFE6),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 18, color: Colors.brown),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Note: Please ensure all information is accurate. Our delivery team will contact you using the phone number provided.",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

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
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BlocConsumer<AddAddressCubit, AddAddressState>(
                      listener: (context, state) {
                        if (state is AddAddressSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم حفظ العنوان بنجاح"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          context.read<AddressCubit>().fetchAddresses();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderSummaryScreen(),
                            ),
                          );
                        } else if (state is AddAddressError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          onTap: state is AddAddressLoading
                              ? null
                              : () async { // 🔹 تعديل هنا (async)
                            if (nameController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                streetController.text.isEmpty ||
                                cityController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("يرجى ملء جميع الحقول المطلوبة *")),
                              );
                              return;
                            }

                            // 🔹 جلب الـ ID المخزن (يجب أن يكون مخزناً عند الـ Login)
                            final String? userId = await PrefHelpers.getUserId();

                            final model = AddAddressModel(
                              appUserId: userId, // 🔹 إرسال الـ ID للسيرفر
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
                              color: const Color(0xff6B4A3A),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: state is AddAddressLoading
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                                  : const Text(
                                "Save Address",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
      style: const TextStyle(
        color: Color(0xff3e2723),
      ),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xff8d6e63),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color(0xffd7ccc8),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color(0xff8d6e63),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4))
      ],
    );
  }
}