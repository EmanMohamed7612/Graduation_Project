import 'package:flutter/material.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryBrown = const Color(0xff6B4A3A);
    Color lightBrown = const Color(0xffC9A875);

    return Scaffold(
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

            /// Order Items Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: _cardDecoration(),
              child: Column(
                children: [

                  Row(
                    children:  [
                      Image.asset(
                        "assets/images/inventory icone.png",

                      ),
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
                      qty: "Qty: 1"),

                  const SizedBox(height: 10),

                  _productItem(
                      image:
                      "https://images.unsplash.com/photo-1611599537845-1c7aca0091c0",
                      name: "Handmade Necklace",
                      price: "\$64",
                      qty: "Qty: 2"),
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

                      Text(
                        "Change",
                        style: TextStyle(
                            color: lightBrown,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xffF1E8DA),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Ahmad Salem",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "14 El-Shahed Street\nDowntown Cairo, Egypt",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Price Details
            /// Price Details Card
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
                            color: Color(0xff3e2723)
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 14),

                  _priceRow("Subtotal:", "\$109.00",titleColor: Color(0xff8d6c63),priceColor: Color(0xff3e2723)),
                  const SizedBox(height: 8),
                  _priceRow("Shipping:", "\$5.00",titleColor: Color(0xff8d6c63),priceColor: Color(0xff3e2723)),

                  const Divider(height: 25),

                  Row(
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,color: Color(0xff3e2723)
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$114.00",
                        style: const TextStyle(
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

            /// Terms Container (منفصل مثل الصورة)
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

            /// Continue Button
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff6B4A3A),
                      Color(0xff8B5E4A),
                      Color(0xffA47154),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14)),
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
    );
  }

  /// product item
  Widget _productItem(
      {required String image,
        required String name,
        required String price,
        required String qty}) {
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
                  style: const TextStyle(fontWeight: FontWeight.w600,color: Color(0xff3e2723))),

              Text(qty,
                  style: const TextStyle(color: Color(0xff8d6c63), fontSize: 12))
            ],
          ),
        ),

        Text(price,
            style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xff6d4c41)))
      ],
    );
  }

  /// price row
  Widget _priceRow(String title, String price,
      {Color titleColor = Colors.black, Color priceColor = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 16,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: priceColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// card decoration
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Color(0xff8d6e63).withOpacity(.02),
              blurRadius: 20,
              offset: const Offset(0, 5))
        ]);
  }
}