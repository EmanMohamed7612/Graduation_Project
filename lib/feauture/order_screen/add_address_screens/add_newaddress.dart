import 'package:flutter/material.dart';

import '../../product_screens/presentation/view/explore_prodect/widget/custom_navigationbar.dart';
import '../order_summary_screen.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryBrown = const Color(0xff6B4A3A);
    Color lightBrown = const Color(0xff8d6e63);

    return Scaffold(
      backgroundColor: Color(0xfffaf8f5),

      /// AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
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
                            decoration: BoxDecoration(
                                color: Color(0xffcfac59),
                                shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/person3.png",
                              width: 24,
                              height: 24,
                            )
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Personal Information",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff6d4e63)),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// Full Name
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Full Name *")),

                    const SizedBox(height: 6),

                    _textField("Enter your full name"),

                    const SizedBox(height: 12),

                    /// Phone
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Phone Number *")),

                    const SizedBox(height: 6),

                    _textField("+20 123 456 7890",
                        icon: Icons.phone_outlined),
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
                          decoration: BoxDecoration(
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

                    _textField("14 El-Shaheed Street"),

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

                              _textField("Cairo"),
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

                              _textField("Downtown"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// Note
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

              // const Spacer(),

              /// Buttons
              Row(
                children: [

                  /// Cancel
                  Expanded(
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

                  const SizedBox(width: 10),

                  /// Save
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: primaryBrown,
                          borderRadius: BorderRadius.circular(14)),
                      child:  Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                builder: (context) =>
                                    OrderSummaryScreen(),
                                 )
                                 );
                          },
                          child: Text(
                            "Save Address",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),

      /// Bottom Navigation

    );
  }

  /// TextField
  Widget _textField(String hint, {IconData? icon}) {
    return TextField(
      style: const TextStyle(
        color: Color(0xff3e2723), // لون النص
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

        /// البوردر العادي
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Color(0xffd7ccc8),
            width: 1,
          ),
        ),

        /// البوردر لما تضغطي على الحقل
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

  /// Card decoration
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